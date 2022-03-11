@isTest
public with sharing class InserirTarefaServiceTest 
{
    public static Map<String, ClassTested> mapClassTested = new Map<String, ClassTested>();
    
    static void setupInjector()
    {
		C3C_DIContainer_Injector.createInstance('fflib_SObjectUnitOfWork', fflib_ISObjectUnitOfWork.class, 'InserirTarefaServiceTest.fflib_SObjectUnitOfWorkStub');
        C3C_DIContainer_Injector.createInstance('C3C_APP_ApplicationContext', Test.createStub(C3C_APP_ApplicationContext.class, new C3C_APP_ApplicationContextStub()));
    }

    @isTest
    public static void testCriarListaDeTarefa()
    {
        //GIVEN
        setupInjector();
        
        //WHEN
        new InserirTarefaService().criarListaDeTarefa(new List<TaskDomain>{
            (TaskDomain) C3C_DIContainer_Injector.newInstance('TaskDomain'),
            (TaskDomain) C3C_DIContainer_Injector.newInstance('TaskDomain')
        });
        
        //THEN
        System.assert(mapClassTested.containsKey('fflib_SObjectUnitOfWork'), 'O método deveria chamar o fflib_SObjectUnitOfWork');
        System.assert(mapClassTested.get('fflib_SObjectUnitOfWork').containsMethod('commitWork'), 'Método deveria chamar o método "commitWork" da fflib_SObjectUnitOfWork');
    }

    @isTest
    public static void testCriarListaDeTarefaError()
    {
        //GIVEN
        setupInjector();
        
        //WHEN
        new InserirTarefaService().criarListaDeTarefa(new List<TaskDomain>());
        
        //THEN
        System.assert(mapClassTested.containsKey('fflib_SObjectUnitOfWork'), 'O método deveria chamar o fflib_SObjectUnitOfWork');
        System.assert(mapClassTested.get('fflib_SObjectUnitOfWork').containsMethod('commitWork'), 'Método deveria chamar o método "commitWork" da fflib_SObjectUnitOfWork');
    }

    public class fflib_SObjectUnitOfWorkStub extends C3C_AbstractStub implements System.StubProvider
    {        
        public override String getClassName()
        {
            return 'fflib_SObjectUnitOfWork';
        }
    
        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }
    }

    public class C3C_APP_ApplicationContextStub extends C3C_AbstractStub implements System.StubProvider
    {        
        public override String getClassName()
        {
            return 'C3C_APP_ApplicationContext';
        }
    
        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }
    }
}