#!/usr/bin/env python3
# -*- coding: utf-8 -*-
 
import time, math, os, sys
 
# ===== Config =====
BARS = 4                 # número de barras visibles
FRAME = 0.12             # segundos entre frames (más chico = más fluido)
LEVELS = list("▁▂▃▄▅▆▇█")  # 8 niveles; puedes cambiar por ['▂','▃','▄','▅'] si quieres 4
EMA = 0.35               # suavizado (0.2 nervioso, 0.5 suave)
BREATH_LEVELS = 1        # amplitud del “latido” en niveles (0=sin latido)
BREATH_SPEED = 2.2       # velocidad del “latido” (rad/s)
 
def read_cpu_pairs():
    idle_total = []
    with open('/proc/stat') as f:
        for line in f:
            if line.startswith('cpu') and line[3].isdigit():
                parts = line.split()
                v = list(map(int, parts[1:]))
                idle = v[3] + v[4]          # idle + iowait
                total = sum(v[:8])          # total (sin guest)
                idle_total.append((idle, total))
    return idle_total
 
def usage(prev, curr):
    out = []
    for (pi, pt), (ci, ct) in zip(prev, curr):
        dt = ct - pt
        di = ci - pi
        busy = max(0, dt - di)
        out.append((busy / dt * 100.0) if dt > 0 else 0.0)
    return out
 
def group(vals, n):
    if not vals: return [0.0] * n
    if len(vals) == n: return vals
    chunk = len(vals) / n
    res = []
    for i in range(n):
        s = int(round(i * chunk))
        e = int(round((i + 1) * chunk))
        seg = vals[s:e] or [0.0]
        res.append(sum(seg) / len(seg))
    return res
 
def to_level(x):  # 0..100 -> índice de LEVELS
    i = int(round((len(LEVELS)-1) * max(0.0, min(100.0, x)) / 100.0))
    return max(0, min(len(LEVELS)-1, i))
 
def main():
    # arranque
    prev = read_cpu_pairs()
    time.sleep(FRAME)
    curr = read_cpu_pairs()
    base = group(usage(prev, curr), BARS)
    sm = base[:]
    t0 = time.time()
 
    while True:
        prev = curr
        time.sleep(FRAME)
        curr = read_cpu_pairs()
        raw = group(usage(prev, curr), BARS)
 
        # suavizado + “latido” independiente del CPU
        t = time.time() - t0
        out_chars = []
        for i in range(BARS):
            sm[i] = EMA * raw[i] + (1 - EMA) * sm[i]    # baseline suave
            # latido en niveles, desfasado por barra
            if BREATH_LEVELS > 0:
                phase = i * 0.9
                delta_levels = BREATH_LEVELS * math.sin(BREATH_SPEED * t + phase)
                # convertimos baseline % a nivel, le sumamos el latido, y devolvemos a glifo
                lvl = to_level(sm[i]) + int(round(delta_levels))
                lvl = max(0, min(len(LEVELS)-1, lvl))
            else:
                lvl = to_level(sm[i])
            out_chars.append(LEVELS[lvl])
 
        print(''.join(out_chars), flush=True)
 
if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        pass
