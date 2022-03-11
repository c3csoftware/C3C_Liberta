@isTest
public with sharing class AnalisaEventosAssessorJobTest 
{
    @isTest 
    static void testeExecute()
    {
        Test.startTest();

        System.schedule('Teste de AnalisaEventosAsessorJov', '0 0 0 3 9 ? 2022', new AnalisaEventosAssessorJob());

        Test.stopTest();
    }
}