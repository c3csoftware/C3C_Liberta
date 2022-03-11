global without sharing class AceiteEventoBatch implements Database.Batchable<sObject> 
{
    global List<SObject> start(Database.BatchableContext BC)
    {
                return Database.query('');
    }
  
    global void execute(Database.BatchableContext BC, List<SObject> scope)
    {
        
    }

    global void finish(Database.BatchableContext BC){}
}