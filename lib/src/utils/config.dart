class ProjectConfig {
  // APP IDENTIFICATORS
  static const FACEBOOK_APP_ID = '486754072397510';

  // API KEYS
  static const GOOGLE_MAP_API_KEY = 'AIzaSyC-8bUGfGfITT3ZmE3NZsx9vkc7Ujrx_VA';
  static const GOOGLE_GEOCODING_API_KEY_ANDROIRD = '***';
  static const STRIPE_PUBLISHABLE_API_KEY = 'pk_live_51KKF7jJ5CFzr0URyxL9dDvB2RbkwxcUPZu6YXqAOetaPtDNfPevIJ2MjMG9nYKwmYkSN9sJyzFCo7QN89PluXvkE00KYn0nQKc';
  static const STRIPE_PUBLISHABLE_API_KEY_TEST = '***';
  static const STRIPE_MERCHANT_IDENTIFIER = '***';

  //PORTS
  static const int DJANGO_PORT = 80;
  static const int RTMP_PORT = 1935;
  static const int WS_PORT = 3003;
  //IPs
  static const String SERVER_IP = '192.168.116.156';
  // static const String SERVER_IP = '10.0.0.2';


  //SERVICES
  static const String REST = 'http://$SERVER_IP:$DJANGO_PORT';
  static const String RTMP = 'rtmp://$SERVER_IP:$RTMP_PORT';
  static const String WS = 'ws://$SERVER_IP:$WS_PORT';

  //APP VERSION
  static const String APP_VERSION = '0.1.25_alpha';
}