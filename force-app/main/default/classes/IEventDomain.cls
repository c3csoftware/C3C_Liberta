public interface IEventDomain 
{
    EventMapper obterMapper(); //Responsável por retornar a mapper
    SObject obterRegistro(); //Responsável por retornar o registro SObject
    void atribuirNovoIdDoRegistro();
    void atribuirNovoNomeProprietario(String nomeProprietario);
}