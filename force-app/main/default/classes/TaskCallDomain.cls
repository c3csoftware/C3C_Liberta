public without sharing class TaskCallDomain implements ITaskCallDomain, C3C_DI_IProvider
{
    //
    //Atributos
    //

    private TaskCallMapper tarefaChamadaMapper 
    {
        get
        {
            if(this.tarefaChamadaMapper == null)
                this.tarefaChamadaMapper = (TaskCallMapper) C3C_DIContainer_Injector.newInstance('TaskCallMapper');

            return this.tarefaChamadaMapper;
        }
        set;
    }

    //
    //Construtores
    //

    public TaskCallDomain()
    {}
    
    private TaskCallDomain(SObject tarefaChamada)
    {
        this.tarefaChamadaMapper = (TaskCallMapper) C3C_DIContainer_Injector.newInstance('TaskCallMapper', tarefaChamada);
    }
    //
    //Métodos
    //

    public Object newInstance(Object params)
    {
        if(params instanceOf SObject)
            return new TaskCallDomain((SObject) params);
        return null;
    }

    //Responsável por retornar a mapper
    public TaskCallMapper obterMapper()
    {
        return this.tarefaChamadaMapper;
    }

    //Responsável por retornar o registro SObject
    public SObject obterRegistro()
    {
        return this.tarefaChamadaMapper.record;
    }
}