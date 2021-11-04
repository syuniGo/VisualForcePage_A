
List<Bank_Account__c> insertList = new List<Bank_Account__c>();

for (Integer i = 0; i < 200; i++) {
    Bank_Account__c ba = new Bank_Account__c();
    ba.RecordTypeId='0125g000001syauAAA';
    ba.Name = 'test Bank Account'+i;
    ba.Branch__c ='a0D5g000004jUwdEAE';
    ba.Contact__c ='0035g00000GLaBOAA1';
    ba.Account__c = '0015g00000VerwmAAB';
    ba.starting_balance__c=50000+i*10;
    
    if (i<100) {
        ba.StartDate__c =date.today()+i*3;
        ba.EndDate__c = ba.StartDate__c.addDays(30);
    }else if(i>=100&&i<150){
        ba.StartDate__c =date.today().addMonths(i)+i*3;
    }else {
        ba.EndDate__c =date.today().addMonths(i)+i*3;
    }
    insertList.add(ba);    
}

insert insertList;
System.debug(Schema.SObjectType.Bank_Account__c.getRecordTypeInfosByName());