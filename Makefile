##
## EPITECH PROJECT, 2021
## Project_2021
## File description:
## Project makefile
##

AS = nasm
cc = ld

SRC_DIR   = ./src/
SRC_FILES =	strlen.asm		\
			lib.asm			\
			strchr.asm		\
			memset.asm		\
			strncmp.asm		\
			memmove.asm		\
			strcmp.asm		\
			memcpy.asm		\

SRC 	= $(addprefix $(SRC_DIR), $(SRC_FILES))

SRC_UT = tests/tests_project.c

NAME=libasm.so
TEST_NAME=test.out

CFLAGS = -fPIC -shared -g
ASFLAGS=-f elf64 -g
LDFLAGS=
#LIBFLAGS=-shared

OBJ=$(SRC:.asm=.o)

all: $(NAME)

$(NAME): $(OBJ)
	$(CC) $(CFLAGS) $(OBJ) -o $@

tests_main: re
	gcc -W -Wall -Wextra tests/main.c -g -o $(TEST_NAME) -ldl

tests_run: fclean all
	@gcc  -W -Wall -Wextra $(SRC_UT) -o $(TEST_NAME) -ldl -lcriterion && ./$(TEST_NAME)

%.o: %.asm
	$(AS) $(ASFLAGS) $< -o $@

clean:
	rm -f $(OBJ)
	rm -f tests/*.o

fclean: clean
	rm -f $(NAME)

re: fclean all

.PHONY: clean fclean re
