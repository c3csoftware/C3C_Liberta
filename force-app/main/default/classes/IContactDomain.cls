public interface IContactDomain 
{
    ContactMapper obterMapper(); //Responsável por retornar a mapper
    SObject obterRegistro(); //Responsável por retornar o registro SObject
    void preencherNovoId(); //Responsável por preencher o id do contato
}