git clone https://github.com/MicrosoftDocs/mslearn-hotel-reservation-system.git
cd mslearn-hotel-reservation-system/src
#Put Dockerfile here

sudo docker build -t reservationsystem .

sudo docker run -p 8080:80 -d --name reservations reservationsystem
