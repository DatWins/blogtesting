push_blog: 
	git add . && git commit -m "Update" && git push

rebuild_public: 
	make clean_public && hugo

clean_public: 
	rm -r public/*

push_public: 
	make rebuild_public && cd public && git add . && git commit -m "Site update" && git push