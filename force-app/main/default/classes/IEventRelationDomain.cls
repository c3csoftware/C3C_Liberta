public interface IEventRelationDomain 
{
    void atribuirNovoIdDoRegistro();
    EventRelationMapper obterMapper();
    SObject obterRegistro();
}