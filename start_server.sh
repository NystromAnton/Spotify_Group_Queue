# Script for starting the node backend for PartyZone
# 20190417 18:41
echo "Forecfully closing applications on port 8888"
echo 3...
sleep 1
echo 2...
sleep 1
echo 1...
sleep 1
kill -9 $(lsof -t -i :8888)
echo "Port 8888 free"
echo "Starting server..."
appKey=7f7b041e7c2f4c49996c8ada2c641ca7 appSecret=97028381128a462aa7ee9b439b74771f callbackURL="https://auth.expo.io/@rednaxela5950/spotify-react-native" node AwesomeProject/server.js &
