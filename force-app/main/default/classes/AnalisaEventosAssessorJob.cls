public without sharing class AnalisaEventosAssessorJob implements Schedulable 
{
    public void execute(SchedulableContext sc) {
       Database.executeBatch(new AnalisaEventosAssessorBatch(), 1000);
    }
}