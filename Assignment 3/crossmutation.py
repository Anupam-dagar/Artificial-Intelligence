import random


def convert_to_binary(number):
    # bin() converts an integer to binary format. Binary output is something like 0bxxxx
    # the binary number is after 0b thats why the string is considered from index 2.
    # list has been used to convert the binary number string into list so that each bit is at single index
    return list(bin(number)[2:])

# 1 point crossover


def one_point_crossover(binary_one, binary_two):
    # to calculate upper bound of crossover point, minimum of two is chosen so as to prevent IndexError
    size = min(len(binary_one), len(binary_two))
    # randomly chose a crossover point
    crossover_point = random.randint(0, size-1)

    print("crossover point index is: " + str(crossover_point) + '\n')

    # using list slicing, swap the list from crossover point till end
    binary_one[crossover_point:], binary_two[crossover_point:] = binary_two[crossover_point:], binary_one[crossover_point:]

    # prepare a dictionary so as to return both crossover binary numbers
    answer_dict = {"binary_one": binary_one, "binary_two": binary_two}

    return answer_dict


def two_point_crossover(binary_one, binary_two):
    # to calculate upper bound of crossover point, minimum of two is chosen so as to prevent IndexError
    size = min(len(binary_one), len(binary_two))

    # chose the crossover start and endpoint
    crossover_point_start = random.randint(0, size - 1)
    crossover_point_end = random.randint(0, size)

    # swap the start and end crossover point if in case randomly generated start point is greater than the end point.
    if crossover_point_start > crossover_point_end:
        crossover_point_start, crossover_point_end = crossover_point_end, crossover_point_start
    if crossover_point_start == crossover_point_end:
        crossover_point_end = crossover_point_end + 1

    print("Crossover start point index is: " + str(crossover_point_start))
    print("Crossover end point index is: " + str(crossover_point_end) + '\n')

    # perform the crossover
    binary_one[crossover_point_start:crossover_point_end], binary_two[crossover_point_start:crossover_point_end] = binary_two[crossover_point_start:crossover_point_end], binary_one[crossover_point_start:crossover_point_end]

    answer_dict = {'binary_one': binary_one, 'binary_two': binary_two}

    return answer_dict


def uniform_crossover(binary_one, binary_two):
    # to calculate upper bound of crossover point, minimum of two is chosen so as to prevent IndexError
    size = min(len(binary_one), len(binary_two))

    for index in range(size):
        # flip a coin i.e get a value either 0 or 1, change the bit opposite to the coin value
        coin_flip = random.randint(0, 1)
        binary_one[index] = str(coin_flip)
        if coin_flip is 0:
            binary_two[index] = '1'
        if coin_flip is 1:
            binary_two[index] = '0'

    answer_dict = {'binary_one': binary_one, 'binary_two': binary_two}

    return answer_dict


def mutation(binary_one, binary_two):
    # define a mutation rate so that if the probability is greater than this rate then only flip the bit.
    MUTATION_RATE = 0.5

    for index in range(len(binary_one)):
        # this generates a random number between 0 and 1.
        probability = random.random()
        if probability > MUTATION_RATE:
            binary_one = flip_bit(binary_one, index)

    for index in range(len(binary_two)):
        probability = random.random()
        if probability > MUTATION_RATE:
            binary_two = flip_bit(binary_two, index)

    answer_dict = {'binary_one': binary_one, 'binary_two': binary_two}

    return answer_dict

# function to flip the bit at a given index


def flip_bit(binary_list, index):
    if binary_list[index] is '0':
        binary_list[index] = '1'
    elif binary_list[index] is '1':
        binary_list[index] = '0'

    return binary_list


def one_bit_mutation(binary_one, binary_two):
    # generate a random index at which bit will be flipped.
    mutation_index = random.randint(0, len(binary_one)-1)
    print("mutation index for first parent is: " + str(mutation_index))

    binary_one = flip_bit(binary_one, mutation_index)

    mutation_index = random.randint(0, len(binary_two)-1)
    print("mutation index for second parent is: " + str(mutation_index) + '\n')

    binary_two = flip_bit(binary_two, mutation_index)

    answer_dict = {'binary_one': binary_one, 'binary_two': binary_two}

    return answer_dict

def uniform_mutation(binary_one, binary_two):
    MUTATION_RATE = 0.5

    size = min(len(binary_one), len(binary_two))
    mutation_start_index = random.randint(0,size-1)
    mutation_end_index = random.randint(0,size-1)

    if mutation_start_index > mutation_end_index:
        mutation_start_index, mutation_end_index = mutation_end_index, mutation_start_index
    if mutation_start_index == mutation_end_index:
        mutation_end_index = mutation_end_index + 1

    print("Mutation start point index is: " + str(mutation_start_index))
    print("Mutation end point index is: " + str(mutation_end_index) + '\n')

    for index in range(mutation_start_index, mutation_end_index+1):
        probability = random.random()
        if probability > MUTATION_RATE:
            binary_one = flip_bit(binary_one, index)
            binary_two = flip_bit(binary_two, index)
    
    answer_dict = {'binary_one': binary_one, 'binary_two': binary_two}

    return answer_dict

def main():
    parent_one = int(input("Enter first number\n"))
    parent_two = int(input("Enter second number\n"))

    print("parent number 1 is: " + str(parent_one))
    print("parent number 2 is: " + str(parent_two) + '\n')

    # convert numbers to binary
    parent_one = convert_to_binary(parent_one)
    parent_two = convert_to_binary(parent_two)

    print("binary conversion of 1 is: " + str(parent_one))
    print("binary conversion of 2 is: " + str(parent_two) + '\n')

    print("Select crossover to perform: ")
    print("1 for 1 point crossover.")
    print("2 for 2 point crossover.")
    print("3 for uniform crossover.")
    print("4 for complete mutation.")
    print("5 for one bit mutation.")
    print("6 for uniform mutation.")

    crossover_choice = int(input())

    # do the crossover
    if crossover_choice is 1:
        crossover_result = one_point_crossover(parent_one, parent_two)
        type_of_algorithm = "1 point crossover"
    elif crossover_choice is 2:
        crossover_result = two_point_crossover(parent_one, parent_two)
        type_of_algorithm = "2 point crossover"
    elif crossover_choice is 3:
        crossover_result = uniform_crossover(parent_one, parent_two)
        type_of_algorithm = "uniform crossover"
    elif crossover_choice is 4:
        crossover_result = mutation(parent_one, parent_two)
        type_of_algorithm = "complete mutation"
    elif crossover_choice is 5:
        crossover_result = one_bit_mutation(parent_one, parent_two)
        type_of_algorithm = "one bit mutation"
    elif crossover_choice is 6:
        crossover_result = uniform_mutation(parent_one, parent_two)
        type_of_algorithm = "uniform mutation"
    else:
        print("Option not available.")
        print("Exiting....")
        exit(1)

    # get the numbers back after crossover
    children_one = crossover_result.get('binary_one')
    children_two = crossover_result.get('binary_two')

    print("Children 1 after " + type_of_algorithm + " is: " + str(children_one))
    print("Children 2 after " + type_of_algorithm +
          " is: " + str(children_two) + '\n')

    # convert from list to string
    # .join is used to join elements of list, ''.join means join all elements of list together with '' i.e together without no space
    children_one = ''.join(children_one)
    children_two = ''.join(children_two)

    # convert from binary to integer
    # int function takes an argument at position two, specify base at that argument position, here the conversion base is 2. this converts the number to int from base 2.
    children_one = int(children_one, 2)
    children_two = int(children_two, 2)

    print("Children 1 in integer is: " + str(children_one))
    print("Children 2 in integer is: " + str(children_two))


main()
