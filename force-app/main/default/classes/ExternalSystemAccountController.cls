public class ExternalSystemAccountController{
    private static String ENDPOINT = 'https://api.example/accounts/v1/transactions/';

    @AuraEnabled
    public static String retrieveAccountInfo(String recordId){
        System.debug('Account id '+recordId);
        String accountExternalInfo;
        List<Account> account = [SELECT externalSystemId__c 
                                FROM Account
                                WHERE id = :recordId];
        if(account.size() == 1){
            accountExternalInfo = Json.serialize(retrieveInfo(account[0].externalSystemId__c,false,'fakeRequestId'));
            System.debug('nell if '+accountExternalInfo);
        }
        return accountExternalInfo;
    }

    private static AccountTransactionResponse retrieveInfo(String externalSystemId, boolean withBalanceQuery, String X_Request_ID){
        String endpoint = ENDPOINT+externalSystemId+'?withBalanceQuery='+withBalanceQuery+'&X-Request-ID='+X_Request_ID;

        String response = HTTPServiceHelper.sendRequest(endpoint, '', 'GET');
        AccountTransactionResponse responseBody = new AccountTransactionResponse();
        List<TransactionDetailsClass> transactions = new List<TransactionDetailsClass>();
        List<accountTransactionList> transactionLists = new List<accountTransactionList>();
        accountTransactionList transList1 = new accountTransactionList();
        TransactionDetailsClass transaction1 = new TransactionDetailsClass();
        transaction1.resourceId = 'fakeresourceId1';
        transaction1.name = 'fakeName1';
        transaction1.balanceType = 'closingBooked';
        ResponseAmount amount = new ResponseAmount();
        amount.amount = '300';
        amount.currencyResponse = 'EUR';
        transaction1.amount = amount;
        transaction1.transactionDate = '2020-04-25T15:30:35.035Z';
        TransactionDetailsClass transaction2 = new TransactionDetailsClass();
        transaction2.resourceId = 'fakeresourceId2';
        transaction2.name = 'fakeName2';
        transaction2.balanceType = 'closingBooked';
        ResponseAmount amount1 = new ResponseAmount();
        amount1.amount = '30000';
        amount1.currencyResponse = 'EUR';
        transaction2.amount = amount1;
        transaction2.transactionDate = '2020-04-25T15:30:35.035Z';
        transList1.iban = 'FR7630006000011234567890189';
        transList1.product = 'fakeProduct2';
        transactions.add(transaction1);
        transactions.add(transaction2);
        transList1.transactions = transactions;
        transactionLists.add(transList1);
        List<TransactionDetailsClass> transactions3 = new List<TransactionDetailsClass>();
        List<accountTransactionList> transactionLists3 = new List<accountTransactionList>();
        accountTransactionList transList3 = new accountTransactionList();
        TransactionDetailsClass transaction3 = new TransactionDetailsClass();
        transaction3.resourceId = 'fakeresourceId1';
        transaction3.name = 'fakeName1';
        transaction3.balanceType = 'closingBooked';
        ResponseAmount amount3 = new ResponseAmount();
        amount3.amount = '300111';
        amount3.currencyResponse = 'EUR';
        transaction3.amount = amount3;
        transaction3.transactionDate = '2021-04-25T15:30:35.035Z';
        TransactionDetailsClass transaction4 = new TransactionDetailsClass();
        transaction4.resourceId = 'fakeresourceId11';
        transaction4.name = 'fakeName11';
        transaction4.balanceType = 'closingBooked';
        ResponseAmount amount4 = new ResponseAmount();
        amount4.amount = '30000';
        amount4.currencyResponse = 'EUR';
        transaction4.amount = amount4;
        transaction4.transactionDate = '2020-04-25T15:30:35.035Z';
        transList3.iban = 'IT1111006000011234567890189';
        transList3.product = 'fakeProduct1';
        transactions3.add(transaction3);
        transactions3.add(transaction4);
        transList3.transactions = transactions;
        transactionLists.add(transList3);
        responseBody.accountTransactionList = transactionLists;
        System.debug('MAriaaaa responseBody '+responseBody);
        return responseBody;
    }

    private static string getToken(){
        String fakeToken = 'thisIsAFakeToken';
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:externalSystem/salesforce/oauth/token');
        req.setMethod('POST');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        System.debug(res.getBody());
        //since no endpoint is provided, a mock string is returned
        return fakeToken;
    }

    public class ExternalSystemError{
        String code;
        String message;
        String cid;
    }

    public class ResponseAmount{
        String amount;
        String currencyResponse;
    }

    public class TransactionDetailsClass{
        String resourceId;
        String name;
        String balanceType;
        ResponseAmount amount;
        String transactionDate;
    }

    public class accountTransactionList{
        String iban;
        String accountStatus;
        String product;
        List<TransactionDetailsClass> transactions = new List<TransactionDetailsClass>();
    }

    public class AccountTransactionResponse{
        List<accountTransactionList> accountTransactionList = new List<accountTransactionList>();
    }

    // public class ExternalSystemAccountResponse{
    //     ExternalSystemError error;
    //     AccountTransactionResponse accountTransactionResponse;
    // }
}