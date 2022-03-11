@isTest
public with sharing class TaskCallFactoryTest 
{
    public static Map<String,ClassTested> mapClassTested = new Map<String,ClassTested>();

    public static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('TaskCallDomain', ITaskCallDomain.class, 'TaskCallFactoryTest.TaskCallDomainStub');
    }

    @isTest 
    static void testeNovaInstanciaComCallboxChamadaViewModel()
    {
        setupInjector();
        // CallboxChamadaViewModel call = new CallboxChamadaViewModel();
        // call.dataInicioChamada = '01/01/2020';
        // call.dataTerminoChamada = '01/01/2020';
        // call.duracaoSegudos = 30;
        // call.idTarefaChamada = Schema.getGlobalDescribe().get('Task').newSObject().Id;
        // call.linkAcessarGravacaoChamada = 'Link';
        // call.numeroDestino = 'Numeroo';
        // call.ramalUtilizado = 'RamalPow';


        // TaskCallFactory.novaInstanciaComCallboxChamadaViewModel((CallboxChamadaViewModel)C3C_DIContainer_Injector.newInstance('CallboxChamadaViewModel'), 'Teste', 'Teste', 'Teste', 'Teste', 'Teste', 'Teste', Date.today());
    }
    
    public class TaskCallDomainStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'TaskCallDomain';
        }

        public override Map<String,ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }
    }

    @isTest 
    static void testeCoverage()
    {
        TaskCallFactory.testCoverage();
    }
}