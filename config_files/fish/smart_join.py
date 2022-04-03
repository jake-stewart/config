#!/usr/bin/env python3

import fileinput
import sys

in_quote = False
quote_char = ""
quote = ""
output = ""

escaped = False

for line in fileinput.input():
    if not line.strip() and not in_quote:
        continue
    for char in line:
        if in_quote:
            if escaped:
                escaped = False
                quote += char
            elif char == "\\":
                escaped = True
                quote += char
            elif char == "\n":
                if len(quote):
                    output += quote_char + quote + quote_char
                    quote = ""
                output += "\\n"
                continue
            elif char == quote_char:
                if len(quote) > 0:
                    output += quote_char + quote + quote_char
                    quote = ""
                in_quote = False
            else:
                quote += char

        else:
            if escaped:
                if char == "\n":
                    output += "bruh"
                escaped = False
                output += char
            elif char == "\\":
                escaped = True
                output += char
            elif char in "'\"":
                in_quote = True
                quote_char = char
            elif char == "\n":
                output += "; "
            else:
                output += char
print(output[:-2])
# print("cat bruh")
