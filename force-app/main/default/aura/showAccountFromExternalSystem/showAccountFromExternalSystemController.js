({
    doInit : function(cmp, event, helper) {
        var recordId = cmp.get("v.recordId");
        console.log('recordId '+recordId);
        var retrieveAccountInfo = cmp.get("c.retrieveAccountInfo");
        retrieveAccountInfo.setParam("recordId", recordId);
        retrieveAccountInfo.setCallback(this, function (response) {
            var message = response.getReturnValue();
            var messageParsed = JSON.parse(message);;
            cmp.set("v.data",message);
            cmp.set("v.datatree",messageParsed.accountTransactionList);
        });
        $A.enqueueAction(retrieveAccountInfo);
    }
})