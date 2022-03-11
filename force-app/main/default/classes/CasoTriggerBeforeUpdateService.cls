public without sharing virtual class CasoTriggerBeforeUpdateService implements ICasoTriggerBeforeUpdateService
{
    public void interarVezesQueCasoFoiReaberto(List<CasoDomain> listaCasoReaberto)
    {
        for(CasoDomain casoDomain : listaCasoReaberto)
        {
            if(casoDomain.status == 'Reaberto')
            {
                casoDomain.vezesCasosReaberto = casoDomain.vezesCasosReaberto + 1;
            }
        } 
    }
}