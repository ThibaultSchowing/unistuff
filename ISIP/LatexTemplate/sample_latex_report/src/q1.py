import numpy as np
import matplotlib.pyplot as plt
import os

x = np.linspace(-2., 1., 100)
a = 2
b = 2.5
c = 0.5
y = a*x**2 + b*x + c

delta = b**2 -4*a*c
x_0 = (-b + np.sqrt(delta))/(2*a)
x_1 = (-b - np.sqrt(delta))/(2*a)

# red dashes, blue squares and green triangles
plt.plot(x,y)
plt.plot(x_0,0,'ro')
plt.plot(x_1,0, 'ro')
plt.title('My curve')
plt.xlabel('x')
plt.ylabel('y')
plt.grid()

#plt.show()
plt.savefig(os.path.join('..', 'pics', 'q1.eps'))
