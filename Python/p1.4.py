# Q4: Convert a string number into integer, float, and string again, then print types.
num_str = input("Enter a number as string: ")

num_int = int(num_str)
num_float = float(num_str)
num_string = str(num_str)

print(num_int, type(num_int))
print(num_float, type(num_float))
print(num_string, type(num_string))
