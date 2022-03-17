public with sharing class CreateAdjustmentController {
    private static String ENDPOINT = 'https://api.example.com/adjustments/';
    private static double ADJMAXVALUE = 1000;
    @AuraEnabled
    public static String createAdjustment(String caseId, String amount){
        Case caseRecord = [SELECT Account.externalSystemId__c 
                            FROM Case
                            WHERE id = :caseId];
        String endPoint = ENDPOINT+'v1/adjustment';
        CreateAdjRequest request = new CreateAdjRequest();
        RequestAmount reqAmount = new RequestAmount();
        Double amountNumber = Double.valueof(amount);
        reqAmount.amount = amount;
        //currency left hardcoded because there is no specification where to find the information
        reqAmount.currencyResponse = 'EUR';
        request.amount = reqAmount;
        request.accountId = caseRecord.Account.externalSystemId__c ;
        request.status = amountNumber < ADJMAXVALUE? 'CLOSED' : 'IN_PROGRESS';
        String requestBody = JSON.serialize(request);
        String response = HTTPServiceHelper.sendRequest(endpoint, requestBody, 'POST');
        //since the new adjustment has to be seen in the list of adjustments, here call the getAdjustment
        return '{"adjustmentId":"difjvuit.dfvndfi.","status":"'+request.status+'"}';
    }

    @AuraEnabled
    public static String getAdjustments(String caseId){
        System.debug('GET ADJUSTMENTSS');
        Case caseRecord = [SELECT Account.externalSystemId__c 
                            FROM Case
                            WHERE id = :caseId];
        system.debug('GET ADJUSTMENTSS QUERY CREATED');
        String endPoint = ENDPOINT+'v1/adjustments';
        RetrieveAdjRequest request = new RetrieveAdjRequest();
        request.accountId = caseRecord.Account.externalSystemId__c;
        //fake id because not specified where to find the info
        request.adjustmentId = 'fakeAdjustmentId';
        String requestBody = JSON.serialize(request);
        String response = HTTPServiceHelper.sendRequest(endpoint, requestBody, 'GET');
        system.debug('GET ADJUSTMENTSS QUERY before return');
        return '{"adjustments":[{"adjustmentId":"dfdfvdfmfg.fgbfg","status":"CLOSED"},{"adjustmentId":"ujujuju.dfvndfi.","status":"CLOSED"},{"adjustmentId":"gfbfgb.yjjuju","status":"IN_PROGRESS"},{"adjustmentId":"hgnghng.dfvndfi.","status":"CLOSED"}]}';
    }

    public class RetrieveAdjRequest{
        String adjustmentId;
        String accountId;
    }

    public class CreateAdjRequest{
        RequestAmount amount;
        String accountId;
        String status;
    }

    public class RequestAmount{
        String amount;
        String currencyResponse;
    }
}
