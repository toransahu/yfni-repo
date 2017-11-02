#!/bin/python3

import sys

dir_of_interest = "D:\\Toran\\WorkSpace\\python-repo\\py-misc"
sys.path.append(dir_of_interest)

from timeit import exec_time


@exec_time
def min_move(hero, aquarium):
    count = 0
    if max(aquarium) < hero:
        return 0
    for fish in aquarium[::-1]:
        if hero > fish:
            hero += aquarium.pop()
        else:
            if (hero * 2 - 1) > fish:
                hero += (hero - 1)
                count += 1
                hero += aquarium.pop()
            else:
                aquarium.pop()
                count += 1
    return count


print("Enter input string")
a, b = input().strip().split('#')
hero = int(a)
aquarium = map(int, b.strip().split(','))
aquarium = sorted(aquarium, reverse=True)
print("Minimum count should be ", min_move(hero, aquarium))
 
