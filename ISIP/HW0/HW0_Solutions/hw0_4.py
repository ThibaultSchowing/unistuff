# # Exercise 0.4
# Considering two 1 dimensional arrays, calculate the root mean square error between them.
# Check your function for arrays of known difference.
import numpy as np
import sys
import matplotlib.pyplot as plt


# Define two arrays of length 100, and assign random values to them.
x = np.random.rand(100)
y = np.random.rand(100)
len(x), len(y)

# Write a function rmse(x,y) that calculates the RMSE (root mean square error) between two 1-d arrays of size N.
# Can you think of a way to calculate the RMSE without using any for loop? (hint: Check numpy's dot product function)
def rmse(x,y):
    if len(x) != len(y):
        raise ValueError('The two arrays should have the same size')
    else:
        # your own code should go here
        mse = 0
        # loop calculation of RMSE
        for i in range(len(x)):
            mse += (x[i] - y[i])**2
        rmse = np.sqrt(mse/len(x))
        # array calculation of mse
        error = x-y
        rmse2 = np.sqrt(np.dot(error, error)/len(x))
        return rmse


# Calculate the RMSE between arrays x and y
rmse_xy = rmse(x, y)
print(f'The RMSE(x,y) is {rmse_xy}')

# Check your function through the degenerate case of the RMSE between array x and itself.
rmse_x = rmse(x, x)
print(f'The RMSE(x,x) is {rmse_x}')

# Define an array with an offset of 2 from the values of x. What do you expect the RMSE to be? Confirm by using your function.
offset = 2
x_off = x + offset
rmse_off = rmse(x,x_off)
print(f'The expected RMSE between x and its offsetted self is {offset}, and is indeed calculated as {rmse_off}')


# Assume you have the function of Exercise 0 ( f(x) = cos(x * exp(-x/100)) + sqrt(x) + 1 ), for x in [0,100] and you want to approximate it
# with the line g(x) = ax, a = 0.3. Plot the two lines on the same figure, and visually check if this is a good approximation.
# copied from exercise 0
def f(x):
    y =  np.cos(x * np.exp(-x/100)) + np.sqrt(x) + 1
    return y

x = np.arange(0, 100)
g_x = 0.3*x
f_x = f(x)
plt.plot(f_x, label='f(x)')
plt.plot(g_x, label='g(x)')
plt.legend(loc=0)
plt.show()

# Calculate the RMSE between f(x) and g(x) for the given range
rmse_fg = rmse(f_x, g_x)
print(rmse_fg)

# Try to tune the parameter $a$ of the function g(x) with x in [0,100], so that you achieve a lower error. (
# hint: try different values of $a$ in an interval that makes sense for you, e.g. a in [0, 0.5]).
# Plot the RMSE for the different values of a and use the numpy.min() function to choose the optimal a with respect to the RMSE.
# Print the minimum RMSE value, and the value of $a$ for which it was achieved.
a = np.arange(0, 0.5, 0.01)
rmse_a = np.asarray([])
for a_i in a:
    rmse_a = np.append(rmse_a, (rmse(f(x), a_i*x)))
    
plt.plot(a, rmse_a)
plt.show()
min_rmse = np.min(rmse_a)
opt_a = np.where(rmse_a == min_rmse)
print(f'The minimum RMSE is {min_rmse} and is achieved for a={a[opt_a]}')
