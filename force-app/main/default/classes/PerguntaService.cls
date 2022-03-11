public without sharing class PerguntaService implements IPerguntaService
{
    //
    //Métodos
    //

    public List<IPerguntaDomain> obterPerguntasPorTipoTarefa(String tipoTarefa)
    {
        return (List<IPerguntaDomain>) C3C_DIContainer_Injector.newInstance('PerguntaDomain', this.perguntaSelectorInstance.obterPerguntasPorTipoTarefa(tipoTarefa));
    }

    //Responsável por retornar as perguntas dos ids informados.
    public List<IPerguntaDomain> obterPeguntasComListaIds(Set<String> listaIdPerguntas)
    {
        return (List<IPerguntaDomain>) C3C_DIContainer_Injector.newInstance('PerguntaDomain', this.perguntaSelectorInstance.buscarPerguntasComListaIds(listaIdPerguntas));
    }


    //
    //Selector
    //

    public IPerguntaSelector perguntaSelectorInstance 
    {
        get
        {
            if(this.perguntaSelectorInstance == null)
                this.perguntaSelectorInstance = (IPerguntaSelector) C3C_DIContainer_Injector.getInstance('PerguntaSelector');
            
            return this.perguntaSelectorInstance;
        }
        set;
    }
}