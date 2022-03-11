public without sharing virtual class CasoService 
{
    //Métodos
    public List<CasoDomain> buscarCasosDeOrigemAssessor(String origem)
    {
        List<CasoDomain> listaDeCasos = new List<CasoDomain>();

        for(SObject caso : this.instanciaCasoSelector.buscarCasosDeOrigemAssessor(origem))
            listaDeCasos.add((CasoDomain) C3C_DIContainer_Injector.newInstance('CasoDomain', caso));

        return listaDeCasos;
    }

    //Atributo que conterá a instância da CasoSelector
    private ICasoSelector instanciaCasoSelector
    {
        get
        {
            if(this.instanciaCasoSelector == null)
                this.instanciaCasoSelector = (ICasoSelector) C3C_DIContainer_Injector.getInstance('CasoSelector');

            return this.instanciaCasoSelector;
        }
        set;
    }
}