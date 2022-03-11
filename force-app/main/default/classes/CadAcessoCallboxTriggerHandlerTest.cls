@isTest
public with sharing class CadAcessoCallboxTriggerHandlerTest 
{
    public static Map<String, ClassTested> mapClassTested = new Map<String,ClassTested>();
    
    public static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('CadastroAcessoCallBoxService', Test.createStub(CadastroAcessoCallBoxService.class, new CadastroAcessoCallBoxServiceStub()));
        // C3C_DIContainer_Injector.createInstance('CadastrarAcessoAoCallboxDomain', ICadastrarAcessoAoCallboxDomain.class, 'CadAcessoCallboxTriggerHandlerTest.CadastrarAcessoAoCallboxDomainStub');
    }

    @isTest
    static void testeMainEntry()
    {
        setupInjector();

        new CadAcessoCallboxTriggerHandler().mainEntry(new TriggerParameters(null, New List<SObject>{
            Schema.getGlobalDescribe().get('CadastrarAcessoAoCallbox__e').newSObject(),
            Schema.getGlobalDescribe().get('CadastrarAcessoAoCallbox__e').newSObject()
        }, null, null, false, true, false, true, false,false,false));
    }

    public class CadastroAcessoCallBoxServiceStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'CadastroAcessoCallBoxService';
        }

        public override Map<String,ClassTested> getMapClassTested()
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
                when 'cadastrarOuAtualizarInformacoesAcessoCallboxNoUsuario'
                {
                    returnValue = null;
                }
            }
            
            return returnValue;
        }
    }

    public class CadastrarAcessoAoCallboxDomainStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'CadastrarAcessoAoCallboxDomain';
        }

        public override Map<String,ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }
    }
}