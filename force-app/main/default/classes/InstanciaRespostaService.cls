public without sharing class InstanciaRespostaService implements IInstanciaRespostaService
{
    public class InstanciaRespostaServiceException extends Exception{}

    //Métodos

    //Responsável por buscar as instancias de reposta das perguntas daquela tarefa.
	public List<IInstanciaRespostaDomain> obterInstanciaRespostaPorIdTarefa(String idTarefa)
    {
        return (List<IInstanciaRespostaDomain>) C3C_DIContainer_Injector.newInstance('InstanciaRespostaDomain', this.instanciaRespostaSelectorInstance.obterInstanciaRespostaPorIdTarefa(idTarefa));
    }

    //Responsável por criar ou atualizar uma lista de instancia de respostas
    public List<IInstanciaRespostaDomain> criarOuAtualizarListaDeInstanciaResposta(List<IInstanciaRespostaDomain> listaDeInstanciaResposta)
    {
        fflib_ISObjectUnitOfWork uow = (fflib_ISObjectUnitOfWork) C3C_DIContainer_Injector.newInstance('fflib_SObjectUnitOfWork', new Schema.SObjectType[]{
            InstanciaResposta__c.SObjectType
        });

        for(IInstanciaRespostaDomain instanciaResposta : listaDeInstanciaResposta)
            uow.registerUpsert(instanciaResposta.obterRegistro());

        try 
        {
            uow.commitWork();
        } 
        catch (Exception e) 
        {
            String messageError = e.getMessage();
            
            if(e.getMessage().contains('FIELD_CUSTOM_VALIDATION_EXCEPTION,'))
            {
                messageError = e.getMessage().split('FIELD_CUSTOM_VALIDATION_EXCEPTION,')[1].split(': \\[\\]')[0];
            }
            
            C3C_APP_ApplicationContext.addCriticalError('400', messageError);
            return null;
        }

        for(IInstanciaRespostaDomain instanciaResposta : listaDeInstanciaResposta)
        {
            instanciaResposta.atribuirNovoIdDoRegistro();
        }

        return listaDeInstanciaResposta;
    }

    public void deleteListaDeInstanciaResposta(List<IInstanciaRespostaDomain> listaDeInstanciaResposta)
    {
        fflib_ISObjectUnitOfWork uow = (fflib_ISObjectUnitOfWork) C3C_DIContainer_Injector.newInstance('fflib_SObjectUnitOfWork', new Schema.SObjectType[]{
            InstanciaResposta__c.SObjectType
        });

        for(IInstanciaRespostaDomain instanciaResposta : listaDeInstanciaResposta)
            uow.registerDeleted(instanciaResposta.obterRegistro());

        try 
        {
            uow.commitWork();
        } 
        catch (Exception e) 
        {
            C3C_APP_ApplicationContext.addCriticalError('400', 'Ocorreu uma exceção ao tentar deletar a Instância da Resposta, err: '+e.getMessage());
        }
    }

    public Boolean verificarPopAssessorRespondido(String idLead)
    {
        List<InstanciaRespostaDomain> listaInstanciaRespostaDomain = (List<InstanciaRespostaDomain>) C3C_DIContainer_Injector.newInstance('InstanciaRespostaDomain', this.instanciaRespostaSelectorInstance.buscarInstanciaRespostasPerguntaLeadConvertido(new Set<String>{idLead}));

        if(listaInstanciaRespostaDomain.isEmpty())
        {
            throw new InstanciaRespostaServiceException('Não é possível converter Lead sem preencher o POP!');
        }

        for(InstanciaRespostaDomain instanciaRespostaDomain : listaInstanciaRespostaDomain)
        {
            if(instanciaRespostaDomain.leadConvertido != null && instanciaRespostaDomain.leadConvertido == true)
            {
                return true;
            }
            else if(instanciaRespostaDomain.leadConvertido == false)
            {
                throw new InstanciaRespostaServiceException('Lead não pode ser convertido pois no POP foi selecionado Não Convertido!');
            }
            else 
            {
                continue;
            }
        }

        return false;
        /* 
            Pegar Instancia Resposta Selector e capturar instancia de resposta para id de lead passado
            Na selector fazer filtro para apenas contabilizar instancia de resposta que são de tipo de tarefa conversão de lead
            Averiguar se em Domain, cujo esse atributo 'respostaPerguntaLeadConvertido' é verdadeiro o outro atributo 'leadConvertido' tbm é verdadeiro, se for retorna verdadeiro se não for, retorna false
            Retornar verdadeiro se for convertido
        */
    }
    
    // Selector
    private IInstanciaRespostaSelector instanciaRespostaSelectorInstance
    {
        get
        {
            if(this.instanciaRespostaSelectorInstance == null)
                this.instanciaRespostaSelectorInstance = (IInstanciaRespostaSelector) C3C_DIContainer_Injector.getInstance('InstanciaRespostaSelector');
            
            return this.instanciaRespostaSelectorInstance;
        }
        set;
    }
}