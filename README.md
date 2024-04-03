## To up the project from scratch:
1. Create a new folder somewhere called `Exentriq` (any name)
2. Go inside that folder and clone this repo
3. Go inside a new clone repo `cd Exentriq-Docker`
4. If you are going to run the project using Docker then run the command
``sh scripts/clone-repos.sh``
and then run `docker compose watch` (still in progress, only EMA is done)
5. if you are going to run the project without Docker then run the command
``sh scripts/start.sh``; following this way you also need to install MongoDB and Redis manually
