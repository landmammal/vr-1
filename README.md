TestingVideoreharser.com is training management platform for enterprises build through the power of the rehearser API.
Runing the app locally:


Make sure on your machine, you install:
ruby 2.3.1
rails 5.0.0.1

If you are using a windows machine, it would be advised to install a VM with UBUNTU installed.

You can either Clone or Fork the repo:
To Clone: 
    click on the `clone or download link`

To Fork: 
    click on the `Fork` button out repo and send it over to your own Repo.
    You can then clone the videorehearser repo from your account.

Once you have cloned the repo down.

cd into repo from terminal

1) $ cd videorehearser

bunlde install to install all the dependencies from the project.

2) $ bundle install

create database load schema run any additional migrations and load seed data

3) $ rails db:create db:migrate db:seed

now you will need an enviroment variable 

4) $ touch .env 

now you will need to provide vR with the token generate it from rehearser api

5) $ echo "REHEARSER_APP_TOKEN: 'JWT token' " >> file

start server

6) $ rails server

To access the app's console you can open another terminal window and run

7) $ rails console


# Extra steps after FORKING:

make sure teh origin is pointing you own repo

8) $ git remote -v

add the upstream to our main repo

9) $ git remote add upstream https://github.com/cdginnovations/vr.git

Now you can push to `origin`: your own repo, and then after submitting a pullrequest, you can later fetch and merge master from  `upstream`: the main Repo.
PS: NEVER PUSH to the main repo's `master`, always work on a branch
PS: if forking out repo, NEVER push to `upstream`/`master`, always push to your own and make a pull request.
