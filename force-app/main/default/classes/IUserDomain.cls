public interface IUserDomain
{
    UserMapper obterMapper(); //Responsável por retornar a mapper
    SObject obterRegistro(); //Responsável por retornar o registro SObject
    void preencherNovoId(); //Responsável por preencher um novo id no mapper
}