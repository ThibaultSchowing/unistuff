# # Exercise 0.1
# You are given a function f(x). Create a function ex_0(a,b,c) that plots f(x) for x with c equally spaced numbers in the range of [a,b].
# If a and b are non-negative, plot the function and return 0, otherwise do not plot and return -1.
import numpy as np
import matplotlib.pyplot as plt

def f(x):
    y = np.cos(x * np.exp(-x/100)) + np.sqrt(x) + 1
    return y


def ex_0(a, b, c):
    if(a >= 0) and (b >= 0):
        x = np.linspace(a, b, num=c)
        y = f(x)
        plt.plot(x,y)
        return 0
    else:
        return -1
