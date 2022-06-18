HOME	=	/home/rmechety/
DOCKER	=	docker-compose


all		:
	mkdir -p $(HOME)data/wordpress
	mkdir -p $(HOME)data/db_data
	$(DOCKER) -f srcs/docker-compose.yml build
	$(DOCKER) -f srcs/docker-compose.yml up

stop	:
	$(DOCKER) -f srcs/docker-compose.yml stop

clean:
	docker volume ls -qf dangling=true | xargs -r docker volume rm
	docker system prune -f -a

fclean: stop clean
	sudo rm -rf ${HOME}data

re : fclean all

#My personal rules

git :
	git add --all
	git commit
	git push

get_src:
		@find $(SRC_DIR) -type f -name "*.c" | tr "\n" "|" | sed -r 's/["|"]+/\\ \n/g'

run: all
	./$(NAME) $(PARAM)

leaks: all
	 valgrind --tool=memcheck --leak-check=full --show-leak-kinds=all --leak-resolution=high --show-reachable=yes --trace-children=yes --verbose --log-file=valgrind.log ./push_swap 10 9 8 7 6 5

get_dir:
		@find $(SRC_DIR) -type d | tr "\n" "|" | sed -r 's/["|"]+/\\ \n/g' | sed -e 's/$(SRC_DIR)\///g'

header :
	@Headermaker $(SRC_DIR) $(INC_DIR)/prototypes.h -inc structs define


.PHONY: all clean fclean re