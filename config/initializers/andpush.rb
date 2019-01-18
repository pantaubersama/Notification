FCM_SERVER_KEY = ENV['FCM_SERVER_KEY'] # Your server key
SENDER_ID = ENV['SENDER_ID'] # Your server key

$fcm = Andpush.new(FCM_SERVER_KEY, pool_size: 25)
