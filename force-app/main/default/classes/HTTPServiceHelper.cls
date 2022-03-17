public with sharing class HTTPServiceHelper {
    public static String sendRequest(String endpoint, String requestBody, String method) {
        //call commented because service unavailable
        String token; //getToken();
        Http httpProtocol = new Http();
        HttpRequest request = new HttpRequest();
        request.setHeader('Authorization','BearerAuthOAuth '+ token);
        request.setEndPoint(endpoint);
        request.setMethod(method);
        String fakeresponse = 'fakeResponse';
        //line commented because service is fake
        // HttpResponse response = httpProtocol.send(request);
        // AccountTransactionResponse results = (AccountTransactionResponse) JSON.deserialize(response.getBody(), AccountTransactionResponse.class);
        //moke response creation
        return fakeResponse;
    }
}
