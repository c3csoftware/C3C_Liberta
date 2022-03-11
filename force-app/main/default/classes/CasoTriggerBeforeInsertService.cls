public without sharing virtual class CasoTriggerBeforeInsertService implements ICasoTriggerBeforeInsertService
{
    //Método
    public void atualizarCampoAssessor(List<CasoDomain> listaDeCasos)
    {
        for(CasoDomain casoDomain : listaDeCasos)
        {
            casoDomain.definirAssessorQueRequisitouCaso();

            if(casoDomain.casoCriadoPorAssessor)
            {
                casoDomain.assessorQueRequisitou = UserInfo.getUserId();
            }
        }
    }
}