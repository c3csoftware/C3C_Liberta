public without sharing class CadAcessoCallboxTriggerHandler extends TriggerHandlerBase
{
    //
    //Exception
    //
    
    public class CadAcessoCallboxTriggerHandlerException extends Exception{}

    //
    //Construtores
    //

    public CadAcessoCallboxTriggerHandler() {}

    //
    //Métodos
    //
    public override void mainEntry(TriggerParameters tp) 
    {   
        List<ICadastrarAcessoAoCallboxDomain> listaNovosCadAcessoCallbox = (List<ICadastrarAcessoAoCallboxDomain>) C3C_DIContainer_Injector.newInstance('CadastrarAcessoAoCallboxDomain', tp.newList);

        this.instanciaCadastroAcessoCallboxService.cadastrarOuAtualizarInformacoesAcessoCallboxNoUsuario(listaNovosCadAcessoCallbox);
    }

    //
    //Atributos dos Serviços
    //

    //Atributo que armazenará a instância do serviço de CadastroAcessoCallBoxService
    private ICadastroAcessoCallBoxService instanciaCadastroAcessoCallboxService
    {
        get
        {
            if(this.instanciaCadastroAcessoCallboxService == null)
                this.instanciaCadastroAcessoCallboxService = (ICadastroAcessoCallBoxService) C3C_DIContainer_Injector.getInstance('CadastroAcessoCallBoxService');

            return this.instanciaCadastroAcessoCallboxService;
        }
        set;
    }
}