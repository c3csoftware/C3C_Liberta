@isTest
public with sharing class ChecklistServiceTest 
{
    public static Map<String, ClassTested> mapClassTested = new Map<String, ClassTested>();

    public static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('PerguntaService', Test.createStub(PerguntaService.class, new PerguntaServiceStub()));

        C3C_DIContainer_Injector.createInstance('RespostaService', Test.createStub(RespostaService.class, new RespostaServiceStub()));

        C3C_DIContainer_Injector.createInstance('InstanciaRespostaService', Test.createStub(InstanciaRespostaService.class, new InstanciaRespostaServiceStub()));

        C3C_DIContainer_Injector.createInstance('BuscarInformacoesTarefaService',Test.createStub(BuscarInformacoesTarefaService.class, new BuscarInformacoesTarefaServiceStub()));

        C3C_DIContainer_Injector.createInstance('PerguntaViewModel', PerguntaViewModel.class, 'ChecklistServiceTest.PerguntaViewModelStub');
    }

    // TESTES

    @isTest
    static void testObterListaPerguntaViewModel()
    {
        // GIVEN
        setupInjector();
        
        // new ChecklistService().obterListaPeguntaViewModel('');
    }

    @isTest 
    static void testeSalvarRespostasDaTarefa()
    {
        setupInjector();
        String idTarefa = fflib_IDGenerator.generate(Task.getSObjectType());

        // new CheckListService().salvarRespostasDaTarefa(idTarefa, new List<PerguntaViewModel>{
        //     (PerguntaViewModel) C3C_DIContainer_Injector.newInstance('PerguntaViewModel', new Map<String, Object>{
        //         'pergunta' => (PerguntaMapper) C3C_DIContainer_Injector.newInstance('PerguntaMapper', Schema.getGlobalDescribe().get('Pergunta__c').newSObject()),
        //         'listaDeRespostasDisponiveis' => new List<RespostaMapper>(),
        //         'listaDeRespostasRespondidas' => new List<InstanciaRespostaMapper>()
        //     })
        // });
    }

    // STUBS

    public class LeadDomainStub extends C3C_AbstractStub implements System.StubProvider
    {     
        public override String getClassName()
        {
            return 'LeadDomain';
        }
    
        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }
        
        public override Object methodCall(
            Object stubbedObject, 
            String stubbedMethodName,
            Type returnType, 
            List<System.Type> listOfParamTypes, 
            List<String> listOfParamNames,
            List<Object> listOfArgs
        )
        {
            Object returnValue;
            
            
            switch on stubbedMethodName
            {
                when 'criarLead'
                {
                    returnValue = (LeadMapper) C3C_DIContainer_Injector.newInstance('LeadMapper', Schema.getGlobalDescribe().get('Lead').newSObject());
                }
            }
            
            return returnValue;
        }
    }

    public class PerguntaServiceStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'PerguntaService';
        }

        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }

        public override Object methodCall(
            Object stubbedObject, 
            String stubbedMethodName,
            Type returnType, 
            List<System.Type> listOfParamTypes, 
            List<String> listOfParamNames,
            List<Object> listOfArgs
        )
        {
            Object returnValue;
            
            
            switch on stubbedMethodName
            {
                when 'obterPerguntasPorTipoTarefa'
                {
                    returnValue = new List<IPerguntaDomain>{
                        (IPerguntaDomain) C3C_DIContainer_Injector.newInstance('PerguntaDomain', Schema.getGlobalDescribe().get('Pergunta__c').newSObject())
                    };
                }

            }
            
            return returnValue;
        }
    }

    public class RespostaServiceStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'RespostaService';
        }

        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }

        public override Object methodCall(
            Object stubbedObject, 
            String stubbedMethodName,
            Type returnType, 
            List<System.Type> listOfParamTypes, 
            List<String> listOfParamNames,
            List<Object> listOfArgs
        )
        {
            Object returnValue;
            
            
            switch on stubbedMethodName
            {
                when 'obterRespostasPorListaIdPergunta'
                {
                    returnValue = new List<IRespostaDomain>{
                        (IRespostaDomain) C3C_DIContainer_Injector.newInstance('RespostaDomain', Schema.getGlobalDescribe().get('Resposta__c').newSObject())
                    };
                }

            }
            
            return returnValue;
        }
    }

    public class InstanciaRespostaServiceStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'InstanciaRespostaService';
        }

        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }

        public override Object methodCall(
            Object stubbedObject, 
            String stubbedMethodName,
            Type returnType, 
            List<System.Type> listOfParamTypes, 
            List<String> listOfParamNames,
            List<Object> listOfArgs
        )
        {
            Object returnValue;
            
            
            switch on stubbedMethodName
            {
                when 'obterInstanciaRespostaPorIdTarefa'
                {
                    returnValue = new List<IInstanciaRespostaDomain>{
                        (IInstanciaRespostaDomain) C3C_DIContainer_Injector.newInstance('InstanciaRespostaDomain', Schema.getGlobalDescribe().get('InstanciaResposta__c').newSObject())
                    };
                }

            }
            
            return returnValue;
        }
    }

    public class BuscarInformacoesTarefaServiceStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'BuscarInformacoesTarefaService';
        }

        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }

        public override Object methodCall(
            Object stubbedObject, 
            String stubbedMethodName,
            Type returnType, 
            List<System.Type> listOfParamTypes, 
            List<String> listOfParamNames,
            List<Object> listOfArgs
        )
        {
            Object returnValue;
            
            
            switch on stubbedMethodName
            {
                when 'obterTarefaPorId'
                {
                    returnValue = (ITaskDomain) C3C_DIContainer_Injector.newInstance('TaskDomain', Schema.getGlobalDescribe().get('Task').newSObject());
                }

            }
            
            return returnValue;
        }
    }

    public class PerguntaViewModelStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'PerguntaViewModel';
        }

        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }

        public override Object methodCall(
            Object stubbedObject, 
            String stubbedMethodName,
            Type returnType, 
            List<System.Type> listOfParamTypes, 
            List<String> listOfParamNames,
            List<Object> listOfArgs
        )
        {
            Object returnValue;
            
            
            switch on stubbedMethodName
            {
                when 'newInstance'
                {
                    returnValue = new List<PerguntaViewModel>{
                        (PerguntaViewModel) C3C_DIContainer_Injector.newInstance('PerguntaViewModel', new Map<String, Object>{
                            'pergunta' => C3C_DIContainer_Injector.newInstance('PerguntaMapper', Schema.getGlobalDescribe().get('Pergunta__c').newSObject()),
                            'listaDeRespostasDisponiveis' => new List<RespostaMapper>(),
                            'listaDeRespostasRespondidas' => new List<InstanciaRespostaMapper>()
                        })
                    };
                }

            }
            
            return returnValue;
        }
    }


    @isTest 
    static void testCoverage()
    {
        ChecklistService.testCoverage();
    }
}