# Aplication to develop
https://github.com/imranvisualpath/vprofile-repo.git

# Create Dockerfile

# Download database file
curl -o db_backup.sql https://raw.githubusercontent.com/imranvisualpath/vprofile-repo/81f8246a65dfda224e49436681da32a5e1b8b330/Docker-db/db_backup.sql
curl -o nginvproapp.conf https://github.com/imranvisualpath/vprofile-repo/blob/81f8246a65dfda224e49436681da32a5e1b8b330/Docker-web/nginvproapp.conf

# Run docker compose
docker-compose up -d


# Run docker
sudo docker run -p 8080:80 -d --name vproapp appimg