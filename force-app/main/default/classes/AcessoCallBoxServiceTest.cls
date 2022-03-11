@isTest
public with sharing class AcessoCallBoxServiceTest 
{
    public static Map<String,ClassTested> mapClassTested = new Map<String,ClassTested>();

    @isTest
    static void testCoverage()
    {
        AcessoCallBoxService.testCoverage();
    } 

    public static void setupInjector()
    {
        C3C_DIContainer_Injector.createInstance('UserCallBoxViewModel', UserCallBoxViewModel.class, 'AcessoCallBoxServiceTest.UserCallBoxViewModelStub');

        C3C_DIContainer_Injector.createInstance('UserService', Test.createStub(UserService.class, new UserServiceStub()));
    }

    @isTest 
    static void testeObterInformacoesDoLoginCallBoxDoUsuarioAtual()
    {
        // GIVEN
        setupInjector();

        // WHEN
        new AcessoCallBoxService().obterInformacoesDoLoginCallBoxDoUsuarioAtual();

        // THEN

    }

    @isTest 
    static void testeSalvarInformacoesAcessoCallboxUsuarioAtual()
    {
        // GIVEN
        setupInjector();

        // WHEN
        new AcessoCallBoxService().salvarInformacoesAcessoCallboxUsuarioAtual('Teste', 'Senha');

        // THEN

    }

    public class UserCallBoxViewModelStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'UserCallBoxViewModel';
        }

        public override Map<String,ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }
    }

    public class UserServiceStub extends C3C_AbstractStub implements System.StubProvider
    {
        public override String getClassName()
        {
            return 'UserService';
        }

        public override Map<String, ClassTested> getMapClassTested()
        {
            return mapClassTested;
        }
    }
}