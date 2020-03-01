import numpy as np
import matplotlib.pyplot as plt


def ex_0(a, b, c):
    if (a < 0 | b < 0):
        return -1
    else:
        # a = start, b = end, c = space
        x = np.arange(a, b + 1, c)
        y = np.cos(x * np.exp(-x / 100)) + np.sqrt(x) + 1
        plt.plot(x, y)
        return 0


ex_0(1, 55, 2)