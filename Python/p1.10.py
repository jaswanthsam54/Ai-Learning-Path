# Q10: Take a decimal number and print its integer and fractional parts.
num = float(input("Enter a decimal number: "))

integer_part = int(num)
fractional_part = num - integer_part

print("Integer part:", integer_part)
print("Fractional part:", fractional_part)
