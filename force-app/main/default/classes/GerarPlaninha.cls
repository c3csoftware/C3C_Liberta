public class GerarPlaninha 
{
    
    public static void gerarPlanilhaHunter()
    {
        List<InstanciaResposta__c> acclist =[select Lead__c,CreatedBy.Name, name, IdTarefa__c, Texto_Pergunta__c, Pergunta__r.Ordem__c, RespostaDissertativa__c, RespostaAlternativaValor__c, Owner.Name, CreatedDate from InstanciaResposta__c where CreatedDate > 2022-02-09T08:16:44.715-03:00 AND Owner.Name != 'Rafael Alves'];
        string header = 'ID, Titulo, Status, Descrição, Requerente, Data de abertura, Última atualização, Localização, Categoria, Origem';
        string finalstr = header ;
        string idtarefa2='';
        string idRequerente='';
        datetime idDataAbertura;
        string idCategoria='';
     	integer idContador=0;//Contador para apresentação e filtrar os ids com poucas perguntas
        for(InstanciaResposta__c a: acclist)
        {
       
            string recordString1 = a.Texto_Pergunta__c;
            string recordString2 = a.RespostaDissertativa__c;
            string recordString3 = a.RespostaAlternativaValor__c;
            string recordIdTarefa = a.IdTarefa__c;
            string recordIdTitulo='';
            string recordStatus='';
            string recordRequerente=a.CreatedBy.Name;
            datetime recordDataAbertura=a.CreatedDate;
            string recordLocalicacao='';
            string recordCategoria='';
            string recordOrigem='Salesforce';
            
            
                // FORMATAÇÃO
                    if(recordString2==null){recordString2='';}
                    if(recordString3==null){recordString3='';}
                    //if(recordString1=='Sub funil:'){recordString1='Sub-funil:';} //Já foi alterado no próprio SF
            		if(recordString1.contains('Nome do Cliente')) {recordIdTitulo ='Agendamento - ['+a.RespostaDissertativa__c+']';}
            		if(recordString1.contains('Cliente com perfil trader')){recordString1='Perfil trader: ';}
            		if(recordString1.contains('Lead convertido'))
                    {
                        if(recordString3.contains('Convertido')||recordString3.contains('Não Convertido'))
                        {
                            recordStatus='Fechado';
                        }
                        else
                        {
                            recordStatus='Processando (atribuído)';
                        }
                        
                    }
            
            		if(recordString1.contains('Segmentação do cliente'))
                    {
                        if(recordString2.contains('Digital')||recordString3.contains('Digital'))
                        {
                            recordCategoria='"1 - Até R$ 300.000,00"';
                            idCategoria=recordCategoria;
                            
                           	
                        }
                        else if(recordString2.contains('Express')||recordString3.contains('Express'))
                        {
                            recordCategoria='"2 - Entre R$ 300.000,00 e R$ 1.000.000,00"';
                            idCategoria=recordCategoria;
                            
                        }
                        else if(recordString2.contains('Premium')||recordString3.contains('Premium'))
                        {
                            recordCategoria='"2 - Entre R$ 300.000,00 e R$ 1.000.000,00"';
                            idCategoria=recordCategoria;
                            
                        }
                        else if(recordString2.contains('Private')||recordString3.contains('Private'))
                        {
                            recordCategoria='"3 - Acima de R$ 1.000.000,00"';
                            idCategoria=recordCategoria;
                            
                        }
                        
                    }
            		

            //CURRENCY FORMAT
            If(recordString1.contains('Financeiro informado'))
            {
                
                     if(recordString2.isnumeric())
                    {
                        String i=recordString2;                       
                    	String s = ( Decimal.valueOf(i==null||i.trim()=='' ? '0' : i).setScale(2) + 0.001).format();
                    	String p = s.substring(0,s.length()-1);
                        recordString2= 'R$'+p  ; // é aqui que ele cria o padrão xxx.xxx,xx
                        
                        
                    }
                    
                    if(recordString3.isnumeric())
                    {
                        String i=recordString3;
                    	String s = ( Decimal.valueOf(i==null||i.trim()==''?'0':i).setScale(2) + 0.001 ).format();
                    	String p = s.substring(0,s.length()-1);
                        recordString3 = 'R$'+p  ; // é aqui que ele cria o padrão xxx.xxx,xx
                        
                    }

            }
            
          //BUILDING CSV
           if(idtarefa2=='')// Primeira verificação
            {
              	finalstr= finalstr +' \n' +
                   		  recordIdTarefa + ','+recordIdTitulo+','+recordStatus+ ','+'"'+ recordString1 + ' ' +recordString2  +  ' '+ recordString3+'"';
              	idRequerente=recordRequerente;//atualiza valor para os proximos loops
                idDataAbertura=recordDataAbertura;
                idtarefa2=recordIdTarefa; 
                
            }
             
            else if(idtarefa2==recordIdTarefa)// Enquanto o ID for o mesmo, preenche a coluna DESCRIÇÃO
            {
                if(recordString1.contains('CNPJ do cliente'))
                {
                    recordString1='';recordString2='';recordString3='';
                    finalstr= finalstr + recordString1 +' ' + recordString2 + ' '+ recordString3 + ' ';
                
                }
                else{
                  finalstr= finalstr + recordString1 +' ' + recordString2 + ' '+ recordString3 + ' '+'\n' ;   
                }
              	
                idRequerente=recordRequerente;//atualiza valor para os proximos loops
                idDataAbertura=recordDataAbertura;
            }
            
            else // Quando mudar de ID
            {
                if(recordRequerente!=idRequerente){recordRequerente=idRequerente;}//atualiza o valor para antes de descer a linha usar o requerente correto
                if(recordDataAbertura!=idDataAbertura){recordDataAbertura=idDataAbertura;}
                if(recordCategoria!=idCategoria){recordCategoria=idCategoria;}
                if(recordRequerente.contains('fabrício')){recordLocalicacao='A55555';}
                else if (recordRequerente.contains('wesley')){recordLocalicacao='A73369';}
                
                
                finalstr= finalstr + 'Observações: "'+','+recordRequerente+ ','+recordDataAbertura+','+recordDataAbertura+','+recordLocalicacao+','+recordCategoria+','+recordOrigem+// aqui vai para o final das colunas
                    	  ' \n' + recordIdTarefa + ','+ recordIdTitulo+','+recordStatus+','+'"'+ recordString1 +' ' + recordString2 + ' '+ recordString3+'\n';
                
                idtarefa2=recordIdTarefa;
                recordCategoria='';
                idCategoria='';
                
            }

       

        }

        Messaging.EmailFileAttachment csvAttc = new Messaging.EmailFileAttachment();
        blob csvBlob = Blob.valueOf(finalstr);
        string csvname= 'Account.xls';
        csvAttc.setFileName(csvname);
        csvAttc.setBody(csvBlob);
        Messaging.SingleEmailMessage email =new Messaging.SingleEmailMessage();
        String[] toAddresses = new list<string> {'jhobert.duarte@c3csoftware.com.br'};
        String subject ='Account CSV';
        email.setSubject(subject);
        email.setToAddresses( toAddresses );
        email.setPlainTextBody('Account CSV ');
        email.setFileAttachments(new Messaging.EmailFileAttachment[]{csvAttc});
        Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
    }

}