-- call_audits data migration (10 rows)
-- Execute in SQL Editor of NEW project AFTER 03_data_migration.sql
-- Removed: DISABLE TRIGGER ALL fails on system triggers. INSERTs do not fire any user triggers.

INSERT INTO call_audits (id, organization_id, closer_id, lead_name, call_date, duration_minutes, resultado, valor_fechamento, status, error_message, score_final, classificacao, d01_frame, d02_qualificacao, d03_diag_quantitativo, d04_diag_qualitativo, d05_consequencia, d06_ensino, d07_identidade, d08_ancoragem, d09_isolamento, d10_proporcao_fala, d11_promessas, d12_checkpoints, d13_fechamento, transcricao, relatorio_completo, resumo_whatsapp, top_erros, top_acertos, plano_acao, frases_proibidas, reescrita_falas, mapa_frameworks, fases_analise, audio_path, audio_duration_seconds, drive_file_id, drive_url, drive_report_url, modelo_transcricao, modelo_analise, tokens_input, tokens_output, custo_estimado, uploaded_at, transcribed_at, analyzed_at, notified_at, completed_at, created_at, updated_at, sentiment_overall, sentiment_timeline, sentiment_score, engagement_level, objections_detected, prompt_version, report_hash, storage_report_path) VALUES
('06cf2436-1314-417b-811e-c067dfdbf9f8', '4ecd8f2d-d0c5-419c-a5bc-b2e94dca0465', '171a0543-1dde-4ba4-99f8-d396c6832b60', 'Karina Vuolo', '2026-03-28', NULL, NULL, NULL, 'completed', NULL, 4.4, 'FRACA', 6.5, 4.0, 3.0, 6.0, 2.0, 7.0, 7.5, 4.0, 2.0, 5.0, 6.0, 7.0, 2.0, '20 de fev. de 2026

## Auditoria Comercial \- Karina \<\> System Digital \- Transcrição

### 00:00:00

   
**Evelyn La:** Oi, Karina,  
**Karina Vuolo Coach:** Tudo bem?  
**Evelyn La:** tudo bem contigo?  
**Karina Vuolo Coach:** Tudo bem. Obrigada aí por aí. Tudo bem?  
**Evelyn La:** Tirando a chuva que me deu agora e alargou a minha sala, tá tudo certo.  
**Karina Vuolo Coach:** Ai, meu Deus. Você está onde, Evelyn?  
**Evelyn La:** Eu tô em Cascavel, Paraná.  
**Karina Vuolo Coach:** Ah, tá Paraná.  
**Evelyn La:** Já ouviu falar sobre?  
**Karina Vuolo Coach:** Já,  
**Evelyn La:** Eu fico do ladinho de F.  
**Karina Vuolo Coach:** já, já ouvi falar.  
**Evelyn La:** É, eu tô aqui do lado de FD. do Iguaçu, umas 150 km,  
**Karina Vuolo Coach:** Tá.  
**Evelyn La:** mais ou menos. Você é de  
**Karina Vuolo Coach:** Reunião. Hum. Reunião.  
**Evelyn La:** onde?  
**Karina Vuolo Coach:** Ah, eu sou de Santa Cruz do Rio Pardo.  
**Evelyn La:** Ah, legal. Bom, Santa Cruz fica próximo de Ah,  
**Karina Vuolo Coach:** Bauru, Ourinhos.  
**Evelyn La:** é verdade. Eu f eu estive em eu estive em Barueri, não Bauru. Barueri foi.  
**Karina Vuolo Coach:** Ah,  
**Evelyn La:** Eh,  
**Karina Vuolo Coach:** market.  
**Evelyn La:** vamos lá, então, Karina.  
   
 

### 00:02:06

   
**Evelyn La:** Deixa eu só aumentar. Você tá me ouvindo bem?  
**Karina Vuolo Coach:** Sim.  
**Evelyn La:** Meu áudio tá tá retornando.  
**Karina Vuolo Coach:** Tá  
**Evelyn La:** Ah, bom. que eu tava, ele tava sendo baixo,  
**Karina Vuolo Coach:** ótimo.  
**Evelyn La:** mas é o meu aqui. Então, deixa eu arrumar. E aí, me fala um pouquinho de você se é cirurgia dentista, que que  
**Karina Vuolo Coach:** É,  
**Evelyn La:** É.  
**Karina Vuolo Coach:** a minha formação é cirurgião dentista, mas eu não atuo como clínica geral, eu atuo com harmonização facial e agora tô fazendo uma mentoria de lipo de papada.  
**Evelyn La:** Hum, legal. E a com a off você já trabalha quanto tempo?  
**Karina Vuolo Coach:** Então eu que eu tô trabalhando mesmo tem um  
**Evelyn La:** Uhum.  
**Karina Vuolo Coach:** ano.  
**Evelyn La:** Legal. E a Lipo, você tá na no andamento ainda aí? Já fez já fez alguma alguma cirurgia ou não?  
**Karina Vuolo Coach:** Isso.  
**Evelyn La:** Da Lipo? Tá  
**Karina Vuolo Coach:** Então, eu fiz duas lá no curso,  
**Evelyn La:** só  
**Karina Vuolo Coach:** aí fiz uma na minha clínica de paciente modelo e agora tenho mais duas  
**Evelyn La:** legal.  
**Karina Vuolo Coach:** pacientes modelo na próxima semana.  
**Evelyn La:** Oi, que coisa boa.  
**Karina Vuolo Coach:** É,  
   
 

### 00:03:22

   
**Evelyn La:** Já,  
**Karina Vuolo Coach:** sim.  
**Evelyn La:** que belezinha. Já tem case já.  
**Karina Vuolo Coach:** Engatinhando. Engatinhando.  
**Evelyn La:** É isso aí. Mas já tá, já tá tendo case aí, ó. Já dá para para mostrar alguns resultados,  
**Karina Vuolo Coach:** É, sim,  
**Evelyn La:** né?  
**Karina Vuolo Coach:** sim.  
**Evelyn La:** Maravilha. E hoje você tem clínica própria mesmo?  
**Karina Vuolo Coach:** Sim,  
**Evelyn La:** Como que atua na clínica própria? Uhum.  
**Karina Vuolo Coach:** sim.  
**Evelyn La:** Faz tempo que você tem a clínica?  
**Karina Vuolo Coach:** Eh, é assim, eu trabalhei por 20 anos como ortodontista lá na minha clínica. Aí eu vim pra minha cidade de origem,  
**Evelyn La:** Legal.  
**Karina Vuolo Coach:** que é aqui no interior de São Paulo.  
**Evelyn La:** Uhum.  
**Karina Vuolo Coach:** Então quando agora que eu voltei a trabalhar, eu voltei no mesmo prédio, só que a gente demoliu tudo, construir uma clínica nova. Então nessa clínica eu estou,  
**Evelyn La:** Legal.  
**Karina Vuolo Coach:** eu construí a clínica tem dois anos, tem um ano que eu tô lá trabalhando mesmo, como todo mês eu vou pro Pará, todo mês eu atendo lá.  
**Evelyn La:** Uhum.  
**Karina Vuolo Coach:** Eu tenho médicos,  
   
 

### 00:04:28

   
**Evelyn La:** E é só você de profissional ou você tem outros junto contigo?  
**Karina Vuolo Coach:** vários médicos que atendem  
**Evelyn La:** Ah, legal.  
**Karina Vuolo Coach:** lá.  
**Evelyn La:** Aí outras especialidades, tipo, é, é  
**Karina Vuolo Coach:** Eh,  
**Evelyn La:** integrativa.  
**Karina Vuolo Coach:** tem ortopedista, dermato, clínico geral,  
**Evelyn La:** Ah, que bacana.  
**Karina Vuolo Coach:** várias áreas.  
**Evelyn La:** Uhum. Acho que essas essas clínicas assim, eu sempre aqui em Cascavel tem algumas que são integrativas também para falar, a gente vai num lugar só e faz tudo que precisa, né?  
**Karina Vuolo Coach:** Exato.  
**Evelyn La:** Maravilha,  
**Karina Vuolo Coach:** Exatamente.  
**Evelyn La:** show de bola. Na sua clínica hoje, no que você faz o atendimento, é só você? Tem mais alguém que te ajuda? Alguma secretária?  
**Karina Vuolo Coach:** Tem,  
**Evelyn La:** Alguma?  
**Karina Vuolo Coach:** eu tenho uma secretária e quando eu preciso para procedimento cirúrgico, eu tenho uma enfermeira.  
**Evelyn La:** Acho. Uhum. Entendi. Legal. E o que que o que que levou a Karina a nos buscar hoje aqui? que que você tem eh tido de de desafio, né? O que que você viu ali? Talvez você foi pelo anúncio ou já conheci a gente de alguma  
   
 

### 00:05:41

   
**Karina Vuolo Coach:** Não, eu não conhecia vocês não.  
**Evelyn La:** indicação?  
**Karina Vuolo Coach:** Eu vi um anúncio e aí entrei em contato para ouvir de vocês o que que vocês têm a oferecer.  
**Evelyn La:** Legal. O que que você eh tava buscando quando caiu no nosso anúncio?  
**Karina Vuolo Coach:** Eu  
**Evelyn La:** Questões mais de marketing, questões de algo, alguma coisa específica.  
**Karina Vuolo Coach:** nem lembro mais do anúncio.  
**Evelyn La:** Eu  
**Karina Vuolo Coach:** Eu sei que deve ter me chamado atenção porque eu vejo vários durante o dia, mas eu não lembro mais nem qual era o  
**Evelyn La:** imagino. Vamos lá, então, Kina. Vou me apresentar um pouquinho eh para ti.  
**Karina Vuolo Coach:** anúncio.  
**Evelyn La:** Ah, agora conheci um pouquinho mais de você. Eu sou a Evelyn, faço parte do time da System, já estou há 2 anos com a System. A Sistem está há 6 anos no mercado e nós somos um parceiro de clínicas e cirurgiões da face. Como assim um parceiro? Então, nós não somos nem agência de marketing e nem somos mentoria, né?  
**Karina Vuolo Coach:** Ah.  
**Evelyn La:** Nós somos um braço eh a mais ali, vamos dizer assim, para esse cirurgião, para esse empresário, né? Porque todo cirurgião é um empresário. Somos um braço de parceria, de trabalho em conjunto com ele.  
   
 

### 00:06:49

   
**Evelyn La:** Por quê? O que que a gente resolve? a gente resolve, a gente trabalha justamente o posicionamento, trabalhamos o marketing, marketing faz parte do que a gente entrega e te ajuda a solucionar e a resolver. Então, a gente faz um marketing, trabalha estratégia, trabalha posicionamento, trabalha construção de perfil de cliente ideal para você, para captar pessoas qualificadas e estruturamos a sua parte comercial. Por que estruturar a parte comercial, né? Eh, nesse ponto que a gente fala que nós somos um acelerador de clínicas, nós trabalhamos em parceria porque a gente treina o seu time, né? Então você falou, se eu tenho uma secretária, a gente treinaria essa pessoa, a gente treinaria essa secretária dentro dos nossos processos comerciais que já são validados, processos responsáveis aí por alavancar faturamento das clínicas eh que entram no nosso ecossistema, né? Então, nós somos um parceiro, a gente estrutura o comercial. Por quê? Não adianta fazer só o serviço de marketing, porque o marketing ele vai ali, ah, vai te trazer uma visibilidade boa, vai te trazer uma demanda, mas se o seu comercial não souber o que fazer, qual processo seguir depois que essa pessoa ela entra no seu funil de vendas, que a gente diz, todo o seu trabalho com marketing é perdido, porque ele não gera venda.  
   
 

### 00:08:16

   
**Karina Vuolo Coach:** Isso. Passei por isso.  
**Evelyn La:** Aí, ó. Então, você já teve experiências aí com outras agências que talvez só fizeram isso.  
**Karina Vuolo Coach:** Sim.  
**Evelyn La:** Uhum.  
**Karina Vuolo Coach:** É.  
**Evelyn La:** E aí a gente sempre fala, né? Ah, o grande problema das agências de tráfego pago num geral hoje é porque elas focam muito em gerar volume, sabe? Ah, investe mais, ah, não sei o quê. Ah, o lead tá caro e tá caro mesmo. Cada vez o lead tá cada vez mais caro. Então você conseguir pessoas qualificadas, ele tá ficando mais caro. E aí, por que que você precisa o processo comercial? Porque se essa pessoa qualificada cai no seu funil, tem interesse e a tua vendedora, tua pré-vendedora, ela não consegue vender, você colocou, queimou dinheiro,  
**Karina Vuolo Coach:** Exato.  
**Evelyn La:** tá? Então, nós trabalhamos em parceria com o cirurgião. Um, por quê? Porque a gente treina o seu time comercial para quando tiver essa demanda qualificada aí entrando no seu funil, ele vender, né? Ele converter, eh trabalhar a base, inclusive, né? Paciente seus antigos, paciente que alguma vez já fez algum outro procedimento, por exemplo, agora você vai começar com as lipos de papada.  
   
 

### 00:09:26

   
**Evelyn La:** Então toda a base sua que já foi off, ela pode ser uma liquid papada. E aí vender, revender, criar estratégias para quê?  
**Karina Vuolo Coach:** Sim.  
**Evelyn La:** Para trazer, aquecer esses esses pacientes que já foram seu algum dia para eles vir agora e falar: "Olha, agora aina eh tem lipo de papada". Claro, não é assim que a gente oferece, né? tem que construir uma oferta atraente, ter uma abordagem correta para isso, para você reaquecer essa  
**Karina Vuolo Coach:** Quanto custa uma lipo de papada hoje que vocês estão  
**Evelyn La:** base.  
**Karina Vuolo Coach:** vendendo?  
**Evelyn La:** Ó, uma lipo, ela vai tá dependendo região e tudo, mas a gente normalmente a gente pega aí os cirurgiões, eles fazem entre 8, 10.000,  
**Karina Vuolo Coach:** Tá,  
**Evelyn La:** tá? Essa é a média.  
**Karina Vuolo Coach:** entendi.  
**Evelyn La:** Aí a gente trabalha com cirurgiões que fazem lipo,  
**Karina Vuolo Coach:** Não.  
**Evelyn La:** bléfaro,  
**Karina Vuolo Coach:** Ah, tá. Eu queria ver a papada.  
**Evelyn La:** é a lipo de papado.  
**Karina Vuolo Coach:** Lipo de papada.  
**Evelyn La:** Isso.  
**Karina Vuolo Coach:** É.  
**Evelyn La:** Aham. Entre 8 a 10.000 nessa nessa  
   
 

### 00:10:30

   
**Karina Vuolo Coach:** Aham.  
**Evelyn La:** média.  
**Karina Vuolo Coach:** e consegue vender.  
**Evelyn La:** Super, super de verdade. Ó,  
**Karina Vuolo Coach:** Verdade.  
**Evelyn La:** para você ter noção assim dos cases que a gente tem hoje no nosso ecossistema, já que estão aí conosco alguns meses, né? os mais recentes, vou te falar, né? Eh, a gente tem a a Débora Caribé, ela tem, ela entrou com a gente,  
**Karina Vuolo Coach:** Certo.  
**Evelyn La:** ela já tava faturando cerca de 150k ali por mês. É, ela já fazia em torno ali de umas 15 cirurgias de lipo, de papada, né? Na média ali tinha era variável. Em 4 meses, a Débora bateu 500.000 de faturamento,  
**Karina Vuolo Coach:** Sério?  
**Evelyn La:** fazendo a Bléfaro e fazendo a Lipo de papada. E a Débora, ela faz também a harmonização, ela faz, tem mais uma, um procedimento que ela faz que agora eu não lembro direito. Teria que puxar o Teria que puxar o Deixa eu ver se eu abro o Instagram dela, falar certinho para você. Mas assim, só para você ter uma ideia, eh, do quanto a gente conseguiu levar ela, né, de alavancagem aí, de faturamento, que é o mais interessante, óbvio, né, mas além disso, a gente estruturou muito o processo comercial interno que ela não tinha, né?  
   
 

### 00:11:52

   
**Evelyn La:** Ela perdia muitas vezes de vender e revender paraa própria base porque ela não tinha esse processo comercial definido.  
**Karina Vuolo Coach:** Muito  
**Evelyn La:** Ó,  
**Karina Vuolo Coach:** bom.  
**Evelyn La:** ela é de parauapebas. Para meu senhor,  
**Karina Vuolo Coach:** Nossa,  
**Evelyn La:** que nome de Pará.  
**Karina Vuolo Coach:** ela é pertinho de mim lá no Pará.  
**Evelyn La:** Aham. Paraapebas.  
**Karina Vuolo Coach:** Pebas. Isso pertinho de mim.  
**Evelyn La:** Isso, ó.  
**Karina Vuolo Coach:** Você não acredita.  
**Evelyn La:** Sério? Ela é daí,  
**Karina Vuolo Coach:** Uhum.  
**Evelyn La:** menina. E ela, ó, ela tava, eu tava vendo o insta dela. Deixa eu te mostrar o insta dela aqui.  
**Karina Vuolo Coach:** Ai, manda para mim. Evelysta. Manda.  
**Evelyn La:** Manda claro que eu dentista.  
**Karina Vuolo Coach:** Tem essa e ela é dentista.  
**Evelyn La:** Dentista,  
**Karina Vuolo Coach:** Aham.  
**Evelyn La:** deixa eu compartilhar aqui, eu vou te mandar, te mando no whats também. Já te já te passo. Ó, essa aqui, ó, essa aqui é a nossa acelerada que saiu de 150 para 500k. O Renan e o Mateus estão indo para lá mês que vem para fazer uma estratégia junto com ela na clínica e bater 1 milhão mesmo.  
   
 

### 00:13:02

   
**Evelyn La:** Ó, ela faz essa aqui, ó. Hoje a Débora entrou em sociedade com a gente também no educacional,  
**Karina Vuolo Coach:** Eh,  
**Evelyn La:** que aí ela começou a fazer o quê? ela começou a fazer imersões presenciais para outros dentistas que queiram aprender a técnica dela.  
**Karina Vuolo Coach:** Aham,  
**Evelyn La:** Aí a gente tá nesse braço também com ela.  
**Karina Vuolo Coach:** entendi.  
**Evelyn La:** Mas para você ter uma uma ideia, né, de assim, ah, dá para fazer 1 milhão, dá. Ó, cirurgias estéticas, papada e pescoço. Esse é o o ela até deixa aqui o Cro dela tudo certinho, né? Essa é um dos nossos cases. A gente tem outros também. Eu te mando ali depois para você ver certinho. Mas assim, é estrutura comercial, uma boa campanha, né, para você atrair leads qualificados e a venda ela é certa.  
**Karina Vuolo Coach:** Sim. Manda outra para mim das mais  
**Evelyn La:** Mas das mais novas, deixa eu ver se eu tenho a Sandy aqui também.  
**Karina Vuolo Coach:** novas.  
**Evelyn La:** Deixa eu te mandar no Whats aí. Me fala seu número aí rapidinho que eu te mando do meu aqui já.  
**Karina Vuolo Coach:** 14 é o DDD.  
**Evelyn La:** Você falou que Aham.  
   
 

### 00:14:17

   
**Karina Vuolo Coach:** 998 99  
**Evelyn La:** Uhum. Aham.  
**Karina Vuolo Coach:** 487\.  
**Evelyn La:** Te mandar um oi. E vou te mandar a Débora. Você já ouviu falar no Alexandre Algarve?  
**Karina Vuolo Coach:** Ele é de onde?  
**Evelyn La:** Ele é de Maringá.  
**Karina Vuolo Coach:** Não, esse não.  
**Evelyn La:** Não, esse é um outro case nosso também.  
**Karina Vuolo Coach:** M.  
**Evelyn La:** Ele, o Algarve, ele é bem, foi um dos pioneiros na nessa questão de cirurgias da face de para dentistas fazerem, né? Ele foi assim bem bem pioneiro nessa área.  
**Karina Vuolo Coach:** Sei.  
**Evelyn La:** Ele era meio perseguido antes por causa que o pessoal CRM ficava em cima dele, sabe? para não deixar,  
**Karina Vuolo Coach:** Uhum.  
**Evelyn La:** né? Mas ah, que bom que agora tá tudo certo,  
**Karina Vuolo Coach:** Liberaram.  
**Evelyn La:** né?  
**Karina Vuolo Coach:** Aham.  
**Evelyn La:** Tem a Sand também Dra, que é um dos cases nossos recente. Te mandei aí, ó,  
**Karina Vuolo Coach:** Tá bom.  
**Evelyn La:** te mandei a Débora Alexandre e a Sand para você ver. A Sand, ela chegou com a gente faturando cerca aí de 70.000 1  
**Karina Vuolo Coach:** Certo.  
   
 

### 00:15:31

   
**Evelyn La:** no mês. E aí com as nossas estratégias aí de estrutura de time comercial, ela bateu 70.000 em uma semana, fazendo só revenda para base. Por isso que a gente fala, estrutura comercial é  
**Karina Vuolo Coach:** Então, mas daí você manda pronto para mim.  
**Evelyn La:** importante.  
**Karina Vuolo Coach:** Como que a gente faz isso? Eu queria entender como que é o  
**Evelyn La:** Vamos lá, vou te explicar certinho. Antes de eu te mostrar como que é o processo,  
**Karina Vuolo Coach:** processo.  
**Evelyn La:** eu vou abrir um mapa mental para eu poder entender com mais clareza os seus objetivos, porque a partir dele a gente que faz o quê? A gente cria uma estratégia específica para você, né? dentro daquilo que você,  
**Karina Vuolo Coach:** Uhum.  
**Evelyn La:** óbvio, almeja,  
**Karina Vuolo Coach:** Sim.  
**Evelyn La:** porque cada caso é um caso, né? Por exemplo, a gente tem caso assim: "Ah, eu quero dobrar meu faturamento, ah, eu quero eh aumentar 30%, né? Então, a gente trabalha sempre em cima do quê?" Óbvio, uma coisa que seja palpável, né? Não dá. Que nem a Débora assim agora que ela vai bater 1 milhão, mas não foi o primeiro passo, vamos dizer, né?  
   
 

### 00:16:40

   
**Evelyn La:** Meu mapa mental aqui. Eh, e aí a gente vai trabalhando isso. Deixa eu para mim entender como que a gente poderia fazer isso. Então, vamos lá. Hoje você falou que você tem sua secretária, legal, tem seu própria clínica, ótimo, né? Tem estrutura aí, tá começando com essa nova especialização, ou seja, já é um produto a mais na sua esteira, mas a sua média hoje de faturamento, ela vem sendo quanto  
**Karina Vuolo Coach:** Ai,  
**Evelyn La:** ali?  
**Karina Vuolo Coach:** minha média é baixa porque assim, eu fico, na verdade, no Pará, eu fico 10 dias por mês,  
**Evelyn La:** Certo?  
**Karina Vuolo Coach:** de 8 a 10 dias.  
**Evelyn La:** Tá?  
**Karina Vuolo Coach:** E eu só trabalho lá. Também comecei a trabalhar aqui em Santa Cruz,  
**Evelyn La:** Tá.  
**Karina Vuolo Coach:** mas eh não virou nada, não fiz marketing, entendeu? Então assim, poderia ter um ganho a mais, poderia, mas tipo assim, eu tô querendo me fortalecer lá no Pará,  
**Evelyn La:** Legal.  
**Karina Vuolo Coach:** fazer meu dinheiro lá e é isso.  
**Evelyn La:** Aí depois se for o caso,  
**Karina Vuolo Coach:** É, se for isso em Santa Cruz.  
**Evelyn La:** abre uma segunda a segunda agenda em em São Paulo. Legal.  
   
 

### 00:18:01

   
**Karina Vuolo Coach:** É,  
**Evelyn La:** Então você tem 8 a 10 dias no mês aí para você faturar.  
**Karina Vuolo Coach:** isso.  
**Evelyn La:** Perfeito.  
**Karina Vuolo Coach:** Exato.  
**Evelyn La:** Dentro desses dias, normalmente a sua média de faturamento vem sendo o quê ali?  
**Karina Vuolo Coach:** 20.000 22.000  
**Evelyn La:** Uhum. Maravilha. Qual a sua meta dentro desse período que você tem,  
**Karina Vuolo Coach:** Eu  
**Evelyn La:** óbvio, para disponível, né, paraas cirurgias para esse ano? Por exemplo, ah, Evelyn, do 8 a 10 dias ali, eu queria no mínimo bater  
**Karina Vuolo Coach:** meu objetivo é 100.000.  
**Evelyn La:** 100.000.  
**Karina Vuolo Coach:** É, esse é meu  
**Evelyn La:** Uhum. Você acredita entre esses dias  
**Karina Vuolo Coach:** objetivo.  
**Evelyn La:** que você seria, a gente tá falando aí de basicamente quase que uma cirurgia por dia, certo? De lipo de papada se fosse para chegar no 100.000.  
**Karina Vuolo Coach:** Ah, eu consigo. Se fosse fazer ali, pô, eu consigo fazer duas por dia, uma de manhã e uma de  
**Evelyn La:** Ótimo. Maravilha. Perfeito.  
**Karina Vuolo Coach:** tarde.  
   
 

### 00:19:05

   
**Evelyn La:** Não, perfeito. Que daí paraa gente entender que assim, eh, você vai, você fica esses dias corridos, depois você volta, né?  
**Karina Vuolo Coach:** Eh, volto  
**Evelyn La:** Isso. Entendi. Uhum. Bateu 100K. Qual o seu maior objetivo em bater esse faturamento?  
**Karina Vuolo Coach:** isso.  
**Evelyn La:** Por exemplo, a Evelyn. Eu quero fazer o mínimo de 100k para cobrir o meu investimento, para eu ter um pouco mais de dinheiro no bolso. Esse dinheiro vai me proporcionar mais o quê?  
**Karina Vuolo Coach:** Esse dinheiro representa muito para mim, muito.  
**Evelyn La:** Legal.  
**Karina Vuolo Coach:** Ele tem algo emocional com metas, com sonhos, com liberdade de tipo eu falar pro meu marido, olha, eh, o sim e o não, agora depende de mim. Eu não preciso mais ficar dependendo do teu sim, do teu não. Tem muita coisa envolvida nesses 100.000.  
**Evelyn La:** Ótimo. Liberdade financeira e pessoal também. Legal.  
**Karina Vuolo Coach:** Isso.  
**Evelyn La:** Praina hoje que tá fazendo 20, chegar no 100, o que que você considera mais desafiador que tem sido para  
**Karina Vuolo Coach:** Vender,  
**Evelyn La:** você?  
**Karina Vuolo Coach:** converter.  
   
 

### 00:20:27

   
**Karina Vuolo Coach:** o meu Instagram, eh, eh, na verdade assim, é muito, muito pouca conversão.  
**Evelyn La:** Aham. do seu vindo do seu Instagram, você fala,  
**Karina Vuolo Coach:** É,  
**Evelyn La:** né?  
**Karina Vuolo Coach:** é sim.  
**Evelyn La:** Você chegou a fazer alguma campanha de marketing já com algum outro  
**Karina Vuolo Coach:** Várias,  
**Evelyn La:** lugar?  
**Karina Vuolo Coach:** várias, várias.  
**Evelyn La:** Uhum. Chegou investir quanto na média aí de marketing?  
**Karina Vuolo Coach:** R$ 1.000 foi meu  
**Evelyn La:** Uhum.  
**Karina Vuolo Coach:** máximo.  
**Evelyn La:** Desses R$ 1.000, chegou a ter algum  
**Karina Vuolo Coach:** Olha só,  
**Evelyn La:** retorno?  
**Karina Vuolo Coach:** foram 70 leades e não converti nenhuma da cirurgia já  
**Evelyn La:** Nossa Senhora.  
**Karina Vuolo Coach:** de lipo de papada. 70 leades. A, o valor foi R$ 19 cada LED. E eu não não virou nada nem nenhuma.  
**Evelyn La:** Nada.  
**Karina Vuolo Coach:** chegou a marcar consulta online, não apareceu, marcou na clínica, não foi. Então assim, não deu certo.  
**Evelyn La:** Deixa eu te perguntar, a tua secretária, ela fica fixa lá na clínica? Ah, ótimo.  
   
 

### 00:21:39

   
**Evelyn La:** Tá.  
**Karina Vuolo Coach:** Fica  
**Evelyn La:** Eh, esse questão do lead não comparecer, não sabe, se perder no meio do caminho,  
**Karina Vuolo Coach:** sim.  
**Evelyn La:** é onde a gente entra na estruturação comercial para resolver justamente isso na clínica do cirurgião, que é o quê? treinar a secretária nas cadências corretas,  
**Karina Vuolo Coach:** Certo.  
**Evelyn La:** nas abordagens corretas para ela manter esse leíd aquecido. Porque se ela faz uma vez só e depois ela deixa um período ali,  
**Karina Vuolo Coach:** OK.  
**Evelyn La:** mas aconteceu várias coisas na na vida daquele lead,  
**Karina Vuolo Coach:** Com certeza.  
**Evelyn La:** bateu o carro, acontece tudo, menina,  
**Karina Vuolo Coach:** É  
**Evelyn La:** acontece tudo. Então,  
**Karina Vuolo Coach:** verdade.  
**Evelyn La:** se a gente não prende ele já num primeiro, ele escapa muito fácil. né? Então, a gente cria o quê?  
**Karina Vuolo Coach:** Uhum.  
**Evelyn La:** Uma cadência para estimular ele manter aquecido. Legal. Objetivo, desafio. O que que a gente eh teria que trabalhar hoje?  
**Karina Vuolo Coach:** Você  
**Evelyn La:** No caso da Karina, um posicionamento no Instagram para quê?  
**Karina Vuolo Coach:** já viu o meu  
**Evelyn La:** Eu dei uma olhadinha ali.  
**Karina Vuolo Coach:** Instagram?  
**Evelyn La:** É o o Gustavo me mandou.  
   
 

### 00:22:49

   
**Evelyn La:** Deixa eu até confirmar com você. que ele me passou aqui. Eu tinha aberto antes, mas ele não. Ah, não, perdão. Me fala teu Instagram aí, porque o Gustavo ficou de me mandar. Ele me mandou da da reunião das 5 horas. Não foi o seu não. Qual que é o seu,  
**Karina Vuolo Coach:** Eh,  
**Evelyn La:** Karina?  
**Karina Vuolo Coach:** DRA Karina Volo.  
**Evelyn La:** C, né? Que legal. Isso é chique, hein? Olha que bonitona, gente. Muito bom. Eh, teria que colocar só sabe o quê, Karina? Agora o antes e depois da tuas lipo mesmo esses case que você tá fazendo de de paciente modelo,  
**Karina Vuolo Coach:** Certo.  
**Evelyn La:** alinhar só esse esse quesito do posicionamento, tá?  
**Karina Vuolo Coach:** Entendi.  
**Evelyn La:** Não no mexer no teu na tua persona,  
**Karina Vuolo Coach:** Entendi.  
**Evelyn La:** vamos dizer assim,  
**Karina Vuolo Coach:** Vocês fazem também essa questão da da publicidade de Instagram ou  
**Evelyn La:** não.  
**Karina Vuolo Coach:** não?  
**Evelyn La:** Não,  
**Karina Vuolo Coach:** Isso aí não  
**Evelyn La:** a publicidade não. A gente faz o quê?  
**Karina Vuolo Coach:** tá.  
**Evelyn La:** a gente cria a estratégia que vai conversar com o seu cliente ideal para depois a gente linkar nas campanhas e direciona para você fazer, por exemplo, eh, contratar um social mídia,  
   
 

### 00:24:32

   
**Karina Vuolo Coach:** Ah,  
**Evelyn La:** alguma coisa que vá fazer o trabalho em si para ti, mas a gente dá a direção para esse social mídia,  
**Karina Vuolo Coach:** entendi, entendi. Vocês  
**Evelyn La:** tá? Sim. a gente direciona na parte de,  
**Karina Vuolo Coach:** direcionam  
**Evelyn La:** por exemplo, eh, agora você vai conversar com públicos interessados em lipo de papada, por exemplo,  
**Karina Vuolo Coach:** isso.  
**Evelyn La:** né? como a gente alinhar esse seu posicionamento referente a isso, porque a partir disso a gente constrói teu perfil de cliente ideal para linkar nas  
**Karina Vuolo Coach:** S.  
**Evelyn La:** campanhas. Então, paraa produção de conteúdo, tudo isso a gente eh cria estratégia e direciona você. Aí é só o fato mesmo de você ter um designer, vamos dizer assim, que crie isso para ti.  
**Karina Vuolo Coach:** Você tem alguém para indicar?  
**Evelyn La:** Tem, a gente tem Aham. A gente tem banco de talentos tanto paraa parte quando precisa de secretária, quando precisa de social selling, que é a pessoa que trabalha dentro do seu Instagram fazendo prospecção fria. E para designer também a gente tem indicação,  
**Karina Vuolo Coach:** Hum, interessante.  
**Evelyn La:** tá? É,  
**Karina Vuolo Coach:** Gostei.  
**Evelyn La:** a gente a gente tem a gente não consegue fazer tudo, tudo, né?  
   
 

### 00:25:50

   
**Evelyn La:** Por enquanto ainda a gente não tem todos esses braços,  
**Karina Vuolo Coach:** Então você tem,  
**Evelyn La:** mas quem sabe futuramente a gente  
**Karina Vuolo Coach:** tipo, você orienta o que que tem que ser feito. A gente, por exemplo, se for alguém que você indicar,  
**Evelyn La:** orienta.  
**Karina Vuolo Coach:** a gente consegue fazer a reunião junto com você para alinhamento de tudo de estratégia,  
**Evelyn La:** Consegue sim, tá? Consegue sim. Quanto a isso,  
**Karina Vuolo Coach:** tá?  
**Evelyn La:** precisar falar, marca um horário com com na agenda tal dia, vamos alinhar aqui, vai tá o o a pessoa do meu marketing ou vai est o meu social mídia para conversar junto e a gente alinhar.  
**Karina Vuolo Coach:** Qual a diferença dos do social marketing para  
**Evelyn La:** A gente vai o  
**Karina Vuolo Coach:** o  
**Evelyn La:** mídia, o mídia ele vai fazer de fato as suas mídias,  
**Karina Vuolo Coach:** É.  
**Evelyn La:** né? Então, por exemplo, ele vai cuidar o quê? Dessa parte do teu feed mesmo, né? Vai fazer as suas mídias no geral. Muitas vezes o social mídia ele vai o quê?  
**Karina Vuolo Coach:** Uhum.  
**Evelyn La:** Ele vai na sua clínica, ele te filma, ele produz o seu conteúdo,  
**Karina Vuolo Coach:** Ah,  
**Evelyn La:** tá? Ele faz a produção, ou seja, ele edita o seu vídeo,  
   
 

### 00:26:56

   
**Karina Vuolo Coach:** entendi.  
**Evelyn La:** ele edita as suas fotos, ele vai fazer isso. O estrategista de marketing, que aí no caso somos nós, a gente direciona qual a melhor estratégia para ele fazer,  
**Karina Vuolo Coach:** Ah,  
**Evelyn La:** tá?  
**Karina Vuolo Coach:** entendi.  
**Evelyn La:** Então na hora de linkar a campanha somos nós também que fazemos, mas o o social media ele é direcionado por nós do tipo assim, ó,  
**Karina Vuolo Coach:** Certo.  
**Evelyn La:** eh, para lipo de papada. faz eh um conteúdo relacionado a tal coisa, filma de tal ângulo, eh precisamos de antes e depois nesse e nesse formato. A gente direciona tudo isso.  
**Karina Vuolo Coach:** Entendi.  
**Evelyn La:** Ou ele só vai precisar realmente assim fazer o trabalho ali, que é o quê?  
**Karina Vuolo Coach:** Aí no caso eu teria que ter um lá na lá no Pará para poder fazer  
**Evelyn La:** Sumar.  
**Karina Vuolo Coach:** isso aí quando eu marcar a cirurgia daí tem que  
**Evelyn La:** Exatamente.  
**Karina Vuolo Coach:** marcar com ele. É  
**Evelyn La:** Isso. Perfeito. Para ele conseguir filmar,  
**Karina Vuolo Coach:** isso.  
**Evelyn La:** ter essa esse antes e depois ou até mesmo filmar você ali, eh, dependendo como a gente direcionar, né? Filmar você no procedimento ou no atendimento em si, a gente bola uma coisa bem eh personalizada para você,  
   
 

### 00:28:12

   
**Karina Vuolo Coach:** Certo,  
**Evelyn La:** né?  
**Karina Vuolo Coach:** certo.  
**Evelyn La:** que aí ele vai o quê? Ele vai seguir os nossos direcionamentos, porque o nosso direcionamento ele já vai ser exclusivo para conversar com o seu perfil de cliente  
**Karina Vuolo Coach:** Uhum.  
**Evelyn La:** ideal,  
**Karina Vuolo Coach:** Uhum.  
**Evelyn La:** porque é através disso que a gente linka a campanha específica que vai conversar com essas pessoas e vai chegar nessas pessoas. Porque o grande eh gargalo entre a agência de marketing e toda essa parte comercial é porque a agência não cria estratégia específica personalizada que fale tanto com o seu perfil,  
**Karina Vuolo Coach:** É  
**Evelyn La:** com que você mostra, quanto com quem você quer atingir.  
**Karina Vuolo Coach:** isso.  
**Evelyn La:** Aí ele só colocam dinheiro lá no meta, achando que é o valor do lead que vai influenciar, não é? É a estratégia que tá por trás. Se for só por valor, eh, não adianta nada às vezes o lead sair a R$ 60 e entrar no funil e não converter,  
**Karina Vuolo Coach:** Isso.  
**Evelyn La:** entendeu? Então, a gente faz esse trabalho todo estratégico e treina a sua secretária,  
**Karina Vuolo Coach:** Угуm.  
**Evelyn La:** inclusive nessa parte de pré-agendamento, pré pré-atendimento, o o agendamento em si ali e a venda, né?  
   
 

### 00:29:33

   
**Evelyn La:** E a venda em si, como converter 40% do que entra. Então, por exemplo, chega 70, desses 70 L que você falou que você teve essa experiência aí, né? No mínimo 42 teriam que ter convertido em vendas se fossem pessoas qualificadas, né?  
**Karina Vuolo Coach:** Sim.  
**Evelyn La:** Então é essas estratégias que a gente cria. Então quando eu falo do posicionamento, é em relação mais a mostrar esses antes e depois, tá? Até vou colocar entre aspas aqui antes e  
**Karina Vuolo Coach:** Ai, coloca  
**Evelyn La:** depois,  
**Karina Vuolo Coach:** mesmo.  
**Evelyn La:** não do posicionamento em si como eh expert, porque isso você já tem bem definido. Muito bom. Inclusive,  
**Karina Vuolo Coach:** Muito obrigada.  
**Evelyn La:** você fala bastante com a classe a mais pelo seu perfil, a classe mais que tem realmente essa essa linguagem  
**Karina Vuolo Coach:** É.  
**Evelyn La:** mais eh refinada assim, sutil, sabe? Não é não é agressiva. Você tem bastante refinamento, seus postes são bem bonitos e você tem do seu lifestyle. Isso é muito bom. Porque tem gente às vezes que foca só no profissional. É bom ter sim o antes e depois. A gente precisa ter isso. Na hora que a pessoa ela entra, ela dá de cara já com antes e depois assim, aí ela chama atenção, aí ela vai rolar, aí ela vai ver, olha, olha, ela formada em Harvard, né?  
   
 

### 00:31:05

   
**Evelyn La:** Ela tem, ó,  
**Karina Vuolo Coach:** Uhum.  
**Evelyn La:** aí vai, sabe?  
**Karina Vuolo Coach:** Sim.  
**Evelyn La:** Mas de o primeiro impacto é o antes e depois.  
**Karina Vuolo Coach:** É, com  
**Evelyn La:** Então,  
**Karina Vuolo Coach:** certeza.  
**Evelyn La:** fazendo esse posicionamento, eh, dentro dos funis, que que a gente teria que trabalhar com você? o funil de marketing, né, que é a construção desse ICP, que é o perfil de cliente ideal para você, para o faturamento que você quer atingir. Então, a gente tá falando aí de pessoas que tenham em média essa capacidade de pagamento aí de 8, 10, R$ 15.000, que a gente tá falando de revenda também. Então assim, a pessoa fez uma off e ela tem a capacidade de uma lipo ou a pessoa vem para uma lipo, depois ela faz off. Essa esse ticket médio, eh, pré-vendas essencial, que é o treinamento da secretária, e envolve todo pré-venda. Que que é o pré-venda? a gente trabalha tanto mentalidade dela, porque precisa ser trabalhado também, afinal de contas, ela vai atender uma classe A,  
**Karina Vuolo Coach:** Isso.  
**Evelyn La:** né? Então, precisa ter esse trabalho. Ela precisa saber que ela tá vendendo o quê?  
   
 

### 00:32:25

   
**Evelyn La:** Ela tá vendendo o agendamento,  
**Karina Vuolo Coach:** Uhum.  
**Evelyn La:** ela não tá só agendando, ela não tá só marcando um horário, não. Ela tem que criar um relacionamento genuíno, ela tem que ser criativa, ela precisa aprender a contornar objeções que já vêm nesse pré-atendimento.  
**Karina Vuolo Coach:** Sim.  
**Evelyn La:** Porque aí ela vai o quê? ela vai qualificar essa pessoa, ela vai extrair informações importantes para de fato ela entender se a pessoa ela tá sendo só curiosa e tomando tempo ou se de fato ela tem um interesse real em uma lipo de papada ou uma harmonização.  
**Karina Vuolo Coach:** Certo.  
**Evelyn La:** Então é criar esse passo a passo no funil de pré-vendas e a venda em si, trabalhar a venda também. Aqui eu te pergunto, você hoje, você que faz a venda, que faz o fechamento quando o paciente chega ou você passa para ela também?  
**Karina Vuolo Coach:** Ah, eu passo paraa minha secretária.  
**Evelyn La:** Tá? Uhum. Ela que faz todo o agendamento, confirmações e  
**Karina Vuolo Coach:** Isso,  
**Evelyn La:** venda.  
**Karina Vuolo Coach:** mas eu já passo o valor antes pro pro paciente, né?  
**Evelyn La:** Uhum.  
**Karina Vuolo Coach:** Aí eu falo assim: "Olha, agora a minha secretária vai finalizar com você, ver como é que fica melhor seu pagamento, coisa e tal".  
   
 

### 00:33:49

   
**Karina Vuolo Coach:** Mas eu já passo, mas eu quero deixar paraa minha secretária fazer esse fechamento para mim.  
**Evelyn La:** Ótimo. Perfeito. Então, no caso, você tem hoje a faz o agendamento, aí ela vai para você e aí ela volta para finalizar.  
**Karina Vuolo Coach:** É  
**Evelyn La:** Legal, entendi.  
**Karina Vuolo Coach:** isso.  
**Evelyn La:** Consigo. Beleza. Esse atendimento que ele faz com você é a  
**Karina Vuolo Coach:** avaliação,  
**Evelyn La:** avaliação.  
**Karina Vuolo Coach:** anamnese, eh, entender a queixa.  
**Evelyn La:** Legal. Então você faz o diagnóstico e aí depois volta para fechar com a com a secretária.  
**Karina Vuolo Coach:** Isso.  
**Evelyn La:** Legal.  
**Karina Vuolo Coach:** Aham.  
**Evelyn La:** Estrut estruturar.  
**Karina Vuolo Coach:** Aí até eu falei: "Olha, o paciente chegou, já preenche a anamnésia. A anamnese ele mesmo preenche.  
**Evelyn La:** Uhum.  
**Karina Vuolo Coach:** Aí já vai pra fotografia, a minha secretária já faz a fotografia dele. Quando o paciente entrar, já tá no meu tablet a fotografia lá.  
**Evelyn La:** Legal.  
**Karina Vuolo Coach:** E aí sim eu vou conversar com ele em cima da da foto. Fica mais fácil do paciente visualizar.  
**Evelyn La:** Uhum.  
**Karina Vuolo Coach:** Eu falei que agora eu falei que eu quero trabalhar assim agora.  
   
 

### 00:35:11

   
**Evelyn La:** Maravilha. Mas é bom mesmo esse a percepção visual mais clara. Uhum.  
**Karina Vuolo Coach:** É.  
**Evelyn La:** é que é onde traz o seu diferencial, inclusive, né, no seu atendimento ali com ele. Muito bom. Então, que caminho que a gente teria que percorrer, Karina? Primeira coisa, eh, trabalhar o seu maior desafio, que essa questão da conversão. Essa essa esse desafio da conversão,  
**Karina Vuolo Coach:** Sim.  
**Evelyn La:** ele vai vir estruturando o quê? definindo, né, o seu perfil, trabalhando uma estratégia assertiva no marketing para gerar uma demanda qualificada, a pré-vendedora fazer exatamente o processo correto para gerar esses agendamentos e comparecimentos e ela entender também sobre a venda, né? Porque nada adianta a pessoa vim, faz toda a avaliação, você investe o seu tempo com a pessoa ali,  
**Karina Vuolo Coach:** Eh,  
**Evelyn La:** quando volta para ela, ela deixa escapar e ela não consegue converter,  
**Karina Vuolo Coach:** Isso.  
**Evelyn La:** sabe? Então, trabalhar o treinamento com ela,  
**Karina Vuolo Coach:** S.  
**Evelyn La:** ela entender sobre essa venda high ticket, porque o produto acima de 3.997 hoje no mercado, ele é considerado um produto high ticket. Então, a gente tá falando de produtos high tickets aqui.  
   
 

### 00:36:35

   
**Evelyn La:** E a venda de um high ticket, ela é diferenciada. Não é igual vender pão, né? Não é igual vender eh produtos, discursos aí menores de R$ 500, R$ 300\. Não, ele é um high ticket. E aí tem todo um passo a passo. São detalhes, né? A venda do Ricket, ela construída por detalhes. Então, a gente ajuda e treina a secretária para ela identificar, para ela entender a importância desses detalhes para se construir no processo e ele de fato fechar ali, né? Como que a gente faz isso? com estruturação. No seu caso, a gente teria que estruturar melhor essa parte do agendamento e do fechamento da venda,  
**Karina Vuolo Coach:** Uhum.  
**Evelyn La:** porque a venda em si,  
**Karina Vuolo Coach:** Sim.  
**Evelyn La:** ela vai acontecer com você, na tua avaliação ali, no seu termo com o paciente,  
**Karina Vuolo Coach:** Sim.  
**Evelyn La:** mas o fechamento é que tá falho, porque a pessoa às vezes ela até sai ali convencida com  
**Karina Vuolo Coach:** Na verdade,  
**Evelyn La:** você.  
**Karina Vuolo Coach:** o paciente não está chegando.  
**Evelyn La:** Uhum. Sim.  
**Karina Vuolo Coach:** O paciente de cirurgia não tá chegando. Então o que chegou para mim foi a questão da harmonização.  
   
 

### 00:37:45

   
**Evelyn La:** Aham.  
**Karina Vuolo Coach:** Então chegou, dificilmente ele não fecha.  
**Evelyn La:** Aham. Normalmente da harmonização ele tem quanto aí por cento de conversão que eu digo tipo: "Ah, cada 10 eu consigo fechar oito.  
**Karina Vuolo Coach:** Ah, cada 10 eu acho que é de sete a oito.  
**Evelyn La:** Sete a oit fecha.  
**Karina Vuolo Coach:** É  
**Evelyn La:** Ótimo.  
**Karina Vuolo Coach:** sim.  
**Evelyn La:** E aí seria eh nesse caso que você falou, né? Não tá vindo o paciente, é por a gente precisa mexer no seu funil e estruturar o agendamento, né? e melhorar, claro,  
**Karina Vuolo Coach:** Tem  
**Evelyn La:** a a o fechamento, ele vai ser uma consequência dessa melhora na estrutura no geral aqui entre agendamento e venda.  
**Karina Vuolo Coach:** certo.  
**Evelyn La:** Mas o fechamento é importante treinar ela também porque você vai começar a abrir agora a agenda para lipo de papada, né?  
**Karina Vuolo Coach:** Exato.  
**Evelyn La:** Então ela ela vai precisar entender melhor sobre o fechamento de uma venda de R$ 10.000,  
**Karina Vuolo Coach:** Com  
**Evelyn La:** né, negociações e tudo mais.  
**Karina Vuolo Coach:** certeza.  
**Evelyn La:** Então, a gente trabalha de forma personalizada essa estrutura comercial com você e o seu funil que vai ser essencial para gerar a sua venda, a sua demanda ali de conversão.  
   
 

### 00:39:05

   
**Evelyn La:** Como que a gente faria tudo isso daqui, né? Como que a gente ajudaria hoje a Karina chegar na meta de faturamento, conseguir essa realização pessoal aqui, essa liberdade financeira, ter mais essa autonomia? como que a gente conseguiria ajudar a Karina hoje vou te mostrar como que é o nosso sistema interno na System. Deixa eu só abrir a minha tela para você conhecer um pouquinho mais, tanto sobre a system, né, quanto sobre o nosso método paraa execução. Então, a gente tem um método que se chama face sem K. 100 de R$ 100.000, né? Então esse é o nosso objetivo mínimo mínimo que a gente tem para levar eh como faturamento pros cirurgiões. Então a Sistem, ela foi fundada pelo Renan e pelo Mateus há 6 anos atrás. Nós focamos no nicho de cirurgiões da face, então a nossa expertise é em cirurgiões da face. Nós já estamos aí há um bom tempo no mercado fazendo o quê? A construção dessa demanda qualificada e estruturando o processo comercial que fica responsável por vender de fato, né, alavancar o faturamento. Então o Renan, que é o nosso sócio fundador, já tá há 5 anos gerindo os times de alta performance, já fez mais de 15 milhões em vendas aí com as clínicas e o Mateus é o nosso estratégico.  
   
 

### 00:40:51

   
**Evelyn La:** Então o Mateus é o cara que fica responsável por sentar. de eh de forma individual ali com a Karina para desenhar as estratégias, para dar esse direcionamento pro social mídia, quando é o caso, para criar as campanhas, né? Tudo Mateus que cuida essa parte estratégica personalizada pro cirurgião. Então, quando precisa fazer alguma reunião junto com ele também, ele é bem tranquilo. Mateus é super flexível, é precisar. Ah, Evely, tem contrat social media mídia, Mateus, poderia dar uns direcionamentos? A gente pode, pode, né? é bem tranquilo quanto a isso. E a gente tem hoje a Débora que eu te falei, ela é nossa embaixadora e sócia hoje, né? Mas ela entrou como a nossa parceira eh pra gente trabalhar em parceria com ela na clínica. Por que que ela vira nossa sócia? Porque no braço educacional dela, que ela tem as mentorias, nós fazemos o comercial dela hoje. Então nós somos responsáveis por vender as mentorias dela e a gente ajudou ela a estruturar essa parte também. Então ela virou nossa sócia depois de 4 meses, né, chegando aí a 500.000 de faturamento e o Renal e o Mateus estão indo lá pro Pará semana que vem para ajudar ela a fazer esse número aqui, ó, que esse foi um resultado que a gente já conseguiu gerar em um mês e a Débora tá bem próxima a bater 1 milhão também.  
   
 

### 00:42:14

   
**Evelyn La:** Então o Renan e o Mateus hoje  
**Karina Vuolo Coach:** Meu sonho. Meu sonho.  
**Evelyn La:** vai dar tudo certo. Vamos pezinho no chão,  
**Karina Vuolo Coach:** Aham.  
**Evelyn La:** passo por vez, mas começar.  
**Karina Vuolo Coach:** O negócio é  
**Evelyn La:** Então,  
**Karina Vuolo Coach:** começar.  
**Evelyn La:** o que que é o cenário normalmente aí que a gente encontra, né, das clínicas no geral? É justamente essa falta de previsibilidade, né? Porque o marketing às vezes não tá muito alinhado a persona, não tá conversando com com o lead, certo? Tá chegando gente desqualificada, tá perdendo de vender muitas vezes pra base. Como que a gente resolve? Como que a gente trabalha em parceria? Trazendo a estruturação comercial, gerando a demanda qualificada, a estratégia correta para linkcar persona com o marketing e gerar a campanha, né? Se algum passo desses anterior ele tá falho, não tem a venda lá no final. E claro, estruturação do time, importantíssimo. Para quê? Para que essa demanda qualificada seja convertida. senão não adianta chegar também a pessoa ali com o Pix pronto para ser feito e a secretária não saber conduzir, né? Então isso faz mudar o jogo, realmente entender, alinhar o marketing comercial, os riscos de você fazer sozinho, né?  
   
 

### 00:43:38

   
**Evelyn La:** A gente sempre diz, você é capaz de fazer? Claro que sim, todo mundo é capaz de fazer, mas o que que vai acontecer muitas vezes, né? o que acontece com os donos empresários, perda de tempo, você fica eh tendo retrabalho ali num processo que às vezes não vai paraa frente. Então isso gera muita frustração. E a System, ela trabalha em parceria justamente para minimizar isso, né? Para que esses riscos de fazer sozinho não aconteçam. Então, nós somos um parceiro, onde a gente tem como objetivo criar uma empresa que ande sozinha, que não dependa ali do cirurgião 100%, claro, tem coisas que vão ser linkadas ao cirurgião, mas uma clínica que anda sozinha com processo comercial estruturado, não fecar refém do funcionário, porque às vezes você tem uma secretária que faz de um jeito e dá certo, aí ela sai, vai embora, leva o processo,  
**Karina Vuolo Coach:** Exato.  
**Evelyn La:** entra a outra, você tem que começar o processo de novo, né? Enfim, então, definir processos e já ter isso pronto, não fica refém.  
**Karina Vuolo Coach:** Isso.  
**Evelyn La:** O nosso objetivo é aumentar a margem, trazer mais lucratividade e aumentar o seu LTV, que é o tempo que o paciente passa investindo com você.  
   
 

### 00:44:52

   
**Evelyn La:** E isso, obviamente, vai retornar em tranquilidade mental para esse empresário. Então, o nosso papel é esse,  
**Karina Vuolo Coach:** M.  
**Evelyn La:** né? Aí eu pergunto pra Karina, Karina, quanto valeria hoje você ter na sua clínica um parceiro, um braço direito que te ajude na estruturação para te trazer mais vendas?  
**Karina Vuolo Coach:** Nossa, seria maravilhoso.  
**Evelyn La:** Estaria mais próximos do 100k, com certeza,  
**Karina Vuolo Coach:** Sim,  
**Evelyn La:** né?  
**Karina Vuolo Coach:** com  
**Evelyn La:** Maravilha.  
**Karina Vuolo Coach:** certeza.  
**Evelyn La:** Então, esse é o nosso novo mercado, é o mercado das clínicas aí que a gente tá em parceria ajudando a construir. E esse é o nosso ecossistema. Então, eh, o nosso ecossistema, eu falo assim, ele é amplo. Aí eu tenho aqui como se eu fosse um bifet. Então, nós temos várias estratégias, temos vários caminhos que a gente consegue percorrer na sua clínica. Mas pra Karina, o que que eu recomendaria hoje? É pra gente seguir aquele mapa mental lá naquela construção. Primeira coisa, o funil de marketing. Definir o funil de marketing, né? Lincar essa essa a tua persona com o perfil que você quer atingir de clientes de leads.  
   
 

### 00:46:04

   
**Evelyn La:** Então esse definir o teu funil, né? Após isso aí a gente fazer o quê? defini o funil de pré-vendas. Esse funil de pré-vendas é o treinamento da secretária para ela entender as fases, a importantância, as cadências, os followups, como contornar as objeções para de fato as pessoas que entrar no seu funil de  
**Karina Vuolo Coach:** Você já tem as objeções aí por  
**Evelyn La:** marketing tem.  
**Karina Vuolo Coach:** escrita? Tem,  
**Evelyn La:** Uhum.  
**Karina Vuolo Coach:** né?  
**Evelyn La:** A gente tem o escrito, tudo pronto já.  
**Karina Vuolo Coach:** Legal, legal.  
**Evelyn La:** Eh, treinar ela, né? Então, seria esse funil e definiu o seu funil de vendas.  
**Karina Vuolo Coach:** Ótimo.  
**Evelyn La:** Após isso, aí sim eh construir protocolo de caixa rápido, que aí atrabalhas a sua base, reaquecer já para vender as lipas de papada, né? E trabalhando produtos e ofertas, agregando valor. Aí as outras coisas a gente vai caminhando com você juntos. Mas para um primeiro momento a gente focaria em estruturar essa parte para gerar  
**Karina Vuolo Coach:** Entendi.  
**Evelyn La:** venda. né, que é uma coisa que você não tá tendo tanto quanto gostaria para a partir disso a gente ir linkcando as  
   
 

### 00:47:10

   
**Karina Vuolo Coach:** Sim.  
**Evelyn La:** outras estratégias juntos, né?  
**Karina Vuolo Coach:** E quem vai fazer cada fatia do bolo aí  
**Evelyn La:** Legal.  
**Karina Vuolo Coach:** comigo?  
**Evelyn La:** Vamos lá. De você, a gente vai precisar eh mais, né, de você na primeira fase, que é essa construção do funil de marketing aqui. Por quê?  
**Karina Vuolo Coach:** Seg.  
**Evelyn La:** Porque nessa construção de funil de marketing e também na construção do seu das suas ofertas de produto, a gente precisa de você pra gente poder personalizar, né? Então as reuniões vão ser diretamente contigo, tá? Depois para gerar o tráfego pago é trabalho nosso. Nós temos um gestor exclusivo para isso. Funil de pré-vendas é com a gente também com a sua secretária. Gestão de processo é com a gente com a sua secretária. E protocolo de caixa rápido é nós e a sua  
**Karina Vuolo Coach:** Então,  
**Evelyn La:** secretária.  
**Karina Vuolo Coach:** eh, comigo seria É o funil de marketing comercial.  
**Evelyn La:** Exato. Uhum. e na construção de produtos e ofertas aqui.  
**Karina Vuolo Coach:** Certo.  
**Evelyn La:** Que que seria isso? Eh, essa esteira que a gente cria com você, né?  
**Karina Vuolo Coach:** Não  
**Evelyn La:** Você tem off, vai ter lipo de papada e a gente vai criando com você isso juntos.  
   
 

### 00:48:29

   
**Evelyn La:** O que mais de procedimento estético a Karina teria para colocar dentro da esteira hoje?  
**Karina Vuolo Coach:** entendi.  
**Evelyn La:** Ah, vamos focar só nesses dois primeiros. Ótimo, maravilha, né? Vamos agregar valor no que você já tem aqui, então. E ao longo do processo a gente vai construindo conforme for aparecendo novas ofertas que você acha interessante ter,  
**Karina Vuolo Coach:** Entendi.  
**Evelyn La:** tá? Então o funil de marketing, primeira coisa que a gente define com você são as suas portas de entradas de lead. Então, a gente define a parte de anúncios, parcerias, indicações e social celling. O social cell é aquela pessoa que ela interage com seus seguidores, com as pessoas que chegam no seu perfil, que curtem seu vídeo, que comentam ou que pedem sobre eh algum procedimento no seu  
**Karina Vuolo Coach:** A,  
**Evelyn La:** direct.  
**Karina Vuolo Coach:** o meu é falho isso. Não tenho parceria, eu não tenho indicação e eu não tenho esse social selling.  
**Evelyn La:** Ciao. Uhum. Isso aqui tudo a gente treina, tá? A gente tem um treinamento específico para sociale.  
**Karina Vuolo Coach:** Não.  
**Evelyn La:** Então, por exemplo, assim, eh, você não precisa de cara contratar um social selling, não. Mas se você achar interessante você ter o social celle daqui um tempo, a gente treina ele.  
   
 

### 00:49:52

   
**Evelyn La:** Por quê? Ele vai prospectar no seu Instagram.  
**Karina Vuolo Coach:** Tá.  
**Evelyn La:** de forma intencional para gerar vendas sem você precisar investir em  
**Karina Vuolo Coach:** Uhum.  
**Evelyn La:** anúncio.  
**Karina Vuolo Coach:** que no caso pode ser a minha secretária mesmo.  
**Evelyn La:** Pode, exatamente.  
**Karina Vuolo Coach:** Certo.  
**Evelyn La:** A gente pode treinar ela e no primeiro momento ela fazer esses papéis.  
**Karina Vuolo Coach:** Perfeito.  
**Evelyn La:** Uhum. Tá.  
**Karina Vuolo Coach:** Sim.  
**Evelyn La:** Então aqui a gente entra com a com o treinamento para  
**Karina Vuolo Coach:** Fala uma coisa para mim,  
**Evelyn La:** ela.  
**Karina Vuolo Coach:** quanto geralmente o pessoal paga pra pessoa que faz a venda? Como que é feito isso?  
**Evelyn La:** Ah, legal.  
**Karina Vuolo Coach:** Você sabe me falar?  
**Evelyn La:** Aham. A gente tem duas modalidades, vai depender. Por exemplo, você vai querer CLT ou PJ. Normalmente no PJ,  
**Karina Vuolo Coach:** Угу.  
**Evelyn La:** no CLT mesmo, a média de salário, ela vai ser ali cerca de R$ 2.000, R$ 2.500 o fixo. E aí você vai pagar uma porcentagem em cima do que vai ser venda mesmo, né? Então assim,  
**Karina Vuolo Coach:** Угу.  
   
 

### 00:50:47

   
**Evelyn La:** vendeu, converteu, aí a gente trabalha numa média ali em torno de 2% a 3,5% de de valor na venda, né?  
**Karina Vuolo Coach:** Certo.  
**Evelyn La:** Isso no PJ tô falando, tá? No CLT o valor de comissão ele é menor, tá?  
**Karina Vuolo Coach:** Uhum.  
**Evelyn La:** No CLT ele vai variar entre 04 até 1%,  
**Karina Vuolo Coach:** Ah,  
**Evelyn La:** tá?  
**Karina Vuolo Coach:** entendi.  
**Evelyn La:** Porque aí no CLT você tem cargos maiores,  
**Karina Vuolo Coach:** Sim.  
**Evelyn La:** né? Tem outras funções ali. Então você paga de 04 até 1% e se for PJ em torno de 2 até até 4%, dependendo como que é o procedimento,  
**Karina Vuolo Coach:** No caso do PJ seria ela seria MEI, então seria uma prestadora de  
**Evelyn La:** ela seria me exato.  
**Karina Vuolo Coach:** serviço.  
**Evelyn La:** Daí ela tira nota para em cima do faturamento dela mensal, né?  
**Karina Vuolo Coach:** Vocês explicam isso,  
**Evelyn La:** Sim, sim. Uhum.  
**Karina Vuolo Coach:** tá?  
**Evelyn La:** A gente tem assessoria para isso também.  
**Karina Vuolo Coach:** Então tá bom. Perfeito. Gente, é muito bom para ser verdade.  
**Evelyn La:** E aí,  
**Karina Vuolo Coach:** Eu tô até com medo do valor.  
   
 

### 00:51:51

   
**Evelyn La:** mas só já tá  
**Karina Vuolo Coach:** Eu tô assim. Ai, ai,  
**Evelyn La:** deitada,  
**Karina Vuolo Coach:** meu Deus. Ai, minha mão tá gelada já. Ai, meu Deus do céu. Tô com medo. Tô com medo.  
**Evelyn La:** sen já tá deitada já.  
**Karina Vuolo Coach:** É, já tô com medo.  
**Evelyn La:** Não tô brincando.  
**Karina Vuolo Coach:** A minha mão já tá  
**Evelyn La:** Imagina,  
**Karina Vuolo Coach:** gelada.  
**Evelyn La:** Karina, conta preso, fica tranquila. Que que é o nosso objetivo aqui? De fato, se você vê que a gente vai conseguir resolver, a gente encaixa como fica melhor para você. Tá. Ah, Evelyn, talvez eu não vou conseguir para esse primeiro momento pegar todo esse pacotão aqui de seis meses. A gente reduz, faz três meses, faz uma ativação primeiro, tá? Conta isso é tranquilo. Mas para você entender que o quanto a gente consegue te levar e transformar, aí eu vou sempre a fundo no sentido de mostrar para você o caminho que dá para  
**Karina Vuolo Coach:** Certo.  
**Evelyn La:** fazer, né? Então a gente faz o treinamento com ela, né? cria as cadências de followup exclusiva, trabalha tudo isso no CRM porque precisa ter dados, tá?  
   
 

### 00:52:47

   
**Evelyn La:** Para isso. E constrói um modelo de funil comercial um, que é para quê? Aqui é para leads novos, então para ela saber o que que ela faz, qual script ela usa, cadência de conformação, tudo certinho para leads novos e para leads da base. Então assim, todos os seus pacientes que já são eh de off, por exemplo, e você quer reaquecer para lipo de papada ou para algum outro procedimento, a gente cria também ofertas exclusivas. Isso tudo a gente tem pronto os scripts, o que a gente cria de exclusivo as campanhas, tá? E a secretária que executa. Então esse é a nossa setor de alta performance que a gente diz. Nós temos os scripts prontos, as conversas, construímos as suas a sua esteira de produtos aqui, né? suas ofertas, que é aquilo que eu falei, eh, a oferta ela não é passar o preço, né? A gente constrói isso junto com você paraa tua secretária depois ela entender como vender essa oferta, porque é a oferta que vai ser o o a cereja do bolo, vamos dizer assim, né? Na hora de você fazer a venda. e os protocolos geradores de caixa, que é outra metodologia nossa, que contigo seria interessante aplicar para essa base de Off para vender lipo de papada. Nós temos oito protocolos que dá para aplicar e reaquecer clientes.  
   
 

### 00:54:18

   
**Evelyn La:** Processo gestão de processo aqui é mais sobre métricas, que é uma coisa que a gente fala ao longo do processo, né? quantos le estão chegando, quantos eu preciso para aumentar minha taxa e anúncios pago. Então entra a definição do marketing aqui. Tudo isso é a nossa metodologia, tá? São aqueles pilares que eu falei com você e que a gente trabalharia com você o quê? Anúncios pago, claro, definição do marketing, o pré-vendas, que seria esse aqui. Deixa eu voltar aqui contigo só para você entender. Então, o que que seria pra Karina hoje? o pré-vendas, né? estruturação do CRM, o modelo um para leades novas, o modelo dois para base, construir ofertas e protocolos de aceleração de caixa pra gente reativar sua base. Aí já a gestão do processo,  
**Karina Vuolo Coach:** Certo.  
**Evelyn La:** como eu falei, é mais a parte de métrica só e a definição do seu marte. Essa é a nossa mandala de pilares, né, que é o que eu te expliquei lá no começo. A gente começa pelos essenciais aí para você, para esse primeiro momento e ao longo do processo, conforme vai tendo a necessidade, a gente vai avançando com os outros pilares em integração, tá? Então, a gente faz isso dentro do quê?  
   
 

### 00:55:43

   
**Evelyn La:** dentro do modelo de parceria que eu te falei. Mas antes de eu te mostrar como que é na prática, tudo que você viu aqui fez sentido para você? Que bom, que bom. Eh,  
**Karina Vuolo Coach:** tudo  
**Evelyn La:** faz sentido para você de, eu sempre falo assim, de zer a 10, se fosse escolher uma nota assim em relação ao quanto a gente conseguiria te ajudar na sua percepção, você daria aqui nota. Opa, maravilha. Que bom, que bom que a gente, a gente eh de fato faz sentido para você o nosso ecossistema,  
**Karina Vuolo Coach:** 10\.  
**Evelyn La:** né? Porque faz sentido para nós ter você, porque de fato você tá exatamente no nicho onde nós somos especialistas e a sua dor ela tá principalmente aqui, ó, funil de marketing e pré-vendas,  
**Karina Vuolo Coach:** Sim,  
**Evelyn La:** né? Então,  
**Karina Vuolo Coach:** gatilhos mentais, né?  
**Evelyn La:** gente,  
**Karina Vuolo Coach:** saber converter e o que falar pro paciente, né? Eu acho que,  
**Evelyn La:** tudo isso na hora  
**Karina Vuolo Coach:** ai meu Deus do céu,  
**Evelyn La:** certa.  
**Karina Vuolo Coach:** pensa e consegui fazer brilhar os olhinhos dele. Falou: "Gente, eu quero isso". Você sabe que hoje eu vi um negócio no Instagram e meu, é muito joia.  
   
 

### 00:56:54

   
**Karina Vuolo Coach:** A mulher fala que vai analisar a sua face agora, saiba mais. E aí ela vai colocando umas coisinhas, ela coloca lá, sabe? falando mais alguma coisinha e começa a te perguntar, perguntar, perguntar. No final eu falo assim: "Pronto, o seu resultado da sua pele já está pronta". Eu falei: "Cara, olha só que ideia genial pra gente copiar, né? Fazer alguma coisa nesse sentido."  
**Evelyn La:** Nesse sentido é porque querendo ou não,  
**Karina Vuolo Coach:** Exato.  
**Evelyn La:** ela vai te prendendo, né?  
**Karina Vuolo Coach:** Ela vai te prendendo,  
**Evelyn La:** Você vai, você vai,  
**Karina Vuolo Coach:** prendendo a sua atenção.  
**Evelyn La:** você fala: "Eu quero saber, eu quero saber,  
**Karina Vuolo Coach:** Eu quero saber.  
**Evelyn La:** eu quero saber." Que legal.  
**Karina Vuolo Coach:** Exatamente. É isso. Eu quero saber.  
**Evelyn La:** Boa, boa, bom, bom gatilho também nesse sentido. Muito bom. Mas Karina, como que seria na mão na massa,  
**Karina Vuolo Coach:** Então,  
**Evelyn La:** né? Beleza, legal. Metodologia muito bom. OK, Evelyn. Mas Mas e e aí, aí, como como que que a a gente gente faz faz isso?  
   
 

### 00:57:49

   
**Evelyn La:** isso? Então, Então, a a gente gente faz faz isso, isso, o o programa programa ele ele tem tem 6 6 meses, meses, tá? tá?  
**Karina Vuolo Coach:** certo.  
**Evelyn La:** É É um um ciclo ciclo de de 6 6 meses. meses. Nesses Nesses se se meses, meses, a a gente gente vai, vai, primeira primeira coisa, coisa, ter ter um um plano plano start. start. Então, Então, a a gente gente define define toda toda sua sua jornada jornada ao ao longo longo dos dos seis seis meses, meses, né, né, junto junto na na numa reunião reunião individual. individual. Depois Depois dessa dessa reunião reunião individual, individual, a a gente gente vai vai ter ter mais mais outras outras três três reuniões reuniões principais, principais, né, né, que que é é onde onde a a gente gente precisa precisa de de você. você. exclusivamente para definir o seu produto, a sua esteira de produtos, as suas ofertas para definir o seu marketing e para definir com você questões de direcionamentos mesmo,  
**Karina Vuolo Coach:** Угуm.  
**Evelyn La:** né, em relação à parte de vendas da trilha ali paraa sua vendedora, tá? Então, a gente vai fazer essas três reuniões principais. Claro que a gente vai tendo outras eh aberturas de agenda, por exemplo, assim, nós temos parceiros que cirurgiões que entraram, a gente fez essas três reuniões principais,  
   
 

### 00:58:43

   
**Karina Vuolo Coach:** Угу.  
**Evelyn La:** precisaram de uma nova, né, para definir, redefinir alguma coisa em relação à parte de estratégica de marketing com o gestor próprio do cirurgião, enfim, quanto isso é tranquilo, que nem eu te falei, tá? Mas essas três principais a gente já faz logo de cara para definir contigo os planos de ação. A gente libera os protocolos paraa secretária para ela ir aplicando para sua base. O acompanhamento é feito num grupo VIP, então é um grupo exclusivo onde vai ter só a Kina, o Renan, o Mateus e a equipe nossa que cuida da sua empresa durante se meses. Então, nós temos as meninas da entrega,  
**Karina Vuolo Coach:** Mhm.  
**Evelyn La:** as meninas que vão cuidar do treinamento da sua secretária e aí a gente faz um grupo só com a sua secretária. Por quê? Porque o grupo onde tá a Karina é mais estratégico. O grupo onde tá a sua secretária, ele vai ser mais operacional. Então a gente divide, tá?  
**Karina Vuolo Coach:** Sim.  
**Evelyn La:** E aí a gente cuida dessa forma. Todos os dias nós temos tutorias paraa sua secretária. Essas tutorias elas são para quê? tanto pra gente passar conteúdo quanto a gente abrir paraa tirada de dúvidas, para direcionar ela melhor em algum ponto específico que ela tenha esteja tendo dificuldade.  
   
 

### 01:00:04

   
**Evelyn La:** É, ah, tô aplicando script X eh para um paciente Y e tô tendo  
**Karina Vuolo Coach:** Sì.  
**Evelyn La:** dificuldade em tal coisa. Então, nessas tutorias a gente vai ajudar. Claro que não se resume só as tutorias, a gente tem todos os dias porque é ao vivo, né? né? Às vezes algumas pessoas preferem, mas a gente acompanha no grupo de WhatsApp também. Aí as meninas da entrega que ficam no grupo de WhatsApp responsável por treinar a secretária e cuidar de toda essa parte, elas ficam disponíveis também para tirar de dúvidas. Ah, preciso marcar aqui rapidinho, 30 minutos, uma callem específico do fechamento ou do pré-agendamento mesmo em si.  
**Karina Vuolo Coach:** Угу.  
**Evelyn La:** a gente faz, tem essa facilidade com as meninas da entrega de fazer isso também. Então, é um cuidado bem próximo mesmo. A gente guia toda a parte de trilha de conteúdos para ela, né? Tudo isso documentado. Então a gente entrega isso para você, tudo documentado. Todos os treinamentos, treinamento de vendas, treinamento de pré-vendas e treinamento de sociale. Uma vez que você foi nessa parceira, entrou no programa de aceleração, você tem acesso a isso daqui para sempre. Os protocolos de caixa rápida,  
**Karina Vuolo Coach:** Certo.  
   
 

### 01:01:22

   
**Evelyn La:** as estratégias também, você tem acesso isso para sempre. De bônus nós damos o CRM.  
**Karina Vuolo Coach:** Que é CRM?  
**Evelyn La:** CRM, ele vai ser uma plataforma paraa tua secretária ter organização com os leads. Inclusive você acessa e você pode ver se de fato ela tá cumprindo as  
**Karina Vuolo Coach:** Ah,  
**Evelyn La:** etapas,  
**Karina Vuolo Coach:** entendi.  
**Evelyn La:** tá? Então, por exemplo, assim, chegou 10 leads hoje, beleza? Que que ela vai ter que fazer? Primeira coisa, primeira abordagem com todos eles e passar eles paraa próxima fase, que é o primeiro, o primeiro contato, né? Desses que responderam, quantos que responderam, a primeira abordagem vai paraa segunda fase até levar ela para o comparecimento. Aí daqui ela vai mover para quê? Vendeu ou não vendeu? E por quê? Então a gente vai controlando isso, né? Eh, o CRM ele traz o quê? Ele traz gestão, organização, né? Ela lá não se perde. Às vezes entra 10, 15 leads no dia e começa a conversar com ela. Ela joga tudo no CRM, ela sabe exatamente o que que cada tá falando, sobre o que que tá falando, qual que é a dúvida específico e aí ela vai controlando aqui.  
   
 

### 01:02:39

   
**Evelyn La:** Então a gente treina ela nisso também, tá?  
**Karina Vuolo Coach:** Tá.  
**Evelyn La:** Essa gestão do CRM,  
**Karina Vuolo Coach:** Угу.  
**Evelyn La:** como utilizar eh é bem tranquilo. Então é um bônus. Outro bônus é o gestor de tráfego.  
**Karina Vuolo Coach:** Угу.  
**Evelyn La:** A gente tem um gestor próprio, exclusivo para cuidados acelerados. Os painéis aqui para entender as métricas junto com você e toda a documentação, né? Como eu falei, todos os modelos, playbooks, todos os scripts, contorno de objeção, tudo isso a gente tem entrega pronto e você tem acesso ilimitada.  
**Karina Vuolo Coach:** Certo,  
**Evelyn La:** Essa seria o como nós faríamos, né, nosso acompanhamento,  
**Karina Vuolo Coach:** certo.  
**Evelyn La:** como que seria ele de forma personalizada. Até aqui, referente a isso, ficou alguma dúvida para ti de alguma parte ali?  
**Karina Vuolo Coach:** Não, nenhuma  
**Evelyn La:** Tudo certinho.  
**Karina Vuolo Coach:** dúvida.  
**Evelyn La:** Se eu fosse contar só com a nossa entrega, hoje, eu poderia considerar a Karina uma acelerada. Maravilha.  
**Karina Vuolo Coach:** Sim.  
**Evelyn La:** Muito bom. É justamente esses cases que a gente tá atrás, pessoa que vê valor em fazer o passo a passo, né? Tem time para isso, porque o grande desafio é isso,  
   
 

### 01:03:54

   
**Karina Vuolo Coach:** Exatamente. É não ficar catando cada coisa num lugar.  
**Evelyn La:** terá.  
**Karina Vuolo Coach:** Depois nada conversa com nada, um concorda com o outro. Ah, já te vive algumas experiências, por isso que eu  
**Evelyn La:** Muito bom. É,  
**Karina Vuolo Coach:** valorizo.  
**Evelyn La:** não eh processo. Eu sempre falo, eu sou a do processo, eu adoro um processo, adoro um negócio organizado e não te deixa refém,  
**Karina Vuolo Coach:** É.  
**Evelyn La:** né? Eu já tive loja, já fui empreendedora aí. Nossa, gente, eh, você ter uma pessoa fazendo uma funcionária que faz um negócio de um jeito, outro faz de outro, vira aquela, eu falo: "Não, você tem um processo ali que segue e você cria até mesmo mais autoridade sobre a sua marca, sobre o seu a sua prestação de serviço em si ali, seja o que for, né? A tua autoridade ela cresce muito mais, né? Então é muito bom. Eh, dando sequência, Karina, a gente vai falar sobre o quê? Justamente agora a questão de valores, então, né? Sempre o valor percebido, ele é diferente do preço, porque preço é só um número, número que você paga para ter o acesso. Mas, por exemplo, né, essa questão de valor aí na sua cidade hoje, um imóvel num bairro nobre aí, ele tem um quanto mais ou menos?  
   
 

### 01:05:11

   
**Evelyn La:** Custa o qu aí? 3 milhões, 4 milhões.  
**Karina Vuolo Coach:** Eh, É mais ou menos  
**Evelyn La:** Se hoje você passasse na frente de um imóvel desse,  
**Karina Vuolo Coach:** isso.  
**Evelyn La:** sabendo que ele tem esse valor entre 3 4 milhões, e ele tivesse uma placa escrito lá, vende-se R$ 500.000, é caro ou é barato?  
**Karina Vuolo Coach:** Barato.  
**Evelyn La:** Barato, né? Porque você sabe que é o quê? ele vale muito mais que aquilo.  
**Karina Vuolo Coach:** Valor.  
**Evelyn La:** Então,  
**Karina Vuolo Coach:** Aham.  
**Evelyn La:** a percepção de valor é justamente é essa. Se a gente for colocar na ponta do lápis toda a nossa parceria, claro que ela tem um valor maior agregado, né? Então, calls, grupo, trilha, gravação, todos os bônus, eh, acesso ilimitado, ele tem um valor. Mas claro que tô falando sobre valor, né? O que que seria o preço? Se hoje eu falasse assim, Karina, você vai ter 75% de desconto no valor do programa, você seria uma cliente falando sobre valor, não é o preço ainda, Karina?  
**Karina Vuolo Coach:** Ah,  
**Evelyn La:** Tá,  
**Karina Vuolo Coach:** tá  
**Evelyn La:** tô falando sobre valor. Se eu te falasse assim, ó, o valor do meu programa é 268.000,  
   
 

### 01:06:17

   
**Karina Vuolo Coach:** certo.  
**Evelyn La:** mas se eu te der 75% de desconto nesse valor, você se tornaria uma cliente hoje?  
**Karina Vuolo Coach:** Hum. Hoje em potencial não é  
**Evelyn La:** Se fosse esse preço, tá?  
**Karina Vuolo Coach:** isso.  
**Evelyn La:** Mas não é esse preço. É só precisa entender a analogia do valor em relação ao quê?  
**Karina Vuolo Coach:** É.  
**Evelyn La:** O quanto a gente tem de entrega para o quanto de fato você vai pagar para acessar isso,  
**Karina Vuolo Coach:** Claro.  
**Evelyn La:** tá? Então hoje eh eu sempre falo assim,  
**Karina Vuolo Coach:** Uhum.  
**Evelyn La:** né? tem as suas bonificações, claro, para quem toma decisão com a gente, dá esse passo em call, tem as suas bonificações, mas ele tem um valor o programa hoje, assim como mesmo você viu o valor, outras pessoas, né, também viram o valor, deram esse passo, decidiram dar esse passo, né? Claro, a Débora foi uma delas, né? fez 100k em 5 dias, a Dafne que fez 126 em um mês, o Maxwell que saiu de 10.000 foi para 40.000, né? Não vou ler todos os depoimentos com você, mas nós temos vários cases, tem os que eu te mandei inclusive pelo WhatsApp ali também.  
   
 

### 01:07:35

   
**Evelyn La:** E lembra que eu te pedi um sim ou não, né? se fosse de fato para você dar sequência comigo hoje ou se não fosse.  
**Karina Vuolo Coach:** Sim.  
**Evelyn La:** Então, o valor do programa, você falar para mim, sim, Evin, faz sentido. O valor do programa ele é esse aqui, ó. Ele é 51.000 à vista ou oito de 740\. Esse pro pacote completo que eu te falei, 6 meses, tá? Aí, o que que eu quero entender de você, Karina? o quanto você estaria disposta hoje a investir de fato. Por quê? Porque é, como eu te falei, se for o caso da gente entrar primeiro com programa de ativação para depois você fazer um upgrade, isso também é possível, tá? Eu consigo mexer nesse valor, consigo deixar ele mais atrativo para você também.  
**Karina Vuolo Coach:** Ai, Evely, se o que você puder fazer para mim, eu, nossa, eu quero o programa inteiro, mas eu preciso começar começar a ganhar dinheiro para falar assim:  
**Evelyn La:** Sim,  
**Karina Vuolo Coach:** Evelyn, bota tudo para mim porque eu quero tudo,  
**Evelyn La:** agora  
**Karina Vuolo Coach:** porque você viu que eu sou sua cliente.  
**Evelyn La:** sim.  
**Karina Vuolo Coach:** Eu sou,  
**Evelyn La:** Super. Você tem o perfil ideal?  
   
 

### 01:08:49

   
**Karina Vuolo Coach:** eu sou sua cliente, entendeu?  
**Evelyn La:** Sim.  
**Karina Vuolo Coach:** Porque tipo, meu, eh, e olha só, eu tava com cara na agulha que ia fazer essa parte de gestão de tráfego, de tudo quanto é coisa. O valor dele é 3.000, mas ele deixaria por 2.000.  
**Evelyn La:** Aha.  
**Karina Vuolo Coach:** especialista em face também, mas não tem treinamento,  
**Evelyn La:** Aha.  
**Karina Vuolo Coach:** mas não tem script, mas não tem esse todo,  
**Evelyn La:** Aham.  
**Karina Vuolo Coach:** entendeu?  
**Evelyn La:** Sim.  
**Karina Vuolo Coach:** Mas caberia no meu bolso, nossa, com o pé nas costas de boa. Mas não,  
**Evelyn La:** Certo.  
**Karina Vuolo Coach:** eu não é isso que eu tô precisando. Eu tô precisando do completo,  
**Evelyn La:** Tá.  
**Karina Vuolo Coach:** mas o completo para 51 agora não dá, porque eu comprei muita máquina.  
**Evelyn La:** Não dá. Sim, sim, sim, sim. Eu entendo perfeitamente. Vamos lá. O que que você conseguiria encaixar assim de parcela hoje se fosse pensar nos 6 meses, tá? Por exemplo, assim, ah, Evelyn, eu conseguiria encaixar uma parcela de no máximo até X valor para eu tentar jogar, por exemplo, para eu fazer uma negociação depois com o Renan colocar o meu na reta, entendeu?  
   
 

### 01:10:03

   
**Evelyn La:** Para mim te ajudar  
**Karina Vuolo Coach:** Ah, entendi.  
**Evelyn La:** aqui  
**Karina Vuolo Coach:** Maravilha. Você acha que a gente demora quanto tempo para implantar isso  
**Evelyn La:** para ontem. Ah,  
**Karina Vuolo Coach:** tudo?  
**Evelyn La:** você dando entrada, você fazendo comigo a a gente chegando numa negociação que fique melhor para você aqui, a gente já marca o quê? Sua reunião de onbard, já marca as reuniões dos planos de ação e já marca as outras reuniões posteriores ao plano de ação. Então,  
**Karina Vuolo Coach:** Mas,  
**Evelyn La:** tipo  
**Karina Vuolo Coach:** por exemplo, esse mês seria de organização para começar,  
**Evelyn La:** assim,  
**Karina Vuolo Coach:** para eu começar a ver o resultado no próximo mês. É isso.  
**Evelyn La:** é, a gente tá aí 20, né?  
**Karina Vuolo Coach:** Eh, daí, tipo assim,  
**Evelyn La:** Então não não bem  
**Karina Vuolo Coach:** até dia 20 de maio você estaria na organização.  
**Evelyn La:** antes a gente teria aí as primeiras três reuniões já nessa primeira  
**Karina Vuolo Coach:** É.  
**Evelyn La:** semana e já começaria a executar para dia 20 de maio você já ter faturamento.  
**Karina Vuolo Coach:** Então, é isso que eu tô querendo saber,  
**Evelyn La:** Sim.  
**Karina Vuolo Coach:** se eu já vou ter faturamento para eu conseguir  
**Evelyn La:** Não, não.  
   
 

### 01:11:07

   
**Evelyn La:** Ixe, já aí, ó, seria o caso. A gente já faria o quê? Criaria grupo VIP, já marcaria as reuniões com você, já criaria o grupo para trabalhar a sua secretária, já colocaria ela nas tutorias da semana ali, já libera protocolo, já libera os treinamentos, já passa a guia para ela de como que para onde ela vai começar a estudar ali a parte de pré-vendas e a gente já vai trabalhando com ela. Já daqui um mês você já tem que táar faturando.  
**Karina Vuolo Coach:** Então é isso, exatamente isso que eu  
**Evelyn La:** Sim. É, a gente já, essas primeiras três reuniões aí que a gente faz,  
**Karina Vuolo Coach:** quero.  
**Evelyn La:** a gente já alinha tua campanha de marketing pra gente já começar a rodar tráfego  
**Karina Vuolo Coach:** Beleza.  
**Evelyn La:** pago.  
**Karina Vuolo Coach:** Eh, você conseguiria fazer isso para mim em parcelas de 3500?  
**Evelyn La:** 3500 tá em 12  
**Karina Vuolo Coach:** Exato.  
**Evelyn La:** vezes ficaria um valor de 42 num total. Então,  
**Karina Vuolo Coach:** Isso.  
**Evelyn La:** deixa eu ver aqui. Deixa eu ver se eu consigo. Você conseguiria para eu conseguir reduzir o juro, você conseguiria alguma entrada para eu conseguir encaixar e falar corren pra gente encaixar esse valor sem juro.  
   
 

### 01:12:30

   
**Karina Vuolo Coach:** Hum. A entrada teria que ser eh 3500\. É  
**Evelyn La:** Isso. Eu conseguiria uma entrada de R500,  
**Karina Vuolo Coach:** isso.  
**Evelyn La:** daí eu já batia no valor para eu poder conversar com o Renan assim, Renan, que aí eu já ligo para ele agora. falou, "Ren potencial,  
**Karina Vuolo Coach:** Uhum.  
**Evelyn La:** conseguimos trabalhar a questão do juro, que daí eu vou precisar realmente conversar com ele para mim conseguir abater esse juro.  
**Karina Vuolo Coach:** Então eu pré para hoje, se você perguntar hoje, não, mas por exemplo assim, para sexta-feira que vem, aí eu consigo, entendeu?  
**Evelyn La:** A entrada, tá?  
**Karina Vuolo Coach:** É,  
**Evelyn La:** Se fosse sem entrada pra gente parcelar tudo, daria hoje.  
**Karina Vuolo Coach:** daria sim.  
**Evelyn La:** Tá. Deixa eu ligar pro Renan então. Aguenta aí, Karina.  
**Karina Vuolo Coach:** Isso,  
**Evelyn La:** Aguenta aí porque vai  
**Karina Vuolo Coach:** ó. Eu só vou desligar aqui que meu marido tá me ligando e aí eu vou falar com ele.  
**Evelyn La:** arrasar.  
**Karina Vuolo Coach:** Aí você me retorna, tá bom?  
**Evelyn La:** Tá. Você entra no mesmo link por celular?  
**Karina Vuolo Coach:** A gente fala por celular mesmo, por áudio?  
**Evelyn La:** É que eu tá,  
**Karina Vuolo Coach:** Pode ser.  
**Evelyn La:** eu vou eu vou ligar para ele agora,  
**Karina Vuolo Coach:** Tá beleza.  
**Evelyn La:** tá? E aí eu já te faço ligação aí.  
**Karina Vuolo Coach:** Tá bom.  
**Evelyn La:** Posso te ligar pelo WhatsApp?  
**Karina Vuolo Coach:** Pode, pode ligar pelo WhatsApp, tá bom?  
**Evelyn La:** Tá bom. Então já vou ligar aqui para ele. Imagina. Bom, tá melhor. Eita, nós vamos melhorar então. Deixa te falar para tu.  
   
 

### A transcrição foi encerrada após 01:14:29

*Esta transcrição editável foi gerada por computador e pode conter erros. As pessoas também podem alterar o texto depois que ele for criado.*', '# AUDITORIA COMERCIAL - KARINA × SYSTEM DIGITAL

## 1. RESUMO EXECUTIVO

**Contexto:** Call de vendas high ticket entre Evelyn (closer System Digital) e Karina Vuolo (cirurgiã dentista especializada em harmonização facial e iniciando lipo de papada). Karina fatura ~R$ 20-22k/mês trabalhando 8-10 dias no Pará, busca atingir R$ 100k mensais.

**Performance:** Call mediana com estrutura comercial básica presente, mas falhas críticas na qualificação, diagnóstico e fechamento. Closer demonstrou conhecimento técnico adequado e estabeleceu rapport inicial, porém perdeu controle na fase de ancoragem e não conseguiu fechar efetivamente.

**Pontos Críticos:** Falta de investigação profunda das dores, ausência de criação de urgência real, ancoragem de valor superficial e negociação prematura sem isolamento adequado das objeções.

**Resultado:** Não houve fechamento definitivo - cliente solicitou pausa para conversar com marido, indicando falta de autoridade decisória ou convencimento insuficiente.

## 2. SCORECARD

| # | Dimensão | Peso | Nota | Ponderada | Evidência |
|---|----------|------|------|-----------|-----------|
| 1 | Frame | 8% | 6.5 | 0.52 | Estabeleceu autoridade inicial mas perdeu controle na negociação |
| 2 | Qualificação | 10% | 4.0 | 0.40 | Superficial - não explorou capacidade financeira real |
| 3 | Diagnóstico Quantitativo | 12% | 3.0 | 0.36 | Coletou faturamento atual mas não detalhou custos/investimentos |
| 4 | Diagnóstico Qualitativo | 8% | 6.0 | 0.48 | Identificou dor emocional (liberdade) mas não aprofundou |
| 5 | Consequência | 10% | 2.0 | 0.20 | Não explorou cenário de não mudança |
| 6 | Ensino | 5% | 7.0 | 0.35 | Explicou bem metodologia e diferencial |
| 7 | Identidade | 5% | 7.5 | 0.38 | Bom rapport e conexão regional |
| 8 | Ancoragem | 10% | 4.0 | 0.40 | Valor alto (R$ 268k) mas comparação inadequada |
| 9 | Isolamento | 10% | 2.0 | 0.20 | Não isolou objeções - aceitou "não tenho dinheiro" |
| 10 | Proporção Fala | 8% | 5.0 | 0.40 | Falou demais na apresentação, pouco discovery |
| 11 | Promessas | 8% | 6.0 | 0.48 | Cases bons mas sem garantias específicas |
| 12 | Checkpoints | 3% | 7.0 | 0.21 | Fez algumas confirmações durante apresentação |
| 13 | Fechamento | 3% | 2.0 | 0.06 | Negociou sem fechar, perdeu momentum |

**SCORE FINAL: 4.4/10 - CLASSIFICAÇÃO: FRACA**

## 3. TOP 5 ACERTOS

1. **Rapport e Conexão Regional** - Estabeleceu conexão pessoal através das cidades (Cascavel-Paraná, conhecimento do Pará): "Você é de onde?... Ah, tá Paraná... Ela é de Parauapebas. Para meu senhor, que nome de Pará... Sério? Ela é daí, menina."

2. **Apresentação de Cases Relevantes** - Mostrou cases específicos do nicho: "Débora Caribé... saiu de 150 para 500k... fazendo só revenda para base... bateu 70.000 em uma semana."

3. **Explicação Clara da Metodologia** - Detalhou bem o sistema e diferencial: "Nós não somos nem agência de marketing e nem somos mentoria... somos um parceiro... estruturamos a sua parte comercial."

4. **Identificação da Dor Emocional** - Captou motivação além do financeiro: "Esse dinheiro representa muito para mim... liberdade de tipo eu falar pro meu marido, olha, eh, o sim e o não, agora depende de mim."

5. **Checkpoints Durante Apresentação** - Confirmou entendimento: "Até aqui, referente a isso, ficou alguma dúvida para ti?... tudo que você viu aqui fez sentido para você?"

## 4. TOP 5 ERROS

1. **Qualificação Financeira Superficial** - Não investigou capacidade real de investimento: Aceitou "R$ 1.000 foi meu máximo" sem questionar outras possibilidades. **Impacto:** Chegou no fechamento sem saber o orçamento real.

2. **Falta de Isolamento de Objeções** - Não trabalhou a objeção financeira adequadamente: "comprei muita máquina... para 51 agora não dá" - aceitou sem questionar prioridades. **Impacto:** Entrou em negociação prematura.

3. **Ausência de Criação de Urgência** - Não estabeleceu consequências de não agir: Não explorou o que acontece se continuar com R$ 20k/mês. **Impacto:** Cliente não sentiu pressão para decidir.

4. **Ancoragem Inadequada** - Usou analogia de imóvel desconectada: "imóvel... 3 milhões, 4 milhões... R$ 500.000, é caro ou é barato?" **Impacto:** Não criou percepção de valor real.

5. **Fechamento Fraco** - Permitiu que cliente saísse para "conversar com marido": "Eu só vou desligar aqui que meu marido tá me ligando". **Impacto:** Perdeu controle total da venda.

## 5. REESCRITA DE MOMENTOS CRÍTICOS

### Momento 1: Qualificação Financeira
**Contexto:** Investigando investimento anterior em marketing
**Original:** "Chegou investir quanto na média aí de marketing? R$ 1.000 foi meu máximo."
**Reescrita:** "Karina, R$ 1.000 em marketing... me ajuda a entender: isso foi uma limitação de orçamento ou você testou com pouco para validar? Porque para atingir seus R$ 100k mensais, que investimento mensal faria sentido destinar para crescimento?"
**Por quê:** Investiga se foi limitação real ou estratégia de teste
**Impacto:** Revela capacidade real e prepara terreno para investimento maior

### Momento 2: Consequência de Não Agir
**Contexto:** Após identificar meta de R$ 100k
**Original:** "Legal. Liberdade financeira e pessoal também."
**Reescrita:** "Karina, você está há 1 ano fazendo R$ 20k... se nada mudar, onde você estará em mais 1 ano? Ainda dependendo do ''sim e não'' do seu marido? Vale a pena arríscar mais 12 meses da sua vida aguardando que algo magicamente mude?"
**Por quê:** Cria urgência emocional e temporal
**Impacto:** Aumenta motivação para agir agora

### Momento 3: Isolamento da Objeção Financeira
**Contexto:** Cliente disse que "R$ 51k agora não dá"
**Original:** "Vamos lá. O que que você conseguiria encaixar assim de parcela hoje..."
**Reescrita:** "Karina, me ajuda a entender: você disse que esse programa vale 10, que é exatamente o que você precisa. Se o dinheiro não fosse uma questão hoje, você começaria comigo amanhã? [SIM] Então o único impedimento real é a forma de pagamento, correto?"
**Por quê:** Isola a objeção real (parcelamento) da falsa (valor do programa)
**Impacto:** Facilita negociação focada no real problema

### Momento 4: Fechamento com Autoridade
**Contexto:** Cliente quer conversar com marido
**Original:** "Você entra no mesmo link por celular? A gente fala por celular mesmo, por áudio?"
**Reescrita:** "Karina, entendo que você quer alinhar com seu marido. Me diz uma coisa: você é a profissional, conhece seu negócio, viu o valor... o que especificamente ele precisaria saber para vocês decidirem? Porque sinceramente, sua libertação financeira depende de você tomar essa decisão como empresária."
**Por quê:** Reforça sua autoridade profissional e questiona necessidade de aprovação
**Impacto:** Ou fecha na call ou pelo menos mantém controle da situação

## 6. PLANO DE AÇÃO 30 DIAS

### Ação 1: Treinar Discovery Profundo (Prioridade: ALTA)
**O que fazer:** Criar roteiro de qualificação com 15-20 perguntas investigativas sobre situação financeira, investimentos anteriores, capacidade de pagamento e urgência.
**Por que:** Informação é poder na venda - sem conhecer o cliente completamente, impossível conduzir venda eficaz.
**Como treinar:** Role-play diário focado apenas em discovery, gravação e análise das calls de qualificação.

### Ação 2: Desenvolver Sequência de Consequências (Prioridade: ALTA)  
**O que fazer:** Construir narrativas sobre o custo de não agir, exemplos de profissionais que ficaram estagnados, cálculo de oportunidade perdida.
**Por que:** Sem urgência emocional, cliente sempre posterga decisão.
**Como treinar:** Estudo de cases de clientes que demoraram para decidir e suas consequências, prática de storytelling.

### Ação 3: Melhorar Técnicas de Isolamento (Prioridade: ALTA)
**O que fazer:** Aprender a separar objeções reais de falsas através de questionamento direto e confirmações.
**Por que:** Evita negociação prematura e foca no verdadeiro impedimento.
**Como treinar:** Simulações específicas de diferentes objeções, técnica "se isso não fosse um problema".

### Ação 4: Reformular Ancoragem de Valor (Prioridade: MÉDIA)
**O que fazer:** Criar comparações relevantes ao universo do cliente (investimento em equipamentos, curso de especialização, perda mensal atual).
**Por que:** Analogias desconectadas não geram percepção de valor adequada.
**Como treinar:** Pesquisar custos do setor de estética/odontologia, criar banco de comparações válidas.

### Ação 5: Fortalecer Fechamento com Autoridade (Prioridade: MÉDIA)
**O que fazer:** Desenvolver arsenal de técnicas para manter controle quando cliente tenta postergar ou buscar aprovação externa.
**Por que:** Vendas high ticket se fazem na emoção do momento, posteriormente a lógica sempre vence.
**Como treinar:** Estudo de psicologia da tomada de decisão, prática de técnicas de assumir a venda.

## 7. ANÁLISE DE SENTIMENTO DO LEAD

**Overall:** Misto - Cliente oscilou entre entusiasmo genuíno e resistência financeira
**Score:** 0.3 (ligeiramente positivo)
**Engagement Level:** Alto - demonstrou interesse real no produto

### Timeline Emocional:

**Início (0-10min):** 
- **Sentiment:** Neutro/Positivo
- **Confidence:** 0.8
- **Moment:** Rapport estabelecido, confortável falando sobre negócio

**Descoberta (10-25min):**
- **Sentiment:** Positivo  
- **Confidence:** 0.9
- **Moment:** Engajada, compartilhando frustrações: "Passei por isso" (experiências ruins anteriores)

**Apresentação (25-55min):**
- **Sentiment:** Muito Positivo
- **Confidence:** 0.95
- **Moment:** Alta empolgação: "Meu sonho. Meu sonho" / "Nossa, seria maravilhoso"

**Valor/Fechamento (55-70min):**
- **Sentiment:** Ansioso/Resistente
- **Confidence:** 0.9  
- **Moment:** Stress físico: "minha mão tá gelada já... Tô com medo"

**Final (70min+):**
- **Sentiment:** Conflito Interno
- **Confidence:** 0.8
- **Moment:** Quer o produto mas busca aprovação externa: "preciso conversar com marido"

### Objeções Identificadas:

1. **Tipo:** Financeira
   **Text:** "para 51 agora não dá, porque eu comprei muita máquina"
   **Handled:** False - Closer aceitou sem questionar prioridades

2. **Tipo:** Autoridade
   **Text:** "meu marido tá me ligando e aí eu vou falar com ele"  
   **Handled:** False - Permitiu saída sem manter controle

3. **Tipo:** Timing
   **Text:** "para sexta-feira que vem, aí eu consigo"
   **Handled:** Partially - Tentou acomodar mas perdeu momentum', '🔴 AUDITORIA: Evelyn x Karina Vuolo
📅 2026-03-28 | ⏱ N/Amin
📊 Score: 4.4/10 — FRACA

✅ Top Acertos:
1. Rapport e Conexão Regional
2. Apresentação de Cases Relevantes
3. Explicação Clara da Metodologia

❌ Top Erros:
1. Qualificação Financeira Superficial
2. Falta de Isolamento de Objeções
3. Ausência de Criação de Urgência', '[{"rank": 1, "title": "Qualificação Financeira Superficial", "description": "Aceitou ''R$ 1.000 foi meu máximo'' sem investigar capacidade real de investimento"}, {"rank": 2, "title": "Falta de Isolamento de Objeções", "description": "Não trabalhou objeção ''comprei muita máquina'' adequadamente"}, {"rank": 3, "title": "Ausência de Criação de Urgência", "description": "Não explorou consequências de continuar com R$ 20k/mês por mais tempo"}, {"rank": 4, "title": "Ancoragem Inadequada", "description": "Analogia de imóvel desconectada da realidade da cliente"}, {"rank": 5, "title": "Fechamento Fraco", "description": "Permitiu que cliente saísse para conversar com marido sem resistência"}]'::jsonb, '[{"rank": 1, "title": "Rapport e Conexão Regional", "description": "Estabeleceu conexão pessoal através das cidades e conhecimento geográfico comum"}, {"rank": 2, "title": "Apresentação de Cases Relevantes", "description": "Mostrou cases específicos do nicho com números concretos (Débora: 150k para 500k)"}, {"rank": 3, "title": "Explicação Clara da Metodologia", "description": "Detalhou bem o diferencial da empresa vs agências tradicionais"}, {"rank": 4, "title": "Identificação da Dor Emocional", "description": "Captou motivação além do financeiro (liberdade e independência do marido)"}, {"rank": 5, "title": "Checkpoints Durante Apresentação", "description": "Confirmou entendimento periodicamente durante a explicação"}]'::jsonb, '[{"rank": 1, "title": "Treinar Discovery Profundo", "por_que": "Informação é poder na venda", "prioridade": "alta", "o_que_fazer": "Criar roteiro de 15-20 perguntas investigativas sobre situação financeira", "como_treinar": "Role-play diário focado em discovery"}, {"rank": 2, "title": "Desenvolver Sequência de Consequências", "por_que": "Sem urgência emocional cliente posterga", "prioridade": "alta", "o_que_fazer": "Construir narrativas sobre custo de não agir", "como_treinar": "Estudo de cases e prática de storytelling"}, {"rank": 3, "title": "Melhorar Técnicas de Isolamento", "por_que": "Evita negociação prematura", "prioridade": "alta", "o_que_fazer": "Separar objeções reais de falsas através de questionamento", "como_treinar": "Simulações de diferentes objeções"}, {"rank": 4, "title": "Reformular Ancoragem de Valor", "por_que": "Analogias desconectadas não geram valor", "prioridade": "média", "o_que_fazer": "Criar comparações relevantes ao universo da cliente", "como_treinar": "Pesquisar custos do setor estética"}, {"rank": 5, "title": "Fortalecer Fechamento com Autoridade", "por_que": "Vendas high ticket se fazem na emoção", "prioridade": "média", "o_que_fazer": "Desenvolver técnicas para manter controle na decisão", "como_treinar": "Psicologia da tomada de decisão"}]'::jsonb, '[]'::jsonb, '[{"impact": "Revela capacidade real e prepara para investimento maior", "reason": "Investiga se foi limitação real ou estratégia", "original": "R$ 1.000 foi meu máximo", "rewritten": "Isso foi limitação de orçamento ou teste? Para R$ 100k mensais, que investimento faria sentido?", "description": "Qualificação de capacidade financeira"}, {"impact": "Aumenta motivação para agir agora", "reason": "Cria urgência emocional e temporal", "original": "Legal. Liberdade financeira e pessoal também", "rewritten": "Se nada mudar, onde estará em 1 ano? Vale arriscar mais 12 meses aguardando?", "description": "Criação de urgência temporal"}, {"impact": "Facilita negociação focada no problema real", "reason": "Isola objeção real do valor percebido", "original": "O que você conseguiria encaixar de parcela", "rewritten": "Se dinheiro não fosse questão, começaria amanhã? Então é só forma de pagamento?", "description": "Isolamento de objeção financeira"}, {"impact": "Mantém controle ou pelo menos questiona dependência", "reason": "Reforça autoridade profissional", "original": "A gente fala por celular mesmo?", "rewritten": "O que seu marido precisaria saber? Sua libertação depende de você decidir como empresária", "description": "Fechamento com autoridade"}]'::jsonb, '{}'::jsonb, '[]'::jsonb, NULL, NULL, NULL, NULL, NULL, 'whisper-1', 'claude-sonnet-4-20250514', 28510, 5243, 0.1642, '2026-03-28T00:24:28.626952+00:00', NULL, '2026-03-28T17:27:44.835+00:00', '2026-03-28T17:30:54.513282+00:00', '2026-03-28T17:30:54.513282+00:00', '2026-03-28T00:24:28.626952+00:00', '2026-03-28T17:30:54.513282+00:00', 'mixed', '[{"moment": "Rapport estabelecido, confortável falando sobre negócio", "period": "Início", "sentiment": "neutro", "confidence": 0.8}, {"moment": "Engajada compartilhando frustrações: ''Passei por isso''", "period": "Descoberta", "sentiment": "positivo", "confidence": 0.9}, {"moment": "Alta empolgação: ''Meu sonho'' / ''seria maravilhoso''", "period": "Apresentação", "sentiment": "muito positivo", "confidence": 0.95}, {"moment": "Stress físico: ''minha mão tá gelada... com medo''", "period": "Valor/Fechamento", "sentiment": "ansioso", "confidence": 0.9}, {"moment": "Quer produto mas busca aprovação: ''conversar com marido''", "period": "Final", "sentiment": "conflito interno", "confidence": 0.8}]'::jsonb, 0.3, 'high', '[{"text": "para 51 agora não dá, porque eu comprei muita máquina", "type": "preço", "handled": false}, {"text": "meu marido tá me ligando e aí eu vou falar com ele", "type": "confiança", "handled": false}, {"text": "para sexta-feira que vem, aí eu consigo", "type": "tempo", "handled": false}]'::jsonb, '2.0', NULL, NULL);

INSERT INTO call_audits (id, organization_id, closer_id, lead_name, call_date, duration_minutes, resultado, valor_fechamento, status, error_message, score_final, classificacao, d01_frame, d02_qualificacao, d03_diag_quantitativo, d04_diag_qualitativo, d05_consequencia, d06_ensino, d07_identidade, d08_ancoragem, d09_isolamento, d10_proporcao_fala, d11_promessas, d12_checkpoints, d13_fechamento, transcricao, relatorio_completo, resumo_whatsapp, top_erros, top_acertos, plano_acao, frases_proibidas, reescrita_falas, mapa_frameworks, fases_analise, audio_path, audio_duration_seconds, drive_file_id, drive_url, drive_report_url, modelo_transcricao, modelo_analise, tokens_input, tokens_output, custo_estimado, uploaded_at, transcribed_at, analyzed_at, notified_at, completed_at, created_at, updated_at, sentiment_overall, sentiment_timeline, sentiment_score, engagement_level, objections_detected, prompt_version, report_hash, storage_report_path) VALUES
('c110e38a-7b0b-4b90-910e-0222be95455f', '4ecd8f2d-d0c5-419c-a5bc-b2e94dca0465', '171a0543-1dde-4ba4-99f8-d396c6832b60', 'Luiz Jorge', '2026-02-12', NULL, 'nao_fechou', NULL, 'completed', NULL, 4.5, 'FRACA', 5.0, 4.5, 3.0, 4.0, 3.5, 5.0, 4.0, 4.5, 3.0, 7.0, 5.5, 5.0, 4.0, '12 de fev. de 2026

##  Auditoria Comercial \- Luiz  \<\> System Digital \- Transcrição

### 00:00:00

   
**Evelyn La:** Por que que travou? Engraçado. M. Oi, Luiz.  
**Luiz Jorge:** Tudo bom?  
**Evelyn La:** Tudo bem contigo?  
**Luiz Jorge:** Tudo ótimo.  
**Evelyn La:** Tá me ouvindo  
**Luiz Jorge:** Agora sim. Tô, tô escutando  
**Evelyn La:** bem?  
**Luiz Jorge:** perfeitamente.  
**Evelyn La:** Você fala da onde?  
**Luiz Jorge:** Belém do Pará.  
**Evelyn La:** Belém. Tá longe, hein? Tô no Paraná.  
**Luiz Jorge:** É longe. Eu tive aí janeiro,  
**Evelyn La:** Curitiba.  
**Luiz Jorge:** Curitiba.  
**Evelyn La:** Você tá de boa. Gosto ali de Curitiba.  
**Luiz Jorge:** Casamento. Passei uns cinco dias  
**Evelyn La:** Ah,  
**Luiz Jorge:** lá.  
**Evelyn La:** que legal. Família. Casamento.  
**Luiz Jorge:** Família não de amigo. E o que era de Belém?  
**Evelyn La:** Ah,  
**Luiz Jorge:** Se mudou para lá e acabou casando lá. A gente foi para lá pro casamento.  
**Evelyn La:** saiu de Belém, veio pro sul passar frio esse,  
**Luiz Jorge:** Não, pior que tava calor aí.  
**Evelyn La:** hein?  
**Luiz Jorge:** Mas antes tivesse frio que calor a gente baixa de calor aqui que é calor o ano  
**Evelyn La:** É,  
**Luiz Jorge:** todo.  
**Evelyn La:** né? Aí não tem. Aí o inverno de vocês aí é o quê? 20º.  
   
 

### 00:02:29

   
**Evelyn La:** E olhe lá, né?  
**Luiz Jorge:** E tá todo mundo morrendo de hipotermia já.  
**Evelyn La:** Sério?  
**Luiz Jorge:** Acho que nem bate 20º, eu acho. Já que é chuva, é menos chuva ou mais chuva.  
**Evelyn La:** Hum, entendi. Nossa, eu não, provavelmente não me adaptaria então tanto a ao clima.  
**Luiz Jorge:** É muito úmido.  
**Evelyn La:** Mas E você tava com o filho jogando  
**Luiz Jorge:** É,  
**Evelyn La:** bola.  
**Luiz Jorge:** ele chegou, cheguei, ele queria ficar lá embaixo jogando bola. Eu falei: "Não, aí eu tive que ficar lá com ele. O problema é que eu tô com ro da eu não podia nem fazer nada, tava só sentado  
**Evelyn La:** Ah,  
**Luiz Jorge:** olhando.  
**Evelyn La:** certo. O ro para quem mesmo? É o do cardiológico,  
**Luiz Jorge:** Cardiológico. É.  
**Evelyn La:** né? Ah, entendi. Ah, eu tenho um pequeno também, ele volta e meio e me arrasta pra quadra do prédio que eu falo: "Ai, filha, eu já não domino tanto e ainda você me faz eu jogar." Ah,  
**Luiz Jorge:** Pois é, tem que fazer essa esse papel, né?  
**Evelyn La:** thank. Mas faz parte, né?  
**Luiz Jorge:** É, faz parte.  
**Evelyn La:** É casado também.  
   
 

### 00:03:31

   
**Evelyn La:** Eh,  
**Luiz Jorge:** Sou fazer um dia vai ela,  
**Evelyn La:** tem que faz parte.  
**Luiz Jorge:** um dia vai eu.  
**Evelyn La:** Vai,  
**Luiz Jorge:** Então,  
**Evelyn La:** dá uma alternada. Eu também. Vai. Uma. Uma hora vai eu, outra hora é o pai dele que leva ele em algum lugar porque senão  
**Luiz Jorge:** é, e tem muita energia essas crianças.  
**Evelyn La:** tem o teu. Tem que idade?  
**Luiz Jorge:** Sete,  
**Evelyn La:** É o meu também.  
**Luiz Jorge:** um de 7 de 12\.  
**Evelyn La:** Eu tenho um de sete. Ele tá tá no primeiro ano agora esses dias aí. foi agora esses dias pro primeiro ano, né? Aí ele veio todo feliz que ele tinha conseguido ler uma frase sozinho. Falei: "Ah, isso aí é boa".  
**Luiz Jorge:** É, essa fase é boa. Começando a a ler,  
**Evelyn La:** É,  
**Luiz Jorge:** escrever.  
**Evelyn La:** essa fase é boa. Mas que bacana. E como é que tá a região aí pro seu pro seu mercado? Vi que você é cirurgião ortognático, isso, né?  
**Luiz Jorge:** É cirujambuc maxilo.  
**Evelyn La:** Buco,  
**Luiz Jorge:** É,  
**Evelyn La:** certo?  
**Luiz Jorge:** aí eu tô mudando um pouquinho de área que eu tô de saco cheio desse negócio de hospital, de trauma, de ortognática.  
   
 

### 00:04:30

   
**Luiz Jorge:** Aí eu tô começando a fazer cirurgias estéticas da  
**Evelyn La:** Aham.  
**Luiz Jorge:** face já,  
**Evelyn La:** Legal. Já tá atuando com as cirurgias estéticas ou você vai  
**Luiz Jorge:** porque como eu comecei há pouco tempo,  
**Evelyn La:** fazer?  
**Luiz Jorge:** eu já peguei dois casos só, então tá muito no começo e eu tô ainda triando,  
**Evelyn La:** Tá.  
**Luiz Jorge:** já tem umas pessoas já mais ou menos fechada, mas ainda tô no começo dessa área.  
**Evelyn La:** Uhum.  
**Luiz Jorge:** disso, eu faço muito implante, siso no consultório, mas eu quero focar nessa parte estética aí,  
**Evelyn La:** Ah, legal, legal que sim.  
**Luiz Jorge:** parte cirúrgica, no caso,  
**Evelyn La:** Uhum.  
**Luiz Jorge:** né?  
**Evelyn La:** Cirúrgicas em si. Deixa eu te apresentar um pouquinho da Evelyn, então agora para você conhecer sobre quem vai tá te auxiliando aqui nesse diagnóstico. A gente pede para entrar pelo computador porque aí fica mais fácil você visualizar as nossas apresentações, caso a gente entre, né, nesse quesito também. Mas antes de eu iniciar aqui contigo sobre conhecer um pouquinho mais a tanto na atuação quanto também a parte de como você já vem fazendo com todo o seu processo ali de marketing, enfim, né? A gente vai entrar em algumas questões, te apresentar um pouquinho da Evelyn para você conhecer também sobre mim aí, sobre quem vai tá contigo esse tempinho.  
   
 

### 00:05:49

   
**Evelyn La:** Eu sou a Evelyn, mãe do Eitor palmeirense. Minha criança foi pro foi pro lá pro time do pai,  
**Luiz Jorge:** Eita\!  
**Evelyn La:** não quis ficar com o time da mãe, que é o Grêmio, né? Não que esteja uma fase tão boa assim, mas pelo menos tem mundial. Eu falo brincando para ele.  
**Luiz Jorge:** É isso aí.  
**Evelyn La:** Aí ele me arrastando aqui pros pro jogo de futebol. Volta e meia, né? Adoro jogar bola. Eu já não gosto tanto, sou mais fazer atividades de caristenia, né? Gosto de treinar. Eu como moro em Cascavel, eu fico bem do ladinho de Foz. Foz é praticamente aí meu quintal de casa,  
**Luiz Jorge:** Cel  
**Evelyn La:** eu falo, né? As cataratas. Ali volte a gente dá um pulo lá. Tem uns uns hotéis bem bem bacana assim, principalmente para criança, né?  
**Luiz Jorge:** dá quanto tempo devel para lá?  
**Evelyn La:** Tem muita dá 1 hora30 no máximo.  
**Luiz Jorge:** Nossa,  
**Evelyn La:** Aham.  
**Luiz Jorge:** muito perto.  
**Evelyn La:** E aí eu tenho Paraguai e Argentina também aqui do lado, né?  
**Luiz Jorge:** É bem  
**Evelyn La:** Então é, dá para comprar os vinhos que eu gosto muito,  
**Luiz Jorge:** pertinho.  
   
 

### 00:06:48

   
**Evelyn La:** né? Sou de descendência italiana, então meu vô me ensinou a tomar vinho. Tinha a idade do meu filho praticamente quando ele me ensinou. E não fico sem chimarrão. Então tem umas ervas boa ali no Paraguai também.  
**Luiz Jorge:** Aí a minha mãe é gaúcha, minha família para parte de mãe é gaúcha. Eu nunca gostei de chimarrão, nunca consegui tomar.  
**Evelyn La:** Sério,  
**Luiz Jorge:** Hum.  
**Evelyn La:** tem gente que não não curte mesmo. Eu tenho uns familiar que são gaúchos e não Aí,  
**Luiz Jorge:** E a minha mãe não toma também, né? Minha mãe,  
**Evelyn La:** ó. Uhum.  
**Luiz Jorge:** ela não  
**Evelyn La:** É bem opcional mesmo, né? Não tem muito.  
**Luiz Jorge:** toma.  
**Evelyn La:** A cultura é forte sim, mas conheço uns gaúchos também que não são muito adepto ao Shima. Bom, um pouquinho da minha parte profissional para você conhecer, né? como que eu vim parar aqui. Eu sou formada na área da saúde,  
**Luiz Jorge:** M.  
**Evelyn La:** sou mestre em genética, trabalhei durante 10 anos em laboratório. Eh, tive aí uma trajetória bem bacana, né, em hospitais, inclusive também eu fazia análises da parte microbiológica de um hospital universitário aqui do do Paraná.  
   
 

### 00:07:45

   
**Evelyn La:** E depois que eu tive o Heitor, aí eu fui me aventurar no ramo do empreendedorismo. Aí eu abri uma loja, tive ali 4 anos de experiência com a loja, né, de sua parte de empresário, empresariado. Era uma loja de produtos naturais, ficava num prédio alugado e a mulher acabou vendendo o prédio e eu tive que encerrar minhas atividades. Mas foi uma boa experiência, foi onde eu entrei mais pro mercado das vendas em si e atualmente atuo como closer, né? Então a closer hoje ela faz o quê? O responsável por esse diagnóstico, por essa análise.  
**Luiz Jorge:** Угуm.  
**Evelyn La:** E eu fiz essa transição pro mundo das vendas porque é um mundo aonde a gente consegue fazer um capital muito bom hoje, sabe? a fala assim: "Vendas é coração de qualquer empresa, de qualquer negócio. Sem vendas não tem faturamento." E foi onde eu me encontrei de fato, juntei as duas coisas, né? Querendo ou não. Hoje eu atendo aí dentistas, a gente atende médicos, então eu tenho um pouco dessa trajetória na área ali e unir a útil agradável. Então, só no ano de 2025 eu fechei mais de 2 milhões de vendas em faturamento no um a um, que a gente diz, né, que é essa venda personalizada, tanto eventos presenciais quanto online.  
   
 

### 00:09:02

   
**Evelyn La:** E quando é presencial não deixo de levar meu chimarrão também.  
**Luiz Jorge:** Aí faz falta, né?  
**Evelyn La:** Falou. Então, essa é um pouquinho da Evelyn para conhecer aí, né, quem vai tá te auxiliando nesse diagnóstico agora. E pra gente começar, eh, vou deixar só, eu gosto de colocar três, três intenções bem claras aqui, né, Luiz? Então, assim, não tô para te vender e nem te empurrar nada. Óbvio que quando a gente faz uma venda é muito bom, sim. Mas antes de qualquer coisa, eu tô aqui para contribuir, tô aqui para te ajudar. Para isso, eu vou entender um pouquinho melhor seu cenário, vou conhecer um pouquinho mais de você, da sua atuação, de como que tá hoje o seu cenário, seus objetivos, para ver se faz sentido você estar com a gente, né? E claro, fazendo sentido,  
**Luiz Jorge:** Угуm.  
**Evelyn La:** aí eu te apresento um pouquinho mais o nosso trabalho para você analisar se faz sentido o nosso ecossistema também para aquilo que você almeja, né? Então é sempre eu falo, é uma via de mão dupla, né? é uma uma ambas as partes aqui precisam estarem em alinhamento de expectativas. Então, hoje aqui a gente vai começar eh eu querendo conhecendo um pouquinho mais hoje de como você atua, né?  
   
 

### 00:10:23

   
**Evelyn La:** Você falou que você atua em hospitais e como que tá sendo as cirurgias aí da face, tá? Com algum consultório eh paralelo? Fala um pouquinho aí sobre isso hoje.  
**Luiz Jorge:** Pois é, sou eu sou cirurgião Buco Maxilo. Eh, atuo muito na área de trauma, ortognática, cirurgia de ATM. Então eu trabalho cinco hospitais, então trabalho em três hospitais regionais, um em Belém e um no e dois no interior, um em Capanema, 160, 180 km e outro a 300 km daqui. Só que eu já não aguento mais pegar a estrada, fazer plantão, então trabalho de domingo a domingo. Então a minha intenção é diminuir isso,  
**Evelyn La:** Nossa\!  
**Luiz Jorge:** ficar mais no consultório, que eu tenho meu consultório particular, tenho duas salas lá que eu eu atendo quando eu tô no consultório, que eu tenho muito paciente, só que não voltado para essa área cirúrgica estética, tenho muita paciente de siso,  
**Evelyn La:** Mhm.  
**Luiz Jorge:** de de implante, enxerto, biópsia, mas eu queria focar mais no consultório nessa parte particular. Até o momento eu tenho, eu tô atendendo plano de saúde, que é o Unodonto e a Petrobras, só que eu tô diminuindo, então a minha intenção é tentar tirar os planos.  
   
 

### 00:11:44

   
**Luiz Jorge:** Então eu já fechei dia que eu no consultório eu atendo segunda de manhã que eu faço só consulta, quarta de manhã e de tarde eu deixei agora só para só para plano e quinta e  
**Evelyn La:** Tá,  
**Luiz Jorge:** sexta eu tô deixando só para particular. Aí fora,  
**Evelyn La:** não entendi.  
**Luiz Jorge:** sobre aviso, plantão e outros dias,  
**Evelyn La:** Uhum.  
**Luiz Jorge:** sábado, domingo. Então essa minha intenção é trabalhar menos, ganhar mais, ter uma qualidade melhor final de semana, chegar mais cedo para curtir meu filho,  
**Evelyn La:** Sim,  
**Luiz Jorge:** que esse momento de hoje da quadra lá, eu não tenho como falar não, porque eu já não passo muito tempo com eles, eu só chego tarde, tarde da noite em casa,  
**Evelyn La:** com certeza.  
**Luiz Jorge:** então aí eu não tenho como falar não.  
**Evelyn La:** Sim, super.  
**Luiz Jorge:** Então tive que fazer descer lá com ele. não, a gente tava na rua, fui pegar ele, daí tive que fazer isso porque eu não vou falar não, já que eu nunca tô presente. Então,  
**Evelyn La:** Sim,  
**Luiz Jorge:** a intenção é essa,  
**Evelyn La:** sim,  
**Luiz Jorge:** é curtir mais eles,  
**Evelyn La:** tem.  
**Luiz Jorge:** ganhar um bom dinheiro particular e trabalhar menos. Eh, ter meu minha minha ir pra academia no horário de herdeiro,  
**Evelyn La:** Uhum.  
   
 

### 00:12:46

   
**Luiz Jorge:** coisa que eu só vou se quando eu é 5 da 5 da manhã,  
**Evelyn La:** Sim.  
**Luiz Jorge:** então se à noite não pode fazer o que for, não dá para eu ir. Porque eu já chego quebrado à noite, então se eu não for 5 da manhã eu não já tô  
**Evelyn La:** Depois final tá esgotado,  
**Luiz Jorge:** quebrado.  
**Evelyn La:** né?  
**Luiz Jorge:** Então aí por enquanto, como eu tá fraca essa parte particular que eu eu tô enchendo mais a sexta-feira no consultório, eh principalmente a parte de implante, extração de dente incluso, aí na quinta-feira eu tô acompanhando uma dentista que faz muita cirurgia estética da face. Então lá que eu fico praticando, que ela não sabe fazer mais,  
**Evelyn La:** Certo.  
**Luiz Jorge:** faz mais ou menos, aí eu acabo sendo uma ajuda muito importante para ela. Então quem faz lá praticamente sou eu. Mas eu tô começando a cobrar baratinho de algumas pessoas para poder fazer, que as pessoas gostam de fazer negócio de antes e depois.  
**Evelyn La:** อือ  
**Luiz Jorge:** Então eu tento fazer o mínimo possível. Daí eu tô cobrando pouco. Já tem uns casos já mais ou menos fechado que eu já tô cobrando pouquinho, mas mais nada do que eu gostaria. Mas todo começo, digo, uma área assim, então para poder fazer o nome, fazer registro de antes e depois é assim.  
   
 

### 00:14:05

   
**Luiz Jorge:** Vamos.  
**Evelyn La:** E e hoje, Luís, você atende no consultório esses que você falou que abriu, né, para quinta e sexta? É um consultório seu, é alugado, como que  
**Luiz Jorge:** Não é meu, é meu. Outório é meu.  
**Evelyn La:** é?  
**Luiz Jorge:** Eu tenho duas salas, né? Tenho duas, são duas cadeiras odontológicas em duas salas.  
**Evelyn La:** Certo? Aham. E aí você  
**Luiz Jorge:** Mas como eu tenho muito fluxo de paciente,  
**Evelyn La:** tem  
**Luiz Jorge:** então às vezes eu saio de uma sala, já tem paciente na outra, vai lá, opera num, daí volta para outra sala, opera outro, vai, opera um, opera outro. Graças a Deus eu tenho muito paciente.  
**Evelyn La:** Uhum.  
**Luiz Jorge:** Cirurgia estática da face ainda não, mas já tô divulgando no Instagram, já fiz uns uns casos pequenos, mas aí o pessoal já tá se interessando, já tá procurando, perguntando e aí assim vai. Todo começo é difícil, mas assim nessa área, mas aí começando a fazer mais barato, tendo um antes e depois para poder o pessoal ver que eu tô fazendo, aí já começa a movimentar indicação boca a boca.  
**Evelyn La:** Uhum, entendi. Ah, e nesse consultório que você atende quinta a sexta, alguém agenda para você?  
   
 

### 00:15:21

   
**Evelyn La:** Tem alguém que te auxilia?  
**Luiz Jorge:** Tem, eu tenho dois funcionários lá,  
**Evelyn La:** Como que é?  
**Luiz Jorge:** tem uma secretária da recepção e eu tenho uma auxiliar dentro do consultório  
**Evelyn La:** Ah, ótimo.  
**Luiz Jorge:** comigo.  
**Evelyn La:** Muito bom. Entendi. Você falou que já começou a divulgar um pouco, né? Chegou pegar eh agência de tráfego alguma vez ou  
**Luiz Jorge:** Já. Pois é, que eu faço?  
**Evelyn La:** não?  
**Luiz Jorge:** Eu tenho um rapaz que faz as minhas mídias sociais, ele que faz as postagens, faz tudo. O que eu mais movimento são é o history. Então eu posto, né, quando eu quero uma coisa melhorzinha, eu mando para ele e aí quando eu vejo que tem uma postagem legal, aí eu pago e aí eu faço, tá, um mês, 15 dias para poder ter mais visualização, divulgação. Não sei se seria isso,  
**Evelyn La:** Uhum.  
**Luiz Jorge:** o tráfego pago. Eu, na minha visão que eu sou leigo, eu acredito que seja isso mais ou menos.  
**Evelyn La:** Eh,  
**Luiz Jorge:** Mas eu deveria fazer bem  
**Evelyn La:** na ver Sim, sim. Eh,  
**Luiz Jorge:** mais.  
**Evelyn La:** para te trazer assim volume, eh, uma demanda qualificada, é interessante umas estratégias mais profissionais, vamos dizer, porque é daí que vai aumentar a sua agenda, por exemplo, paraas cirurgias da face, que é o que o teu objetivo, né?  
   
 

### 00:16:29

   
**Evelyn La:** E aí você vai se conseguir se desligando das outras. Ah, mas fora isso, você nunca chegou a trabalhar, por exemplo, com uma agência em si,  
**Luiz Jorge:** Não, já cheguei a pesquisar.  
**Evelyn La:** fazer  
**Luiz Jorge:** Só que eu não levo a frente porque isso requer tempo, reuniões, é muito difícil para mim. Meu tempo é muito complicado.  
**Evelyn La:** certo,  
**Luiz Jorge:** Então assim, eu nunca levei paraa frente. Acho que eu peguei uma uma opinião,  
**Evelyn La:** certo.  
**Luiz Jorge:** um orçamento, alguma coisa. Acho que de uma só, mas nunca nunca fui paraa frente, de duas, na verdade, uma daqui de Belém e a outra fora, que nem assim com você,  
**Evelyn La:** Uhum.  
**Luiz Jorge:** mas nunca fui paraa frente.  
**Evelyn La:** Hum.  
**Luiz Jorge:** Eu já voltei pensando desse anciano que eu precisava fazer isso.  
**Evelyn La:** Uhum. Uhum.  
**Luiz Jorge:** treinamento de funcionária, tudo isso aí é importante.  
**Evelyn La:** É isso.  
**Luiz Jorge:** Gente,  
**Evelyn La:** É exato. Eh, hoje se você continuar do jeito que tá, tu já sabe aonde que que vai parar o que que você tem de faturamento, de toda essa questão que você trouxe,  
**Luiz Jorge:** Да.  
**Evelyn La:** né, referente a a você ter que tá se deslocando esse desgaste todo.  
   
 

### 00:17:32

   
**Evelyn La:** E aí eu queria entender o seguinte, o que que você acredita que impede talvez de você dar essa para desacelerar um pouco de um lugar e focar mais agora nas cirurgias? O que que você acredita que  
**Luiz Jorge:** Ah, per ten que ter fluxo. Eu tenho que ter fluxo para poder eu ganhar mais dinheiro no consultório e daí começa a largar.  
**Evelyn La:** impedir  
**Luiz Jorge:** Sobreviso, o plantão, ida para pro interior e assim vai.  
**Evelyn La:** fluxo em si? Então, certo. Uhum.  
**Luiz Jorge:** grupo cirúrgico de cirurgia da face que é o que dá, tá dando dinheiro, que é estética todo mundo paga, paga bem, paga a  
**Evelyn La:** Uhum,  
**Luiz Jorge:** vista.  
**Evelyn La:** entendi. Ah, e assim, de zer a 10 para resolver todas essas essas questões aí, né, e aumentar o seu fluxo, hoje seria quanto mais ou menos?  
**Luiz Jorge:** Ah, tem que ser 10 porque quero aumentar da noite pro dia para ontem,  
**Evelyn La:** Para ontem já.  
**Luiz Jorge:** porque eu preciso movimentar logo.  
**Evelyn La:** Tá certo. É isso aí. Mas vamos lá. Eh, Luiz, agora, né, que você me passou um pouquinho mais sobre como que tá seu cenário atual, como que você já atua, sabendo que você tem duas funcionárias, isso é ótimo, porque de fato eh hoje se eu conseguisse encaixar uma proposta aqui, a gente conseguisse resolver isso para você, né, treinar suas funcionárias, inclusive, porque esse é um papel que a gente assume, você abraçaria?  
   
 

### 00:18:59

   
**Luiz Jorge:** Sim,  
**Evelyn La:** Legal.  
**Luiz Jorge:** com certeza.  
**Evelyn La:** Então, antes de eu iniciar a apresentação aqui, eu quero só fazer um combinado contigo, que é o seguinte, eh, eu vou entrar na apresentação para te mostrar como que é o nosso trabalho, nossa metodologia, inclusive toda essa parte do treinamento que a gente abraça, né, e faz pros funcionários do cirurgião. Não precisa se preocupar com isso. Mas ao final da apresentação, eu gostaria de contar com o sim ou não, tá? E tá tudo certo. O sim ou não para quê, Evelyn? Sim, faz sentido. Vou seguir com vocês. Ótimo. Ou não, Evelyn, pro momento, para hoje vai ser não. Pode ser que daqui um mês, daqui dois meses, você venha e retorne e tá tudo certo. Posso contar com o seu sim, com o seu não.  
**Luiz Jorge:** Sim, com  
**Evelyn La:** Ah, maravilha. Vamos lá,  
**Luiz Jorge:** certeza.  
**Evelyn La:** então, Luís, eu vou te apresentar agora um pouquinho sobre a System. Primeira coisa, nós não somos uma agência de tráfego pago. Você vai entender um pouquinho melhor agora sobre como que a gente trabalha, eh, e todo o o por trás ali de que como que fazemos aumentar tanta conversão assim e tanto faturamento.  
   
 

### 00:20:08

   
**Evelyn La:** Opa, só um minutinho que ela é o sistema fácil sem que é o nosso Só Só um minutinho que ele fui compartilhar e ele travou. Tá dando para ver bem aí, Luiz?  
**Luiz Jorge:** Tá sim. Tá  
**Evelyn La:** Tá. Ah, maravilha.  
**Luiz Jorge:** sim.  
**Evelyn La:** Vou te apresentar um pouquinho sobre a empresa em si, né? A nossa assistem digital e o nosso método que é o Face 100K. 100K por quê? 100K de faturamento, R$ 100.000, né? O que é o mínimo que a gente espera aí fazer juntos eh ao longo desse, claro, alguns fazem isso em um mês, é muito possível com o ticket das cirurgias que a gente ajuda a inclusive organizar isso, mas óbvio, todo mundo tem o seu tempo, não é uma garantia de um mês que você consegue bater 100k, mas a gente tem alguns cases desse sentido, mas o o mínimo que a gente fala assim, o mínimo dentro do nosso acompanhamento aí é fazer 100k. mesmo, né, de faturamento, é possível atingir. Então, hoje, quem é a Sistem Digital que tá por trás desse método? Nós somos uma empresa especialista em gerar demanda qualificada e processos comerciais para clínicas de eh focadas em cirurgias da face, né?  
   
 

### 00:22:35

   
**Evelyn La:** a gente tá 6 anos já no mercado. Nós não somos uma agência de tráfego pago. A gente faz sim o marketing. A gente trabalha todo o posicionamento, toda a estratégia mais eh profissional ali por trás para lançar a campanha, né? Justamente porque através da estratégia que vai qualificar melhor essas pessoas. Sem isso, ah, você só atinge volume, mas pessoas muitas vezes desinteressada que não responde, que não tem nada a ver com o que você quer entregar. muitas vezes ali. Então a gente trabalha toda a construção de processos comerciais junto, que é o resultado que é o treinamento da equipe, que vai trazer aí 40, 60% de conversão.  
**Luiz Jorge:** Mas e aí, vocês também fariam esse trabalho junto com as minhas secretárias e com a e com o rapaz  
**Evelyn La:** Sim, passou esse também.  
**Luiz Jorge:** que faz as minhas mídias sociais também?  
**Evelyn La:** Uhum. Exatamente. Caso você queira fazer com a gente, nós temos um gestor de tráfego pago hoje que ele só cuida de dos nossos parceiros, né, de quem a gente tá atuando junto. Caso você queira continuar com quem você já tá, também é critério seu,  
**Luiz Jorge:** E assim,  
**Evelyn La:** tá?  
**Luiz Jorge:** às vezes a culpa até um pouquinho minha, porque o cara toda semana ele quer gravar conteúdo, quer gravar, quer gravar, quer não sei o quê e me perturba e eu não, não tenho tempo, não sei o quê, porque esse negócio de gravar não é comigo,  
   
 

### 00:23:53

   
**Evelyn La:** Угу.  
**Luiz Jorge:** daí não tenho tempo e e eu vou enrolando. Tipo, sexta-feira eu vou fazer uma uma gravação de casos que eu fiz no consultório. O paciente tá fazendo físio, então pedi para ela ir bem maquiada para poder fazer o antes e depois dela toda produzida aí fazer vídeo mostrando que foi feito. Então a gente vai fazer sexta-feira de  
**Evelyn La:** Legal.  
**Luiz Jorge:** manhã.  
**Evelyn La:** Legal. Uhum. É, precisa do conteúdo, porque a partir disso a gente constrói tanto seu posicionamento para você poder conversar com o público ideal e a partir disso gerar as campanhas com estratégias e chegar nessas pessoas, né? Então é importante fazer a a toda a parte ali de conteúdo, gravar, não necessariamente você aparecer tanto, caso você não goste, dá pra gente eh bolar outras estratégias onde não o que você tenha que sempre aparecer, né? pode filmar às vezes, por exemplo, o seu consultório em si. Ali tem várias coisas que a gente consegue eh  
**Luiz Jorge:** Mas é, mas é importante a gente aparecer. Toda vez que eu apareço ou falo,  
**Evelyn La:** atuar.  
**Luiz Jorge:** tem muito mais engajamento, muito mais curtida do que ficar aquele negócio muito mecânico, só figurinha, fotinha, não sei o quê, um negócio meio artificial,  
   
 

### 00:25:15

   
**Evelyn La:** É,  
**Luiz Jorge:** então fica muito,  
**Evelyn La:** aquilo ali não vende, tá? já te adianta,  
**Luiz Jorge:** não vende.  
**Evelyn La:** aquilo não vende.  
**Luiz Jorge:** Pois é. Yeah.  
**Evelyn La:** O que vende é você realmente se posicionar, mostrar o profissional por trás do resultado e resultado, né, o que vende. Agora o post bonitinho, feliz Natal, feliz dia dos pais, aquela coisa que mais o pessoal às vezes faz naquilo ali não vende. Aquilo ali realmente é só para pros que fazem esse esse trabalho mais aí de produção de criativo ganhar. Então hoje quem tá, quem é um dos sócios donos da Assistem é o Renan, um dos sócios que tá há 5 anos gerindo já time de alta performance, gerou 15 milhões de vendas através do digital. O outro é o Mateus, nosso gestor estratégico. Então, Mateus é nosso expert da parte estratégica, né, essa questão toda posicionamento, marketing, a parte ali realmente estratégica é o Mateus que cuida e a Dra. Débora, que foi uma das nossas primeiras parceiras e virou nossa embaixadora e sócia. A Dra. A Débora, ela fez eh com a gente, né, o o processo todo de estrutura, enfim, aumentou seu faturamento. E a partir disso hoje a gente tá inclusive em outro projeto com ela que a gente criou um novo produto, ela vai ser mentora de alguns de algumas imersões e aí a gente também tá junto com ela nessa.  
   
 

### 00:26:44

   
**Evelyn La:** Esse foi um dos faturamentos que a gente conseguiu gerar dentro da clínica em um mês de uma da de clínicas, né? alguns dos sonhos aí dos dos sócios realizados. E o que que hoje empata muito o resultado das clínicas, né? O cenário atual é justamente essa questão de muitas vezes depender só de indicação, ah, ficar muito preso aí ao operacional, trabalha demais, ganha ganha menos, né? pouca lucratividade e a maioria sempre vem também com essa questão de frustrações com outras agências e demanda de pessoas desqualificadas. Às vezes até chegou a investir em tráfego pago, já fez, já trabalhou com outras agências antes. Mas o que que acontece na sua na sua situação hoje? O lead ele tá cada vez mais caro você fazer essa captação no Instagram. Então, se você não trabalha um posicionamento prévios, se você não constrói uma estratégia específica, você dá tiro eh no escuro, né? só colocar dinheiro ali no Instagram e fazer rodar campanha, ele não vai resolver, ele não vai te trazer clientes qualificados dispostos a investir no que você está eh dispondo ali de solução. Então é muito importante o que trabalhar a estratégia, trabalhar o processo realmente estruturado, ah, um posicionamento importante para que você possa conversar com o público diretamente, eh, que você quer atingir.  
   
 

### 00:28:24

   
**Evelyn La:** Então, trazer essa previsibilidade, né, clientes qualificados consegue trabalhar com mais paz mental porque aumenta a demanda, cria um ticket médio aí bom, né, sai dessa dessa da correria em si. Então, a gente faz isso de forma bem personalizada. Se a gente tá há 6 anos já trabalhando com isso, é o que vai fazer realmente mudar o jogo, né? é trabalhar estrutura e marketing. Foi o que a Natália Beauty fez, inclusive é uma das maiores hoje dentro da beleza. Mas ela uniu o quê? o marketing, o se posicionar e falar exatamente com quem ela gostaria de atingir e criar estratégia comercial para vender, porque nada adianta você ter volume. E o que acontece muitas vezes com quem tenta fazer sozinho é perder saúde mental, perder tempo. Eh, acaba eh perdendo tempo em processos aonde não domina e aí às vezes vê um concorrente até que nem é tão bom assim no serviço passando na frente dele, né? Esses são os riscos de fazer sem o conhecimento. E aí eu sempre digo, a o quanto vale, o quanto valeria hoje, por exemplo, pro Luiz trabalhar de forma mais tranquila, com ticket melhor, né, mais próximo de casa, mais qualidade de tempo com o filho, porque a clínica anda sozinha, né? Não fica refé, inclusive nem de funcionários, porque nós treinamos o timos e passamos processos padrões.  
   
 

### 00:30:01

   
**Evelyn La:** Então, caso eu precise, por exemplo, Evely, mudar a minha secretária do dia paraa noite, tendo processo padrão, ela vai entrar e ela vai seguir e tá tudo certo. A pessoa não sai dali,  
**Luiz Jorge:** Uhum.  
**Evelyn La:** não leva às vezes o processo com ela, né? A gente evita isso porque prejudica  
**Luiz Jorge:** É, pois é, mas eu preciso muito fazer esse treinamento com a minha secretária,  
**Evelyn La:** muito.  
**Luiz Jorge:** principalmente a de porta lá que que atende, que recepciona, que liga, que confirma. Então assim, eu tenho que que se não mudar vai rodar,  
**Evelyn La:** Ótimo.  
**Luiz Jorge:** infelizmente.  
**Evelyn La:** Exatamente.  
**Luiz Jorge:** Daí e o que é bom é ter uma pessoa que consiga fazer isso e ver,  
**Evelyn La:** É isso.  
**Luiz Jorge:** minha filha, não dá do que eu bater de frente,  
**Evelyn La:** Isso.  
**Luiz Jorge:** entendeu?  
**Evelyn La:** Exatamente. Esse é é o que é justamente o que a gente faz, ajuda eh o empresário nesse sentido, eh resolver o quanto quanto mais e a gente consegue entrar na operação junto e resolver essas questões mais de do operacional em si mesmo, que é a grande a maior parte do trabalho em si para ter umas boas vendas, vai ser feito por quem? pela secretária. Então, é claro, a estratégia de marketing, gerar demanda qualificada, tudo isso é importante, mas se a pessoa chegou qualificada e a secretária não sabe o que fazer, ou se ela não tem processo, ou ela faz de uma maneira que assim o lead não engaja, perdeu, perdeu às vezes um potencial paciente ali que poderia converter, poderia gerar uma venda pelo falta de processo de como executar a abordagem correta, de o que falar em cada passo, em cada etapa do atendimento, né?  
   
 

### 00:31:40

   
**Evelyn La:** Então, a gente treina principalmente essa questão. E aí, o que que é interessante, né? O que que eu falo assim, quanto valeria tudo isso? Por que que traz tanta tranquilidade e paz mental? Porque a gente vai criando processos e estratégias que vão aumentando o seu LTV, que é o tempo que esse mesmo paciente pode vir a investir por mais vezes contigo. Então, mesmo que vem para uma cirurgia buco maxila, depois ele faz um procedimento facial, faz uma, não sei se você tá, já tá trabalhando com algum com preenchimentos também, algo nesse sentido,  
**Luiz Jorge:** Faço preenchimento só de gordura, não faço nada de botox,  
**Evelyn La:** mas  
**Luiz Jorge:** negócio de ácido hialurônico, essas coisas. O minha, meu negócio é mais, não é de injetáveis, é de de cirúrgico.  
**Evelyn La:** gordura.  
**Luiz Jorge:** Então,  
**Evelyn La:** Aham.  
**Luiz Jorge:** hipo, cérvico, facial, aí pega essa gordura, trata, injeta lábio, pento, nariz, olheira,  
**Evelyn La:** Ótimo.  
**Luiz Jorge:** bigode chinê, facelift que puxa tudo, frontoplastia, bléfaro, todas essas cirurgias. mais para frente um pouquinho rino,  
**Evelyn La:** Nossa.  
**Luiz Jorge:** que eu ainda não comecei a fazer rino, mas todo esse tipo de cirurgias aí de estética da  
   
 

### 00:32:48

   
**Evelyn La:** Uhum. Não. Ótimo. Ótimo.  
**Luiz Jorge:** face.  
**Evelyn La:** Tem uma esteira muito boa, Luiz. E quanto valeria, né, você ter tudo isso na clínica, sabendo que vai ter um processo redondinho, que vai vender os procedimentos e aí você fica com mais tranquilidade.  
**Luiz Jorge:** E assim, já investi uma grana já dessa cirurgi,  
**Evelyn La:** Eu  
**Luiz Jorge:** tanto equipamento, material,  
**Evelyn La:** acredito.  
**Luiz Jorge:** tudo, curso. Em três meses já gastei 90.000 em curso. Então assim, tem que negócio tem que retornar, entendeu?  
**Evelyn La:** Sim, tem que dar RO,  
**Luiz Jorge:** Então,  
**Evelyn La:** né?  
**Luiz Jorge:** deixei com equipamento e tudo, já gastei muito dinheiro e assim, o negócio tem que voltar rápido, tem que vingar rápido, na verdade,  
**Evelyn La:** Sim, exatamente.  
**Luiz Jorge:** porque eu vejo lá que essa pessoa que eu acompanho aqui que o fluxo dela é tipo absurdo,  
**Evelyn La:** Acelerar.  
**Luiz Jorge:** porque ela já tá naquela fase de boca a boca, então um indica pro outro, indica pro outro, daí aí já tá do jeito que hoje em dia eu tô,  
**Evelyn La:** Mhm.  
**Luiz Jorge:** mas na parte de plano, entendeu? que eu vai indicando.  
**Evelyn La:** Aha.  
**Luiz Jorge:** Eu tenho muito fluxo, atendo 20, 30 pacientes numa segunda de avaliação, mas é para plana.  
   
 

### 00:33:56

   
**Luiz Jorge:** 90% é plano. E daí?  
**Evelyn La:** Sim, sim. Deixar, né, isso e e focar mais no que realmente vai te fazer caixa, né, vai te trazer aí lucratividade até mesmo para gerar ROI com todo o investimento que você comentou, né? tem que fazer acontecer e vai fazer acontecer como sabendo como vender. Porque nada adianta você ser o melhor especialista e você não ter a clareza de como funciona o processo da venda por trás, porque não é uma venda de padaria, eu falo, né? É um produto que tem o seu valor agregado. Então, tem que saber conversar com o público, certo? Tu tem que saber montar a estratégia para você não perder tempo nessa fase e quando entrar a secretária saber exatamente o que fazer também para não perder a pessoa no meio do caminho. Então esse é o novo mercado de clínicas dos qual do qual a gente tá ajudando vários outros cirurgiões aí já ajudamos alguns e estamos com outros em processo inclusive. E aqui é o nosso sistema, como que a gente trabalha. Então, eh, todas as etapas dos pilares aqui a gente faz de acordo com aquilo que você mais precisa. Então, nós temos todas essas etapas, a gente trabalha de uma forma integrada e a gente personaliza conforme você mais precisa. Então, nós vamos trabalhar funil de marketing, tráfego pago, a gestão do processo, que é onde entra a secretária, né?  
   
 

### 00:35:36

   
**Evelyn La:** tudo o que ela precisa fazer. a gente dá esse suporte e treina inclusive ela. Protocolos para gerar caixa rápido, que é trabalhar uma base da qual você já vai construindo também melhorar os produtos e ofertas suas, ou seja, como a gente consegue agregar valor, quem sabe eh dependendo do procedimento que você já tem para você lucrar ainda mais sobre ele. a gente constrói essa esteira junto contigo, trabalha os funis de venda personalizado que melhor se encaixa pro seu momento e o funil de pré-vendas, que é onde entra a questão de treino e tudo mais pra secretária para ela entender que ela precisa de ela precisa uma mentalidade também, né, para isso. Então, a gente trabalha a questão de mentalidade e trabalha a questão dela eh ter clareza que ela precisa vender o agendamento, né? Eu vou explicar um pouquinho melhor sobre isso. Não é só ser simpática e agendar, não. É por isso que muitas vezes dá taxa de no show, não comparecimento, né? Aquela elas t muito essa visão assim eh eh limitada, né? Do que que é o atendimento. E aqui é onde a gente entra com uma visão bem mais profunda, que é daqui que vem a o faturamento em si, né? começa lá com a abordagem, a captação qualificada, a abordagem para depois sim de fato a gente efetuar a venda.  
   
 

### 00:37:04

   
**Evelyn La:** Então esse é o nosso sistema que a gente constrói junto eh com esse cirurgião, com o empresário. Ali a gente tem todos esses processos prontos, tá? como fazer, mas eh personalizado para o momento do cirurgião. Então, por exemplo, tráfego pago, fone de marketing, ele vai ser personalizado. Os processos comerciais, eles são padrão. Protocolo de caixa rápido, a gente tem protocolos padrões já que é só aplicar para gerar caixa rápido. São estratégias validadas específica. Construção de oferta, ela é personalizada, funil de vendas também. E a parte de treinamento de pré-vendas a gente faz de acordo com o nosso com os nossos protocolos que a gente já tem também, mas aí somos nós que fazemos esse trabalho, né? Esse daqui é o nosso sistema face 100K, Luiz. E aí eu ia te perguntar daqui, tem alguma dúvida, alguma coisa que você gostar?  
**Luiz Jorge:** Tem algum face 500K aí?  
**Evelyn La:** O o temos o mínimo é 100\. O mínimo é 100\. assim, numa realidade ali que eu vou falar 100 no mês para quem tá começando, mas para quem já tem uma boa trajetória, a gente consegue elevar ainda mais. A gente tem cirurgião aí fazendo 260, 300 por semana, dependendo como que tá o fluxo lá,  
   
 

### 00:38:30

   
**Luiz Jorge:** Uhum.  
**Evelyn La:** sabe? Então é bem possível assim, agregando obviamente aqui, ó, valor às ofertas.  
**Luiz Jorge:** Sim,  
**Evelyn La:** O segredo muitas vezes tá em na como você oferta as  
**Luiz Jorge:** sim. Não,  
**Evelyn La:** suas.  
**Luiz Jorge:** eu consigo vender bem valor bem bem assim as as coisas que eu faço,  
**Evelyn La:** Ótimo.  
**Luiz Jorge:** eu vendo bem. Lógico, agora essas cirurgias de fácil,  
**Evelyn La:** Maravilha.  
**Luiz Jorge:** eu tenho cobrado praticamente o material e agora já tô começando a cobrar um pouquinho mais. Não é o que eu quero,  
**Evelyn La:** Mas tá.  
**Luiz Jorge:** mas já tô começando,  
**Evelyn La:** Uhum.  
**Luiz Jorge:** daí uma já vai indicar paraa outra que daí eu vou chegar no patamar. Não, agora é isso e pronto.  
**Evelyn La:** Exato.  
**Luiz Jorge:** Mas eu tenho que ter fluxo para isso. Eu preciso mostrar antes e depois que o pessoal quer ver  
**Evelyn La:** Tem é resultado. É isso aí.  
**Luiz Jorge:** isso.  
**Evelyn La:** Uhum. Eh, se fosse para você escolher aqui da mandala, o que que você escolheria? Assim, umas três, quatro coisas para você startar.  
**Luiz Jorge:** É um tráfego pago, tudo que dê dinheiro aí, tudo que seja rápido.  
**Evelyn La:** o que seja rápido, protocolo de caixa rápido,  
   
 

### 00:39:38

   
**Luiz Jorge:** Ah,  
**Evelyn La:** gestão do processo ali primordial para quem entra do tráfego pago, né? No seu caso,  
**Luiz Jorge:** é tráfego par.  
**Evelyn La:** seria bem esse caminho mesmo, Luiz, a gente trabalhar um posicionamento no Instagram primeiro,  
**Luiz Jorge:** Você chegou a ver meu  
**Evelyn La:** desenhar o Vi, vi.  
**Luiz Jorge:** Instagram?  
**Evelyn La:** Uhum. Eu olhei ali, tem bastante do seu trabalho nos hospitais, né? É.  
**Luiz Jorge:** Uhum.  
**Evelyn La:** Aí seria interessante a gente começar a trazer mais esse resultado. Eu vi que você tem um um tem um outro resultado ali de lifting, né?  
**Luiz Jorge:** É, mas muito pouco  
**Evelyn La:** Aham.  
**Luiz Jorge:** ainda,  
**Evelyn La:** Mas mesmo tendo pouco, dá para se trabalhar muito,  
**Luiz Jorge:** tipo, ele tá fazendo,  
**Evelyn La:** tá?  
**Luiz Jorge:** eu eu posso até conseguir porque eu tô fazendo os cursos ainda. Então, nos cursos que eu tô fazendo, eu posso conseguir essas imagens, que isso que eu tô captando para poder eu ficar postando as imagens do curso lá  
**Evelyn La:** Ótimo.  
**Luiz Jorge:** também.  
**Evelyn La:** Uhum. Não, maravilha. Porque aí seria bem esse caminho contigo, sabe? Trabalhar o quê? funil de marketing comercial primeiro que vai ser o posicionamento, trazer mais cases de sucesso pra gente linkar uma campanha estratégica aqui com o perfil do cliente que você quer atingir.  
   
 

### 00:40:50

   
**Evelyn La:** Rodar o tráfego pago. Quando a gente soltar o tráfego pago, vai entrar o quê? A gestão do processo comercial, que é a secretária, entendendo o que que ela tem que fazer com esse leite qualificado e já o protocolo de caixa rápido pros primeiros meses, né? E aí, conforme a gente vai gerando o fluxo daqui, você vai construindo novas ofertas de valor mais agregado,  
**Luiz Jorge:** Угуm.  
**Evelyn La:** mas primeiro tem que sair o fluxo para aí você eh trabalhar as ofertas em si, né? Mas seria esse caminho mesmo aqui. Então, como que a gente faz isso, né? A gente faz de maneira eh bem assim detalhada. Pode parecer muita coisa, mas não se preocupe que isso daqui a gente, esse trabalho todo aqui é a secretária em si, né, que se responsabiliza e a gente treina ela e fica no pé dela para isso. Então são os funis de aquisição, né, a gente precisa ter junto aí com você, eh, trabalhar isso dentro da clínica. Esses funis de aquisição é o quê? as portas que se abrem para entrar leads, entrar pacientes. Então, a gente tem que ter uma porta aberta lá no tráfego pago, eh, trabalhando indicação, que isso daqui é uma uma técnica que a gente ensina a secretária a fazer, eh, parcerias, network e social cell.  
   
 

### 00:42:11

   
**Evelyn La:** Social Cell vai trabalhar no seu Instagram. Social Cell é uma técnica que a gente ensina também, treina, né? você falou que tem duas pessoas lá, a gente consegue até viabilizar isso, fica mais fácil, que ele vai gerar interação social no seu Instagram. Então, por exemplo, você vai começar a rodar campanhas, vai começar a ter, né, mais posts ali, pessoa vai começar a visitar mais seu Instagram, vai às vezes lá no directo, vai comentar em alguma foto, né, ah, valores, ah, gostaria de saber mais sobre isso. Você não tem tempo para ficar cuidando seu Instagram desse jeito e respondendo. Aí, quem que faz isso? Uma social ser. e ela faz esse pré-social intencional, ou seja, existem mensagens de abordagem e tudo mais específicas nesse pré-social para levar ela para um agendamento e vender, tá? Então esse é o nosso sistema funil de pré-vendas. A gente trabalha o agendamento ali, a mentalidade da secretária, ajuda ela a entender que ela já precisa contornar certas objeções e tudo isso vai levar o quê? a um fechamento de venda mais eh rápido, né? Então, seguir cadências de followup é importante. Porque que que é o follow? Não adianta a pessoa ver e o agendou.  
   
 

### 00:43:32

   
**Evelyn La:** Ela precisa fazer as confirmações certas, nos horários certos. Para quê? para reduzir essa taxa de no show, reduzir às vezes a pessoa acabar se perdendo pelo caminho. Então você tem que manter sempre contato ali com o lead, tem que estar sempre conversando com o paciente e a gente mostra como  
**Luiz Jorge:** Pois é, é isso que eu tô precisando,  
**Evelyn La:** fazer.  
**Luiz Jorge:** porque parece que às vezes o paciente se perde, desmarca ainda remarca.  
**Evelyn La:** Isso se perde mesmo. Aham. Se não tiver um processo aqui nesse entre o agendar e o comparecer, ele se perde. E aí aqui você perde dinheiro. É nesse gap, sabe? Então o que que a gente, aonde a gente entra aqui? Treinar a secretária para ela entender e saber cada etapa o que fazer para que ele de fato venha. Então isso a gente cria um funil de dentro de um CRM, né? que o CRM ele vai ser uma plataforma específica para cuidar essas entradas líde, as etapas e tudo mais. Então a gente tem o treinamento do CRM também para secretária. E a gente tem dois modelos comerciais. Um modelo comercial, que é esse aqui que você tá vendo, é para atuar com os leads novos, ou seja, aqueles que vão vir ou por indicação ou pelo tráfego pago.  
   
 

### 00:44:55

   
**Evelyn La:** toda essa estrutura que você tá vendo, é, pode parecer muita coisa, mas é uma estrutura detalhada, aonde a gente consegue de 40 a 60% de conversão dessas pessoas que vêm através de tráfego pago ou indicação. E essas etapas elas são de extrema importância. são as etapas que a secretária faz, vai, né, eh, precisar fazer ali o passo a passo para que a gente, de fato, tenha eh sucesso aí nas vendas. E o modelo comercial dois é a estrutura utilizada para trabalhar com aquele ex-cliente, ou seja, que veio, fez um procedimento e a gente vai fazer novamente uma interação para tentar vender algo a mais para ele depois. E aquele cliente que ele agendou e não compareceu? ou foi alguém que assim eh se perdeu no meio do caminho ou é uma base que você já tenha contatos às vezes de pessoas que vieram de outras eh para outros motivos e agora você vai ter um novo produto. Então, a gente tem esses dois tipos de modelo de comercial, de estruturação comercial, que é onde as secretárias entram para trabalhar, tá? Então, o primeiro vai se fazer para trabalhar estratégias pros novos e o segundo para trabalhar a sua base, que é onde tem muito dinheiro parado. A gente fala às vezes dinheiro que você pode estar rodando, criando novas campanhas, isso tudo a gente cria para você junto.  
   
 

### 00:46:29

   
**Evelyn La:** Eh, e você precisa, faz protocolo de caixa rápido, que a gente diz, e não precisa ficar investindo toda a hora em tráfego pago também. Então, trabalhando esses dois modelos comerciais aí estruturados, bem alinhado, com posicionamento, estratégia de marketing, a gente vai ter um setor de alta performance, né? Uma esteira de produtos bem organizada, uma precificação legal. Então, tudo isso vai gerar realmente o setor de alta performance. A gente cria isso eh com você de forma personalizada ali, mas nós temos os scripts e processos de vendas pronto paraas secretárias. Eu falo assim, é um copia e cola, né? É um copia e cola. O que que é o script, né? É todo a parte realmente de como que elas tem que falar, eh, responder o cliente, quanto tempo de cada resposta. Então, tudo isso a gente tem as informações que elas precisam para fazer um trabalho bem feito, um agendamento personalizado, a gente tem. Então aqui entra toda a construção de ofertas também, né? Dentro da mandala a gente tem dentro dos nossos pilares ali. Então nós temos assim aqui é são preços hipotéticos, tá? A gente coloca só para você entender que o quê? Eh, o produto mais barato da sua esteira, ele vai servir como um produto isca, inclusive para as campanhas, que vai ser para elevar o nível de consciência das pessoas.  
   
 

### 00:47:57

   
**Evelyn La:** Eh, e aí a gente vai trabalhar também campanhas específicas para cada produto. Então, ah, eh, campanha para parte de blefero, campanha para a parte de lifting, mas a gente sempre vai ter um isca. Que que é o isca? aquela pessoa que não conhece o Luís, que agora vai conhecer e através desse anúncio aqui vai vir para conhecer e vai ver o quanto que o Luiz pode ajudar ela e o quanto que ele tem de solução para pro momento atual. Então a gente cria uma esteira de produto junto com você, novas ofertas, ofertas atraentes, né, que a gente diz, e gera também protocolos de caixa rápido, que é o que eu falei, onde tem muito dinheiro parado e a gente consegue movimentar. Então, nós temos oito tipos de protocolos para aceleração de caixa. Então, são cada protocolo é uma estratégia diferente que a gente ajuda a aplicar e a criar caixa sem necessariamente você investir em tráfego pago. Esses protocolos aqui também quem executa são ex secretárias, tá? gestão do processo, não ter métricas aí para você entender. A gente deixa isso também muito claro para você, toda a gestão do processo, você saber o que que vai ser feito, como que vai ser feito. E o tráfego pago, que aí é a geração de anúncios e toda a construção do seu posicionamento, definição de público e estratégia para gerar o tráfego pago.  
   
 

### 00:49:27

   
**Evelyn La:** Então, até aqui, Luiz, eh, eu te apresentei sobre a nossa metodologia, né? é o que engloba esses pilares. Esse é o nosso método que faz clínicas aí faturarem 100k no mínimo mês, né? E aí eu queria te perguntar, eh, fez sentido para você? Gostou?  
**Luiz Jorge:** Não, com certeza.  
**Evelyn La:** Que que você achou?  
**Luiz Jorge:** Interessante. Na teoria é lindo. Vai na prática. Aí já é perfeito.  
**Evelyn La:** Vamos ver.  
**Luiz Jorge:** Legal. muito interessante,  
**Evelyn La:** Legal. Que que você mais gostou?  
**Luiz Jorge:** não de todo o processo de treinamento de funcionário, de protocolos, que eu acho que é importante. Uma coisa que hoje em dia, como eu trabalho para cacete, eu não tenho tempo para sentar, para ficar pensando no que eu tenho que fazer.  
**Evelyn La:** Se exato.  
**Luiz Jorge:** Então, quando eu tenho tempo, aí sim. Tanto que agora eu tô dividindo o consultório para particular. Quando é no dia de particular, eu já deixo o capal de café expresso pra secretária servir, já peço um bolo, um salgado para deixar de Então assim, a gente vai aos poucos pensando, mas eu não tenho tempo para est toda hora pensando nas melhorias,  
   
 

### 00:50:33

   
**Evelyn La:** pensando legal.  
**Luiz Jorge:** nas coisas para fazer, porque não tenho tempo para isso.  
**Evelyn La:** Eh, bem, é exatamente, é isso.  
**Luiz Jorge:** Tem coisas que eu precisava treinar na secretária.  
**Evelyn La:** Ah.  
**Luiz Jorge:** Não tenho tempo para isso, mas eu precisaria, por exemplo, um pós-operatório que eu tava vendo ali, p\*\*\*\*, liga daqui a 2 horas pr pra paciente. E aí, você chegou bem? Tá tudo bem? Como é que foi? Você tá com dor? Não tá com dor?  
**Evelyn La:** Isso.  
**Luiz Jorge:** Aí no outro dia, poxa, e aí, você tá bem? Você pode bater uma foto pra gente ver como é que você tá? Tal, se tá inchado,  
**Evelyn La:** Aham.  
**Luiz Jorge:** não tá? Então, essas coisas é importante. O paciente se sente, sabe, eh, bajulado, querido. Então isso é importante, esse feedback para tá tá babando a paciente,  
**Evelyn La:** Exatamente.  
**Luiz Jorge:** fala: "Olha, poxa, ele tá se importando comigo". Então, ela tinha que tá ligando. Olha,  
**Evelyn La:** Exato.  
**Luiz Jorge:** liga daqui a uma hora, liga para saber como é que tá, se chegou bem. Daqui a manhã liga para saber se tá inchado, tá com doce,  
   
 

### 00:51:25

   
**Evelyn La:** Uhum.  
**Luiz Jorge:** tá tudo bem. No outro dia também, assim, sei lá, dois dias depois. Então, fazer um protocolo sobre isso eu acho que é  
**Evelyn La:** Sim. Exato. É, é de suma importância mesmo esse acolhimento, né? que é a partir daí que você muitas vezes vai o quê? Fidelizar esse paciente, ganhar indicação e é assim que começa a a girar, né? E assim, Luís, vendo tudo que a gente entrega, o que a gente faz, você acredita que isso aqui te ajudaria a bater esse faturamento almejado para ficar mais  
**Luiz Jorge:** Não, com certeza.  
**Evelyn La:** tranquilo, passar  
**Luiz Jorge:** Espero que sim. A intenção é essa, né? Então, pelo que você tá me mostrando aí,  
**Evelyn La:** mais.  
**Luiz Jorge:** acredito que sim, que a intenção é essa. Então, pelo acho que vocês devem ter pelo jeito de experiência e tem organização, eu acho que tem tudo para dar certo.  
**Evelyn La:** Muito bem. Então, eu vou te mostrar agora como que funciona a nossa parceria de aceleração. Como eu te falei, nós somos uma aceleradora de clínicas e vou te mostrar exatamente como é que a gente implementa essas estratégias dentro da clínica e treina a sua a sua seus funcionários. Primeira coisa, o programa consiste em um ciclo de 6 meses.  
   
 

### 00:52:42

   
**Evelyn La:** Então são se meses de acompanhamento com foque em realmente aceleração, eh ferramentas e processos já prontos só para aplicar, né? Aí, claro, um aprendizado e treinamento com o time, o time que eu digo, o time do cirurgião, no caso. Então, a gente tem um plano start, aí a gente faz um plano start para longo de toda a jornada dos seis meses e o plano de ação individual. Então, nós fazemos reuniões aí, checkpoints a cada 15 dias, reuniões individuais com o empresário, né, no caso contigo, para realmente a gente trazer o quê? as estratégias que a gente vai começar a aplicar, que a gente vai começar a movimentar. Protocolo de aceleração de caixa rápida é a primeira coisa que a gente já libera para ser aplicado, porque é onde você já consegue fazer faturamento de fato aí sem precisar investir em tráfego pago. Grupo de WhatsApp, então a gente monta um grupo, cria um grupo específico VIP, aonde vai est só você e nós da equipe que vamos cuidar de toda a implementação. e criamos um outro grupo para colocar o seu time comercial, no caso ali suas duas secretárias e o nosso time que vai treinar elas. Então a gente tem o grupo separado porque a conversa é diferente, né? E elas ali, o grupo é para tirar dúvida, para passar feedback, para quando elas precisar de ajuda em alguma coisa específica, elas podem chamar ali a qualquer momento.  
   
 

### 00:54:11

   
**Evelyn La:** As meninas estão sempre respondendo. Durante a semana, toda todos os dias, de segunda a sexta-feira, a gente faz tutoria. Essas tutorias é para quê? Treinar, tirar dúvidas e alinhar o que tá sendo feito dentro da clínica. Então é para as funcionárias, todos os dias às 11 da manhã a gente tem uma um tema, né, pré-venda, venda, social selling. E aí a gente vai treinar, treinar elas, elas precisam assistir alguns conteúdos, a gente vai puxar eh com elas isso para saber se elas de fato estão fazendo, estão assistindo e a gente abre para pergunta, para tirar dúvidas, para elas trazerem também caso elas estão tenham estão tendo alguma dificuldade. Então essas tutorias elas servem para isso e claro dentro do grupo a gente também fica à disposição para tirar dúvidas a qualquer momento. E caso seja necessário, por exemplo, marcar uma tutoria individual com alguma delas para trabalhar algo em específico, a gente faz isso também, tá? Então, a gente disponibiliza a trilha de conteúdo para elas assistirem, entender primeiro na teoria o que que precisa fazer. E a gente nas tutorias aqui todos os dias a gente vai o quê? Tanto ver se ela realmente tá fazendo e se ela vai ter alguma dificuldade, aonde a gente consegue ajudar, tá? Tudo isso dentro de documentos, né?  
   
 

### 00:55:41

   
**Evelyn La:** a gente tem todos os processos comerciais aí eh a seu dispor. Treinamento, então paraa parte de vendas, no caso, eh se você resolver que você vai ser o vendedor, a gente vai te ajudar nesse sentido. Se você for delegar essa função para alguém, a gente vai treinar essa pessoa para ela aprender a vender. Por quê? Porque primeiro ela vai ter que lidar com o contorno de objeções, ela vai ter que saber eh analisar muitas vezes o perfil comportamental para como conversar com aquela pessoa. Então, a gente vai treinar esse essa parte de vendas, vai treinar o SDR, que a gente diz, é o pré-vendedor, né, que é a secretária. Então, a gente vai treinar ela também nesse sentido de ela entender o que que ela precisa fazer depois que o Lead entrou em contato com ela e mandou um oi. qual a abordagem, como vender um agendamento, como trabalhar essa mentalidade nela para ela vender o agendamento, porque é diferente de agendar, né? Se ela já está vendendo, querendo ou não, o Luís ali. Então ela precisa gerar essa emoção, precisa gerar esse interesse quando precisa manter ele aquecido e ela entender todas as cadências e toda aquela estruturação lá de followup, que é de suma importância. esse pós cirúrgico que você comentou, uma coisa que a gente ajuda a estruturar também, porque isso aumenta depois os seios farm que a gente fala que é o quê?  
   
 

### 00:57:04

   
**Evelyn La:** Essa revenda, né? Então a gente treina essa secretária para isso e treina o social selling, que é a pessoa que cuida da interação social do seu Instagram ali depois. O social cell não é uma coisa assim tão de urgência. Ele começa a ser mais interessante quando você começa a rodar mais campanha, quando você começa a alimentar mais e se posicionar no Instagram de acordo com o público que você quer atingir. Aí é interessante você começar a pensar sobre social selling, tá? Mas não é algo urgente. O mais urgente aqui é pré-vendas, secretária e vendas. Esse é o urgente. Isso a gente disponibiliza dentro de um CRM, então, para fazer eh toda essa gestão de os leades que vão chegar, como que eu vou eh colocar as mensagens ali, como eu vou gerir isso, a gente disponibiliza um CRM, treina as pessoas para usar esse CRM, ele vai te dar métricas, ele vai te dar dados. A gente tem um gestor de tráfego, que foi o que eu te falei, nós temos o gestor nosso, mas caso você queira continuar com o seu, não tem problema. Outro bônus é o Flashbd, que é um o painel comercial aí pra gente trabalhar todas as métras e a os modelos de apresentação, playbook, gravação, script, tudo isso documentado também fica à sua disposição aí por tempo ilimitado.  
   
 

### 00:58:29

   
**Evelyn La:** Até aqui, alguma dúvida referente a como a gente trabalha a metodologia aplicada, Luiz,  
**Luiz Jorge:** Até agora não tá tudo tudo bem, muito bem explicado.  
**Evelyn La:** tudo certo? Gostou da do nosso acompanhamento,  
**Luiz Jorge:** Hum, com  
**Evelyn La:** a forma como a gente faz?  
**Luiz Jorge:** certeza.  
**Evelyn La:** Uhum. A as tutorias ali, que que você  
**Luiz Jorge:** Não é interessante. Eu acho que tem que ter,  
**Evelyn La:** achou?  
**Luiz Jorge:** porque eu não tenho tempo para pensar. Outra coisa, eu tenho, a gente tem o WhatsApp do consultório, aí eu não tenho tempo de sentar para montar aquelas frases bonitinhas lá que coloca: "Oi, tudo bem?" e tal,  
**Evelyn La:** É tudo isso a gente tem.  
**Luiz Jorge:** aquele negócio de ou tipo, sei lá,  
**Evelyn La:** Uhum.  
**Luiz Jorge:** montar com um negócio de para dar uma resposta assim mais ou menos, negócio de agendamento. Então, não sei, eu tenho, eu tenho que ter tempo para fazer essas coisas, entendeu? Coisa que eu não  
**Evelyn La:** Uhum. Exato. É, e tudo isso é o que a gente resolve para você, né? Trazendo o quê?  
**Luiz Jorge:** tenho.  
**Evelyn La:** Os scripts prontos ali, treinando a secretária da maneira como que ela tem que aplicar.  
   
 

### 00:59:23

   
**Evelyn La:** E só, inclusive dentro do CRM a gente tem automações que mandam mensagens automáticas. a gente integra aí o WhatsApp e manda as mensagens automáticas dessas confirmações. Então,  
**Luiz Jorge:** É, eu tenho um programa de gestão também que eu eu acho que o programa ele manda faz essas,  
**Evelyn La:** professor.  
**Luiz Jorge:** mas vamos ver, eu acho que ele manda essas mensagens automáticas, só que eu tenho que contratar essa parte de mensagem para mandar pro paciente de confirmação,  
**Evelyn La:** Uhum.  
**Luiz Jorge:** porque ela te ela faz ela faz o contato com os pacientes de confirmação,  
**Evelyn La:** Aham.  
**Luiz Jorge:** mas eu tenho um programa que pode mandar mensagem, pode mandar e-mail, pode mandar, sei lá, WhatsApp,  
**Evelyn La:** Uhum.  
**Luiz Jorge:** próprio programa que eu tenho de gerenciamento do consultório de agendamento, de tudo,  
**Evelyn La:** Certo, entendi.  
**Luiz Jorge:** que é o easal,  
**Evelyn La:** A gente pode junto avaliar como que tá esse seu programa  
**Luiz Jorge:** fica tudo na nuvem, tipo tudo na nuvem.  
**Evelyn La:** hoje.  
**Luiz Jorge:** Eu abro a minha agenda do celular, abro a minha agenda daqui do computador, então tudo em nuvem,  
**Evelyn La:** Ah,  
**Luiz Jorge:** entendeu?  
**Evelyn La:** legal,  
**Luiz Jorge:** Gerencio, pagamento, tudo eu faço por lá.  
**Evelyn La:** entendi. Uhum.  
**Luiz Jorge:** Orçamento,  
**Evelyn La:** E aí tem a parte que elas podem ter o acesso para fazer essas essas confirmações  
   
 

### 01:00:26

   
**Luiz Jorge:** né? Sim.  
**Evelyn La:** aí,  
**Luiz Jorge:** É.  
**Evelyn La:** tá? Não, bacana. Legal. Dá para ver como que funciona ele e ela só ajustar as mensagens ali e a gente conseguir auxiliar nesse processo, né, de automação ali, quem sabe tudo mais.  
**Luiz Jorge:** Ó, aqui eu, ó, vou te dar um exemplo aqui,  
**Evelyn La:** Mas  
**Luiz Jorge:** eu tenho, então, e tá ruim da luz, ó. Mas eu tenho toda aqui, daí eu vou vendo por dia,  
**Evelyn La:** entendi  
**Luiz Jorge:** aí, tipo, na segunda-feira, olha aí como eu tenho fluxo, só que 90% é, ó. Tá vendo? Tem de só segunda de manhã. Isso aí tudo consulta.  
**Evelyn La:** Sim,  
**Luiz Jorge:** Esses amarelos faltaram e os azuis confir foram. Forte essa carrinha.  
**Evelyn La:** entendi.  
**Luiz Jorge:** Então assim, fluxo eu tenho, mas eu preciso ter mais fluxo de particular. Eu atendo Unimédia,  
**Evelyn La:** tem é o que vai fazer o seu é o que vai fazer você mudar  
**Luiz Jorge:** temô e Petrobras.  
**Evelyn La:** de de nível no sentido assim, eh, trabalhar com uma performance de um ticket melhor, eh vender mais, vender mais caro, vamos dizer assim também, né? E ter mais qualidade de vida.  
   
 

### 01:01:44

   
**Evelyn La:** é trabalhar realmente essa essa esse quesito aí do particular, que é onde vai te trazer é o particular que vai te trazer a tranquilidade para você eh largar hoje o o tanto de prestação que você faz pros hospitais ali, né? Então, é como você comentou lá no início. E a e aí eu te pergunto, até agora, ficou claro para você? Ficou claro sobre a nossa atuação, sobre como que é a nossa empresa?  
**Luiz Jorge:** Sim, sim.  
**Evelyn La:** Legal. Você acredita aí que a gente conseguiria te ajudar?  
**Luiz Jorge:** Acredito que sim. Espero que  
**Evelyn La:** Parab. Vamos lá. Com certeza.  
**Luiz Jorge:** sim.  
**Evelyn La:** Não tenho dúvidas. Então, a gente faz essa parceria junto com você por se meses e vamos falar sobre o valor, então, né?  
**Luiz Jorge:** Bora. Deixa eu,  
**Evelyn La:** Vamos falar um pouquinho sobre Vai lá.  
**Luiz Jorge:** deixa eu tomar uma água com açúcar aqui rápido. Não tô brincando.  
**Evelyn La:** Se quisesse eu esperava, não tinha problema não. Bom, eu sempre digo o seguinte, Luiz, valor diferente de preço, né? valor é tudo que realmente de fato a gente coloca na ponta do lápis às vezes ali, pós putz, valeria tanto.  
**Luiz Jorge:** is  
**Evelyn La:** Preço vai ser eh relação ao que você paga para ter acesso.  
   
 

### 01:02:58

   
**Evelyn La:** Então existe uma diferença aqui. O valor do programa ele seria se a gente fosse colocar as calls, tutoria, tudo isso na ponta do lápis que eu te mostrei, ele seria incluindo, né, o CRM que você não precisa pagar, ele seria esse valor aqui. Se fosse olhar pelo valor, tá? Óbvio que não é esse valor aqui, mas se eu te falasse assim, Luiz, você vai ter quase quase que precisou da água com açúcar,  
**Luiz Jorge:** Já quase eu desmaiei aqui já.  
**Evelyn La:** hein?  
**Luiz Jorge:** Quase,  
**Evelyn La:** E eu falei que eu esperava,  
**Luiz Jorge:** quase quase.  
**Evelyn La:** hein? Mas se eu te falasse assim, Luí,  
**Luiz Jorge:** Olha.  
**Evelyn La:** se hoje, olhando só pelo valor e tudo que a gente entrega, o treinamento que a gente vai fazer com as secretárias, enfim, se você pudesse ter 75% de desconto sobre o valor que tá aqui hoje, vocês se considerariam um acelerado nosso? Olhando por pelo valor, não tô falando de preço ainda, tá? Olhando pelo valor, do valor que tem o programa,  
**Luiz Jorge:** Uhum.  
**Evelyn La:** 75% de desconto, vocês tornariam  
**Luiz Jorge:** Pois é. Eu vou te dar um exemplo. Se fosse esse 67.000.  
**Evelyn La:** acelerado.  
   
 

### 01:04:04

   
**Luiz Jorge:** Um exemplo, tipo, hoje eu não teria condições porque eu tô em fase de mudança e eu tô gastando tudo que eu tenho que eu não tenho. Eu vendi até uma, eu tinha tenho uma rã, vendi agora para poder eu tentar me mudar, porque eu tô até hoje na casa, eu tô desde agosto na casa dos meus pais. Então assim,  
**Evelyn La:** Certo.  
**Luiz Jorge:** é por isso que eu tô te falando que eu preciso movimentar o quanto antes, porque eu me desfiz de um carro que eu gostava, porque era uma minha rã para poder tentar me mudar, porque já visto que obra, apartamento, é uma fábrica de dinheiro e nunca não tem, é um posto sem fim. Então, ainda que eu tô pretendendo me mudar agora em março, ainda eu tô gastando uma fortuna, ainda falta muita coisa. Então assim,  
**Evelyn La:** Certo?  
**Luiz Jorge:** a gente tem que ver realmente esses valores para poder ver se realmente a gente vai ter condições de começar a fazer esse  
**Evelyn La:** Tá,  
**Luiz Jorge:** processo  
**Evelyn La:** entendi. Então assim, hoje você tá com custo alto fixo aí, pelo que você tá me  
**Luiz Jorge:** gigantesco no cartão.  
**Evelyn La:** falando,  
**Luiz Jorge:** Eu tô quase queimando todo meu dinheiro do meu carro que eu vendi agora, final de começo de  
**Evelyn La:** tá? o que que você teria hoje de eh disposto assim para você poder investir,  
   
 

### 01:05:05

   
**Luiz Jorge:** janeiro.  
**Evelyn La:** porque daí o que que o que que eu quero te falar assim para te ajudar já você começar realmente movimentar, eu personalizar ainda mais eh contigo ali a parte do do programa, sabe?  
**Luiz Jorge:** What?  
**Evelyn La:** Mas para eu entender o que que você mais ou menos teria hoje em mente assim, falar a Evelyn, por mês aí, por uma parcela mensal,  
**Luiz Jorge:** Pois é,  
**Evelyn La:** quem sabe eu conseguiria,  
**Luiz Jorge:** eu não tenho nem noção para te falar a verdade, porque como eu nunca fiz, eu não tenho noção, entendeu? Assim, eu nunca fiz isso.  
**Evelyn La:** tá?  
**Luiz Jorge:** Eu tô procurando ajuda, mas eu não tenho noção de valores. Eu não tenho noção de como fun de agora como funciona, porque tu me explicou, mas eu não tenho noção de nenhuma de  
**Evelyn La:** Certo? Tá. Vamos lá então.  
**Luiz Jorge:** valores.  
**Evelyn La:** Esquecendo o preço aqui, esquecendo esses números que você viu, só pelo valor do que a gente entrega, você acredita que um mês a gente conseguiria tirar você da estagnação?  
**Luiz Jorge:** É, espero que sim. A intenção é  
**Evelyn La:** Tá? Mas mais uma vez,  
**Luiz Jorge:** essa.  
**Evelyn La:** pelo valor que a gente entrega de tudo que a gente vai fazer junto com você, o treinamento, você acredita que a gente conseguiria fazer isso juntos?  
   
 

### 01:06:17

   
**Luiz Jorge:** Acredito que sim.  
**Evelyn La:** Maravilha.  
**Luiz Jorge:** Aí vai depender de tudo, forma de pagamento,  
**Evelyn La:** Claro,  
**Luiz Jorge:** tudo aí direitinho,  
**Evelyn La:** claro, claro. Não, perfeito.  
**Luiz Jorge:** entendeu?  
**Evelyn La:** Mas eu queria entender assim, se de fato você viu o sentido e e acredito que nós podemos te  
**Luiz Jorge:** Não. Sim. Não. Na teoria é indo,  
**Evelyn La:** ajudar,  
**Luiz Jorge:** entendeu? Tá  
**Evelyn La:** questão de preço aqui, a gente vai é resolvido quanto a isso.  
**Luiz Jorge:** perfeito.  
**Evelyn La:** É tranquilo. É só realmente fato para eu entender aqui se você viu sentido e acredito que a gente consegue  
**Luiz Jorge:** Não. Sim, sim,  
**Evelyn La:** junto.  
**Luiz Jorge:** sim. A teoria é bonito. Tipo,  
**Evelyn La:** Sim,  
**Luiz Jorge:** eu espero que vá funcionar,  
**Evelyn La:** eu sei, eu sei.  
**Luiz Jorge:** entendeu?  
**Evelyn La:** Sim. Vamos lá então.  
**Luiz Jorge:** que a intenção é essa,  
**Evelyn La:** Vamos trazer com  
**Luiz Jorge:** é por isso que senão não tava procurando, porque eu preciso de ajuda,  
**Evelyn La:** certeza quem vai junto com  
**Luiz Jorge:** de orientação, eh, uma pessoa que a cabeça pensante,  
**Evelyn La:** você.  
**Luiz Jorge:** que coisa que eu não tenho tempo fazer. Então é isso que  
**Evelyn La:** Perfeito. Perfeito. Então, vou te trazer alguns exemplos de algumas pessoas que, assim como você também acreditaram no potencial que a gente poderia fazer juntos.  
   
 

### 01:07:13

   
**Evelyn La:** Uma delas é a Dra. Débora. Fechada aqui, ó. 5 dias, 100 mais de R$ 100.000. A DFne, que também foi uma superação aí, 125.000, ela fez de faturamento aí uma semana. O Dr. Maxuell, que é um que vem seguindo certinho nossos processos também e vem tendo bastante resultado, né? o faturamento dele aqui,  
**Luiz Jorge:** E como vocês fariam essa captação rápida para aparecer a paciente particular assim do  
**Evelyn La:** ó,  
**Luiz Jorge:** nada?  
**Evelyn La:** com alinhamento do seu perfil, posicionamento e estratégia de marketing.  
**Luiz Jorge:** Mas isso tudo pelo  
**Evelyn La:** Todo pelo Instagram.  
**Luiz Jorge:** Instagram.  
**Evelyn La:** Todo pelo Instagram. Uhum. Então, hoje o seu Instagram, que que a gente, primeira coisa que a gente ia fazer, movimentar ele para a gente fala assim,  
**Luiz Jorge:** M.  
**Evelyn La:** tornar o o mínimo viável possível, vamos dizer assim. pra gente conseguir fazer uma boa captação,  
**Luiz Jorge:** Yeah.  
**Evelyn La:** usar já do que dos cases que você tem, que você falou que você tem ali, né? A gente você manda esse material para nós e aí a gente vai linkar e fazer campanha a partir desse material que você envia para nós. São as fotos dos seus resultados,  
   
 

### 01:08:23

   
**Luiz Jorge:** Uhum.  
**Evelyn La:** basicamente,  
**Luiz Jorge:** Aí vocês que montariam as coisas,  
**Evelyn La:** tá?  
**Luiz Jorge:** então.  
**Evelyn La:** Sim. A gente que monta a campanha. O que que a gente sempre vai pedir uma hora ou outra? um vídeo aparecendo você falando, mas não é uma coisa assim, não é toda semana a gente vai precisar ali material pra gente  
**Luiz Jorge:** Então, se precisar a gente vai ter que começar a fazer,  
**Evelyn La:** poder  
**Luiz Jorge:** porque é importante aparecer. Não adianta tá só mostrando figurinha,  
**Evelyn La:** Sim, não é assim,  
**Luiz Jorge:** fotinho e vídeo dá muito mais engajamento.  
**Evelyn La:** até mesmo por para uma campanha muito e assim a campanha para ela gerar uma uma eficácia é importante aparecer, é importante você fazer uma chamada ali, uma CTA que a gente diz, né, que é uma chamada para ação, mas isso tudo a gente direciona você de como fazer, tá? A gente vai te explicar, vai te mostrar, vai alinhar certinho com você esses detalhes. A gente vai basicamente de você, do seu tempo, a gente vai precisar o quê? você gravar o vídeo, mandar pra gente, a gente definir com você as estratégias principais ali de posicionamento e captação de perfil que você quer atingir e todo outro trabalho a gente que faz, tá? Então é isso. Eh, você executar a sua parte e a gente executar em excelência também a nossa parte,  
   
 

### 01:09:42

   
**Luiz Jorge:** Sim. E os valores?  
**Evelyn La:** sabe?  
**Luiz Jorge:** Me conte logo antes que eu que eu caio aqui.  
**Evelyn La:** Vamos lá, então, alguns que aqui que acreditaram, né? Olha aí, ó, usando só o nosso script de venda. R$ 238.000. Não vou ler todos eles, tá? 96 em 17 dias, mas alguns exemplos do que a gente tem hoje, dos nossos acelerados. O valor, lembra que eu te pedi um sim ou não? Então, o sim ou não é para quê? Hoje, se você falar assim para mim, Evelyn, não tem como, não tem como a gente dar esse passo agora pro programa de aceleração completo, se meses, com tudo que tem nele aqui, os bônus, as trilhas e tudo mais, o seu não, ele tem um valor de 51.000 à vista ou oito de 740, tá? Esse é o valor do não. Por que o valor do não, Evelyn? Porque você falar para mim, eu vou precisar dois, três, 4 meses para eu analisar por algum outro motivo que que você já comentou aqui comigo, até que você tá tendo outros gastos. Eh, esse vai ser o valor do seu não. Agora você falar para mim, Evelyn, eu estou disposto e eu fecho com você hoje na call, na call eu tenho um valor diferenciado para esse programa de 6 meses.  
   
 

### 01:10:53

   
**Evelyn La:** Fechando comigo hoje o valor do seu sim, que vai me gerar toda a nossa economia administrativa e financeira, inclusive reduzindo os nossos custos de remarketing. De 51, ele fica por 42 à vista ou quatro de ou 12 de 4200\. Esse é o valor do seu sim para call, para fechar aqui comigo hoje e ter todo o programa de aceleração de 6 meses.  
**Luiz Jorge:** Aí, qual é a minha insegurança? Tipo,  
**Evelyn La:** Vamos lá.  
**Luiz Jorge:** e se não der certo um exemplo, entendeu? p\*\*\*\*, aí porque quando eu te falei,  
**Evelyn La:** Tá,  
**Luiz Jorge:** eu tô investido em material, cursos e no meu apartamento que eu não consigo me mudar.  
**Evelyn La:** tá, tá  
**Luiz Jorge:** Então assim, eu tenho um um cartão de crédito meu que é só de curso.  
**Evelyn La:** certo,  
**Luiz Jorge:** Então só esse cartão eu vou pagar até novembro 10.000 por mês. Só de curso.  
**Evelyn La:** tá  
**Luiz Jorge:** O meu pessoal que eu tô gastando com obra,  
**Evelyn La:** certo.  
**Luiz Jorge:** não sei o quê, não sei o quê, não sei o quê, tô gastando muito mais de 30\.  
**Evelyn La:** Certo?  
**Luiz Jorge:** Então eu tenho que pensar  
**Evelyn La:** Tá. Tá. Mas deixa eu entender. Vamos lá.  
   
 

### 01:11:54

   
**Luiz Jorge:** aqui.  
**Evelyn La:** Pera aí. A sua questão seria só mais o receio do investir e não ter retorno  
**Luiz Jorge:** Aham. Sim, sim, sim.  
**Evelyn La:** ou seria algo mais financeiro mesmo de para ter esses  
**Luiz Jorge:** Não, investir, tipo, a gente dá um jeito, mas é investir não tem  
**Evelyn La:** tá. Não. Vamos lá então. Deixa eu,  
**Luiz Jorge:** retorno.  
**Evelyn La:** se eu trouxesse o Renan aqui, que é o nosso sócio, para ele te falar sobre garantias, que que você acha? Posso chamar ele rapidinho?  
**Luiz Jorge:** E esse aí é o menor preço mesmo. Menor, menor preço. Não.  
**Evelyn La:** É, esse é para fechamento em call. Aham. Ficaria 4 12 de 42 ou os 42\. Deixa eu falar com o Renan aqui pra gente pra gente conversar, porque sobre a questão da garantia ali, a gente consegue até trabalhar isso. S. Deixa eu passar aqui, colocar você para trocar uma ideia com Ren aqui.  
**Luiz Jorge:** Aí começaria em março. Isso hoje carnaval não todo mundo  
**Evelyn La:** Começa hoje.  
**Luiz Jorge:** tomando gelada. Não,  
**Evelyn La:** Não, mas é o que que seria, Luía? A gente fechando hoje,  
   
 

### 01:13:19

   
**Luiz Jorge:** não.  
**Evelyn La:** eu já crio o grupo VIP, né? Já crio o grupo VIP, já coloco a nossa equipe lá que vai cuidar junto com você da empresa já. Ó o ó, ó o dono aí, ó. Ó o cabeça nosso aí, ó.  
**Luiz Jorge:** É esse aí?  
**Evelyn La:** O nosso Esse aí,  
**Luiz Jorge:** É,  
**Evelyn La:** esse aí que vai fazer acontecer,  
**Luiz Jorge:** será? Olha,  
**Evelyn La:** Luiz.  
**Luiz Jorge:** rapaz.  
**System Digital:** Boa noite, seu Luiz,  
**Luiz Jorge:** Tudo bem?  
**System Digital:** como que você tá?  
**Luiz Jorge:** Boa noite. Tranquilo.  
**Evelyn La:** Aí,  
**System Digital:** Que que tá acontecendo  
**Evelyn La:** Luía, o que que seria?  
**Luiz Jorge:** Se se não der certo,  
**Evelyn La:** Eu aí,  
**Luiz Jorge:** ele devolve em dobro,  
**System Digital:** aqui?  
**Luiz Jorge:** né?  
**Evelyn La:** ó. É isso aí,  
**Luiz Jorge:** É esse que é que é o homem,  
**Evelyn La:** ó.  
**Luiz Jorge:** né?  
**System Digital:** Vamos lá.  
**Evelyn La:** Esse é o homem.  
**System Digital:** Qual que é a dúvida? Fala para mim.  
**Luiz Jorge:** Dinheiro, gastar, quer dizer, investir e retornar.  
**System Digital:** Show de bola. Da onde que você é?  
**Luiz Jorge:** Sou de Belém.  
**System Digital:** Belém. Show. E hoje você é especial. A sua especialidade é qual?  
   
 

### 01:14:15

   
**Luiz Jorge:** Cirurgião Buco Maxilo, dentista. Cirurgião Buco Maxilo.  
**System Digital:** Show. Qual que é o seu faturamento atual hoje?  
**Luiz Jorge:** Pois é, cara. É muito é muito relativo isso,  
**System Digital:** Ah, precisa mesmo entrar  
**Luiz Jorge:** porque tem os fixos e variáveis, entendeu?  
**System Digital:** mesmo.  
**Luiz Jorge:** Então assim, não é muito relativo isso. Posso te falar que de, sei lá,  
**System Digital:** Mais uma média.  
**Luiz Jorge:** de 30,  
**System Digital:** Uma média só pra  
**Luiz Jorge:** 30 a 60, depende.  
**System Digital:** gente.  
**Luiz Jorge:** Tem tem mês que fica nos 30, tem mês que vai para mais. tem, é muito relativo isso,  
**System Digital:** Show. E qual que é o teu objetivo dentro desses se meses  
**Luiz Jorge:** porque como eu não sou funcionário, ah,  
**System Digital:** aí?  
**Luiz Jorge:** ganhar uns 500k por mês, entendeu? Andar de Ferrari, de poste, viajar de primeira classe todo mês para para passar o final de semana aqui na aqui em Miami voltar. É esse que é o objetivo de vida, entendeu? Curtir a família,  
**System Digital:** pros pros próximos seis meses,  
**Luiz Jorge:** os filhos,  
**System Digital:** qual que é o objetivo?  
**Luiz Jorge:** me aposentar.  
**Evelyn La:** Ele tá iniciando.  
   
 

### 01:15:07

   
**Luiz Jorge:** Não, cara, é trabalhar menos, ganhar mais.  
**Evelyn La:** Ah.  
**System Digital:** Não, com certeza.  
**Luiz Jorge:** É esse meu objetivo,  
**System Digital:** Mas vamos lá.  
**Luiz Jorge:** que eu trabalho de domingo a domingo, cara. Então eu preciso ganhar muito mais e trabalhar muito  
**System Digital:** Não,  
**Luiz Jorge:** menos ou que trabalhe mais do que eu trabalho,  
**System Digital:** isso com certeza. Mas vamos lá.  
**Luiz Jorge:** mas que ganhe muito mais, que a preguiça eu não tenho. Então assim, eu trabalho de domingo a domingo, então vendo dinheiro, a hora que for eu vou me chamo duas, 3, 4, 5 da manhã. Então,  
**System Digital:** Boa.  
**Luiz Jorge:** o meu meu meu problema não é não é trabalho, é só ser mais bem remunerado pelo  
**System Digital:** Entendi. Com certeza.  
**Luiz Jorge:** trabalho.  
**System Digital:** Mas vamos lá, só para mim ter clareza, porque aquele negócio, né? Se a gente não sabe para onde a gente vai, qualquer lugar, tá bom? Então, dentro dos de 6 meses, qual que é o seu objetivo?  
**Luiz Jorge:** Cara, é movimentar o consultório. Tipo, eu falei para ela, eu tenho muito fluxo de paciente, mas 80%,  
**System Digital:** De resultado mesmo, de resultado com o pé no  
**Luiz Jorge:** pois é, de 80% é plano e 20% particular,  
   
 

### 01:16:13

   
**System Digital:** chão. Então,  
**Luiz Jorge:** movimenta muito mais.  
**System Digital:** se a gente trocar isso aí, já seria um resultado para  
**Luiz Jorge:** Pois é, a intenção é largar plano e largar plantão,  
**System Digital:** você.  
**Luiz Jorge:** hospital, sobre aviso, largar tudo, cara.  
**System Digital:** Show de bola.  
**Luiz Jorge:** Focar no meu consultório e pronto. É esse que é que é a que é que é meu objetivo, parar de trabalhar sábado, domingo, chegar 6, 7 horas da noite em casa.  
**System Digital:** Ó, vamos lá. Você você sabe que para acontecer  
**Luiz Jorge:** ir para academia, ir paraa academia que nem tu às 9 da manhã,  
**System Digital:** isso,  
**Luiz Jorge:** entendeu?  
**System Digital:** se você sabe que para acontecer isso a gente precisa estruturar alguns pontos aí que a Evely já deve ter passado para você,  
**Luiz Jorge:** Não,  
**System Digital:** correto?  
**Luiz Jorge:** com certeza a gente entende que tudo é investimento, treinamento, tempo, mas a gente fica preocupado, entendeu?  
**System Digital:** É normal, porque crescer dói,  
**Luiz Jorge:** Ah,  
**System Digital:** evoluir dói.  
**Luiz Jorge:** com certeza.  
**System Digital:** É normal. O medo a gente sempre vai ter, mas não pode ser o que vai nos travar. E aquele negócio, o investimento que a gente tem que fazer é pensando com com que o direcionamento que a gente vai ter que se pagar ele,  
   
 

### 01:17:21

   
**Luiz Jorge:** Não. Sim, sim,  
**System Digital:** porque se for pensar com o que a gente tem no bolso hoje,  
**Luiz Jorge:** sim, sim. A intenção é essa. Eu sei que é um investimento. Eu sei que é um investimento. Eu tava falando para ela que agora é o período que eu tô,  
**System Digital:** né?  
**Luiz Jorge:** porque eu tô investindo em curso, em material, em meu apartamento. Então assim, eu fico com medo de investir mais esse dinheiro que eu tive que vender até um carro para tentar me mudar agora em março. E assim,  
**System Digital:** Sim.  
**Luiz Jorge:** eu já tô torrando o dinheiro do carro todinho e não consegui me mudar ainda porque sabe como é que é a obra, é uma fábrica de de dinheiro. Então do nada aparece 20, 10, 15, 20 e assim vai. Então,  
**System Digital:** Fix.  
**Luiz Jorge:** uma eh a gente fica com medo de dar esse outro passo,  
**System Digital:** Sim, com  
**Luiz Jorge:** de investir e aí, p\*\*\*\*,  
**System Digital:** certeza.  
**Luiz Jorge:** não tem um retorno,  
**System Digital:** Confia, confia em tu.  
**Luiz Jorge:** rapaz. Em mim eu confio. Aqui o cara é trabalhador e trabalho bem, graças a Deus. Eu sei que vocês, pelo que ela me explicou, deve trabalhar bem para caramba.  
   
 

### 01:18:18

   
**System Digital:** Então, cara, se você confia em tu,  
**Luiz Jorge:** É só o medo de investir,  
**System Digital:** já, já foi.  
**Luiz Jorge:** entendeu?  
**System Digital:** Valeu, irmão. Se você confia em tu, a gente confia na gente também 100%.  
**Luiz Jorge:** Sim, com certeza.  
**System Digital:** Certo vai dar.  
**Luiz Jorge:** E senão a gente tem que confiar na  
**System Digital:** Exato. Até porque, vamos lá, só para você entender,  
**Luiz Jorge:** gente.  
**System Digital:** hoje eu vou te falar, vou ser bem sincero, só não dá certo aqui com a gente hoje se você não aplicar o que a gente trazer para você. De  
**Luiz Jorge:** Não. Sim, sim. Lógico,  
**System Digital:** resto,  
**Luiz Jorge:** eu tô procurando vocês porque é uma orientação, uma ajuda, um direcionamento,  
**System Digital:** o caso dele,  
**Luiz Jorge:** eh estimular protocolo.  
**System Digital:** o caso dele, o caso dele é aceleração, né? Ô, ô, Evely.  
**Evelyn La:** Sim, sim. Ele já tem duas secretárias, inclusive. Renal,  
**System Digital:** Ah, não. Então,  
**Evelyn La:** tava falando com ele que a gente vai treinar elas.  
**System Digital:** então é fazer acontecer agora.  
**Evelyn La:** Ele não precisa se preocupar dispor de tempo,  
**System Digital:** Não, não, não é fazer acontecer agora.  
**Evelyn La:** entendeu?  
   
 

### 01:19:06

   
**Evelyn La:** É, é  
**System Digital:** Então, vamos lá, ó.  
**Luiz Jorge:** Tá.  
**Evelyn La:** tudo  
**Luiz Jorge:** E qual é o menor preço para te fechar hoje?  
**System Digital:** Vou fazer o seguinte,  
**Luiz Jorge:** Menor  
**System Digital:** é o que a Evelyn passou para você aí.  
**Luiz Jorge:** preço.  
**Evelyn La:** é os 42 da call. Falei para ele, os 42 da vista ou então parcelar em até 12 também,  
**System Digital:** Isso.  
**Evelyn La:** né? Dá pra gente parcelar 12 aí.  
**System Digital:** Cartão vai ficar uma parcela de quanto?  
**Luiz Jorge:** Deixa eu ver.  
**System Digital:** para ele ali  
**Evelyn La:** Fica 4200 a parcela, né? Deixa eu só, deixa até fazer nadom,  
**System Digital:** faz na que nad aquele aquele cashzinho lá que daí nadom vai dar uma  
**Evelyn La:** né?  
**System Digital:** parcela  
**Evelyn La:** Ah, tá.  
**System Digital:** menor.  
**Evelyn La:** Deixa eu abrir aqui então. Pera aí.  
**System Digital:** Qual que é o seu ticket médio hoje, ô doutor?  
**Luiz Jorge:** Como assim?  
**System Digital:** Hoje quanto quanto que você qual qual que é o valor hoje que você cobra em  
**Luiz Jorge:** de  
**System Digital:** média da  
**Luiz Jorge:** Pois é,  
**System Digital:** cirurgia?  
**Luiz Jorge:** cara. Isso é muito relativo. Esse que é o problema. É muito relativo. Nem todo o procedimento é igual.  
   
 

### 01:20:16

   
**Luiz Jorge:** Então, um exemplo,  
**System Digital:** Você  
**Luiz Jorge:** um paciente que quer fazer lipo, só lipo, é um valor. O cara quer fazer lipo, faz daí vai pegar aqui,  
**System Digital:** precisa de nós.  
**Luiz Jorge:** face.  
**System Digital:** Você precisa de nós.  
**Luiz Jorge:** Então assim,  
**System Digital:** Você precisa de nós. Pelo  
**Luiz Jorge:** não. Sim, porque assim,  
**System Digital:** amor.  
**Luiz Jorge:** todo procedimento, nem todos é padrão. Ah,  
**System Digital:** Sim,  
**Luiz Jorge:** o facelift é padrão porque é igual para todo mundo.  
**System Digital:** sim.  
**Luiz Jorge:** Vai abrir e vai puxar e acabou.  
**System Digital:** É esse tipo de produto que você tem que vender aí, cara.  
**Luiz Jorge:** Pois é, que é o mais rentável também. Facelift é mais demorado, mas é mais rentável. Ali, pô, mano,  
**System Digital:** Exatamente.  
**Luiz Jorge:** pode chegar 15, 20.000. Paciente quiser limpar face toda em fazer enxerto de gordura, olheira, nariz, bigode chinês, lábio, mento, 15 20.000 uma um facelift,  
**System Digital:** Ah,  
**Luiz Jorge:** p\*\*\*\*,  
**System Digital:** você faz tudo isso já?  
**Luiz Jorge:** se conseguirar aí uma média de 22.000, p\*\*\*\*,  
**System Digital:** Você faz todos,  
**Luiz Jorge:** perfeito.  
   
 

### 01:21:11

   
**System Digital:** você já faz todas essas cirurgias.  
**Luiz Jorge:** Aí fora anestesista, quase todas, cara. Ainda não comecei a fazer nariz, mas eu quero fazer mais um curso específico de nariz,  
**System Digital:** Foge de nariz.  
**Luiz Jorge:** fazer rindo.  
**System Digital:** Foge de foge de  
**Luiz Jorge:** Pois é.  
**Evelyn La:** Ô Renato.  
**Luiz Jorge:** Não é porque nariz é um é um assim,  
**System Digital:** nariz.  
**Luiz Jorge:** eu vejo muita pessoa as pessoas fazendo que eu acompanho, cara, que vê que não é legal, não fica legal, então eu não gosto de ser curioso, eu não gosto de fazer qualquer coisa. Então assim, quando eu entro para fazer eu faço muito bem feito. Então assim,  
**System Digital:** Boa.  
**Luiz Jorge:** eu vejo que esse nariz não é um negócio tão simples que nem o pessoal acha que é.  
**System Digital:** Não é  
**Luiz Jorge:** Então fazem muita m\*\*\*\*, fica feio.  
**System Digital:** não.  
**Luiz Jorge:** E assim, eu quando eu entro no negócio, eu faço para fazer bem  
**Evelyn La:** Ah.  
**System Digital:** Boa. É isso. Quanto que deu aí? Ô,  
**Luiz Jorge:** feito.  
**System Digital:** ô.  
**Evelyn La:** Ó, eu fiz lá na Don que você falou e com o caszinho lá, ele fica 12 de 3931 55\.  
**System Digital:** Ah,  
**Evelyn La:** Ele dá,  
**Luiz Jorge:** O que que é isso?  
   
 

### 01:22:12

   
**Luiz Jorge:** Dadom.  
**System Digital:** não é o a plataforma de  
**Evelyn La:** é a plataforma de de pagamentos. A gente consegue gerar um cashezinho ali para te dar mais um descontinho,  
**System Digital:** pagamento.  
**Evelyn La:** ó. Por parcela ele vai dar quase R$ 300 de desconto por  
**Luiz Jorge:** Sim,  
**Evelyn La:** parcela.  
**Luiz Jorge:** sim.  
**System Digital:** É isso. Bora para dentro.  
**Luiz Jorge:** 12 de 3900  
**System Digital:** Então,  
**Luiz Jorge:** e  
**Evelyn La:** 31,55.  
**Luiz Jorge:** tá aí. Isso é para 6 meses, né?  
**Evelyn La:** 6  
**System Digital:** se Deus quiser,  
**Evelyn La:** meses  
**System Digital:** se você colocar em prática, não vai precisar nem desses seis meses para ter resultado.  
**Evelyn La:** já.  
**Luiz Jorge:** Não, cara, a intenção é essa.  
**System Digital:** Então, bora,  
**Luiz Jorge:** Intensão é essa.  
**System Digital:** bora fazer acontecer. Bora. Você vai ter  
**Luiz Jorge:** E aí, tá, ficaria 47,  
**System Digital:** 100%  
**Luiz Jorge:** não é isso? E se fosse à vista,  
**Evelyn La:** Isso,  
**Luiz Jorge:** quanto sairia mesmos?  
**System Digital:** os 40 os 42\.  
**Luiz Jorge:** 42\.  
**System Digital:** Isso.  
**Evelyn La:** isso  
**System Digital:** Nossa, que calor que tá  
**Luiz Jorge:** É,  
**System Digital:** hoje.  
**Luiz Jorge:** tu não ve para Belém ainda?  
   
 

### 01:23:13

   
**Evelyn La:** é a gente aqui no Sul reclamando de calor.  
**System Digital:** Eu aceito, eu aceito o convite aí.  
**Evelyn La:** Imagina  
**System Digital:** Eu aceito o  
**Luiz Jorge:** p\*\*\*\*, pode vir, cara, que comida não falta,  
**System Digital:** convite.  
**Luiz Jorge:** mas chuva e calor é é aqui mesmo.  
**Evelyn La:** ele.  
**Luiz Jorge:** E comida de prato bom, comida boa também é  
**System Digital:** Bora, bora para dentro.  
**Luiz Jorge:** aqui.  
**System Digital:** Você vai entrar aqui, vai ter resultado com a gente e a gente ainda vai virar sócio,  
**Luiz Jorge:** De repente,  
**System Digital:** igual tô fazendo com os outros aqui.  
**Evelyn La:** igual  
**Luiz Jorge:** de repente eu vou visitar vocês aí de jatinha daqui a mais um ano. Já pensou?  
**System Digital:** Ah,  
**Luiz Jorge:** p\*\*\*\*,  
**Evelyn La:** ola  
**System Digital:** com o jeito, com o jeito que tá aqui,  
**Luiz Jorge:** jato executivo já pensou?  
**System Digital:** o jeito que tá aí nessa cirurgia da face aqui, daqui uns 5 anos.  
**Luiz Jorge:** Pois é,  
**System Digital:** Isso aqui eu tenho que aproveitar,  
**Luiz Jorge:** cara.  
**Evelyn La:** Ja.  
**System Digital:** tem que andar,  
**Luiz Jorge:** Eh,  
**System Digital:** tem que ir na de braçada antes.  
**Luiz Jorge:** não, daqui daqui a pouco tá tá pois é,  
**System Digital:** Tá igual harmonização daqui a pouco.  
**Luiz Jorge:** tá prostituído já, porque todo esquina faz isso aí.  
**System Digital:** Não, tem que rampar agora.  
   
 

### 01:24:00

   
**System Digital:** Agora que é o momento. Agora que você liberou o CFO ali. Agora é o momento.  
**Luiz Jorge:** Cara, tu pode me dar 10 minutos só para poder ver se eu pago no cartão ou se eu pago a vista.  
**System Digital:** Pode ser. Eu te aguardo.  
**Luiz Jorge:** Não, acho que eu vou pagar num cartão melhor e daí eu não fico descapitalizado mais do que eu já tô.  
**System Digital:** Manda para ele o link. Ô, ô, Evely.  
**Evelyn La:** Tá, vou te mandar aqui pelo chat, se consegue pegar aqui, Luiz. Deixa eu colar ele aqui. Ele  
**System Digital:** E assim aí no Belém também  
**Evelyn La:** já  
**Luiz Jorge:** A gente começa agora em março como para poder ficar redondo o  
**System Digital:** começa já.  
**Luiz Jorge:** mês.  
**Evelyn La:** começa já.  
**System Digital:** Mas você pode  
**Evelyn La:** falei para ele já, já vou, já crio o grupo aqui,  
**System Digital:** já,  
**Evelyn La:** ele já vai receber aí a  
**System Digital:** porque a grande  
**Luiz Jorge:** E aí vai até agosto,  
**Evelyn La:** nossa  
**Luiz Jorge:** é?  
**System Digital:** a  
**Evelyn La:** eh é gosto.  
**Luiz Jorge:** É, deixa até final de agosto logo para ficar tudo  
**System Digital:** Pode ser, tem problema não, pô. Isso aí é o de menos.  
**Luiz Jorge:** certo.  
**System Digital:** Isso aí a gente resolve  
**Evelyn La:** Deixa eu pegar minha minha água aqui rapidinho.  
   
 

### 01:25:15

   
**Evelyn La:** que vocês falaram de calor.  
**System Digital:** fácil.  
**Luiz Jorge:** Quem vai tomar água com açúcar sou eu agora.  
**Evelyn La:** O  
**Luiz Jorge:** Pera aí.  
**Evelyn La:** quê?  
**Luiz Jorge:** Pega lá, filho, que eu tô nervoso. Água para açúcar. Não, brincadeira. Só uma água, só uma água. Só uma água. Eu não sei o que que eu tô fazendo aqui que eu já abri outra  
**System Digital:** Belém.  
**Luiz Jorge:** coisa.  
**System Digital:** Belém.  
**Luiz Jorge:** Oi.  
**System Digital:** E hoje deu um calor aqui que eu vou falar para tu, viu?  
**Evelyn La:** Nossa, eu também, Renato,  
**System Digital:** Diferente.  
**Evelyn La:** céu, eu não sei o que que essa cascavel tem, que o dia que é calor é calor demais, o dia que é frio também é menos do eu falo senhor  
**Luiz Jorge:** Essas revistas,  
**System Digital:** Maringá também.  
**Luiz Jorge:** essas revistas de de mías, tu acha que vale a pena? Porque tem vale a pena fazer negócio de mé guia, essas coisas.  
**System Digital:** Não, pelo amor de Deus.  
**Luiz Jorge:** Pois é, eu acho que eu não vou mais fazer.  
**System Digital:** Aí não,  
**Evelyn La:** Ah.  
**Luiz Jorge:** A mulher tá me perturbando aqui.  
**System Digital:** pelo amor de Deus.  
**Luiz Jorge:** Aplicar também.  
**System Digital:** O que dá?  
**Luiz Jorge:** Não vou não.  
   
 

### 01:26:16

   
**Luiz Jorge:** Tô correndo da mulher aqui.  
**System Digital:** Não, hoje em dia ou é internet ou internet, não tem para onde  
**Luiz Jorge:** Pois é. Não.  
**System Digital:** fugir.  
**Luiz Jorge:** E também dis esse Medguias também quando joga o nome lá aparece meu nome lá em cima.  
**System Digital:** Sim. Hoje, hoje o que vende é se conectar com o público.  
**Luiz Jorge:** Pois  
**System Digital:** É resultado,  
**Luiz Jorge:** é,  
**System Digital:** é, é isso que vende de fato. Você vai aprender muita coisa aqui que vai virar sua chave.  
**Luiz Jorge:** não. Espero que de repente esse negócio realmente dê certo, que a gente continue,  
**System Digital:** Se der, não.  
**Luiz Jorge:** entendeu? Que a gente continue,  
**System Digital:** Se der não.  
**Luiz Jorge:** não só se meses,  
**System Digital:** Se Se der não,  
**Luiz Jorge:** vai ter mais tempo, entendeu?  
**System Digital:** você vai você vai virar é só filho. Meu intuito aqui não é nem isso aqui. Depois o o dinheiro de verdade tá na sociedade.  
**Luiz Jorge:** É isso aí.  
**System Digital:** Hoje a gente, acho que a Evelyn falou ali, né? Sócio estudou algarv, não sei se você conhece.  
**Evelyn La:** da Débora.  
**Luiz Jorge:** Uhum.  
**Evelyn La:** É, eu mostrei para ele ali a a eles todos entraram pela aceleração e depois a gente acabou virando sócio na nos outros produtos.  
   
 

### 01:27:31

   
**System Digital:** Algarve, a Débora agora a Sand também tá  
**Evelyn La:** É.  
**System Digital:** querendo.  
**Evelyn La:** Aí, ó. Show de bola. Só crescer.  
**System Digital:** Amém. É, é isso que a gente tem que fazer, experimentar o melhor desse mundo, pô.  
**Luiz Jorge:** Tá aqui. Isso aí. Não coloco açúcar não, né? Não, não. Tá cheio de  
**Evelyn La:** Ele pediu  
**Luiz Jorge:** açúcar.  
**Evelyn La:** mesmo.  
**System Digital:** Nossa, eu e eu eu e eu Nossa,  
**Luiz Jorge:** Ai, vai ser açúcar.  
**System Digital:** e eu esqueci do eu esqueci o sino para fazer barulho aqui. Tá lá no  
**Evelyn La:** Ai,  
**System Digital:** escritório.  
**Luiz Jorge:** Foi, eu pedi,  
**Evelyn La:** ó.  
**Luiz Jorge:** mas eu falei para cancelar. Tu já colocou açúcar mesmo,  
**Evelyn La:** Eu  
**System Digital:** Cuidar, né?  
**Luiz Jorge:** mano. Chegou a mandar o link?  
**Evelyn La:** te mandei no chat, você viu ali? Você consegue pegar pelo chat ou quer que eu mande no Whats Melhor?  
**System Digital:** Manda no whats mais  
**Luiz Jorge:** É melhor porque é meio,  
**Evelyn La:** Não, tá,  
**Luiz Jorge:** eu tô tentando achar esse chat aí,  
**System Digital:** fácil.  
**Evelyn La:** me passa seu,  
**Luiz Jorge:** mas não tô achando  
**Evelyn La:** tá?  
**Luiz Jorge:** aqui.  
   
 

### 01:28:31

   
**Evelyn La:** Me passa seu número aí que eu vou te mandar agora.  
**Luiz Jorge:** 98200 91  
**Evelyn La:** 91\.  
**Luiz Jorge:** 98200  
**Evelyn La:** 98200\.  
**Luiz Jorge:** 266 Meia meia.  
**System Digital:** Marra.  
**Evelyn La:** Te mandei.  
**System Digital:** Ô, doutor, como que você tá? Tudo bem? Nossa, que a mensagem para responder aqui é brincadeira.  
**Luiz Jorge:** Pera aí que o link não tem que copiar  
**Evelyn La:** Deu certo.  
**Luiz Jorge:** e colar aqui. Pera aí.  
**Evelyn La:** Угу.  
**Luiz Jorge:** Ja. Vai dar certo.  
**Evelyn La:** Aí já deu,  
**System Digital:** Já deu.  
**Evelyn La:** Já  
**System Digital:** A Bárbara tá pedindo para mim entrar para outro doutor  
**Luiz Jorge:** Boa.  
**System Digital:** aqui.  
**Luiz Jorge:** Eu quero ser assim também.  
**Evelyn La:** é  
**Luiz Jorge:** Malhar no horário de 9 hor da manhã que deve malhar vendo da manhã.  
**System Digital:** 9 horas não,  
**Evelyn La:** consegue tirar.  
**System Digital:** 9 horas eu tenho reunião com elas.  
**Evelyn La:** Verdade.  
**System Digital:** 10 horas.  
**Evelyn La:** É verdade.  
**Luiz Jorge:** É 9 tá dormindo ainda. Deve ser só às 10\. É, pode ser. Deixa eu só ver se eu consigo entrar com cartão virtual aqui. M.  
**Evelyn La:** Tô com sede também.  
   
 

### 01:31:19

   
**Evelyn La:** Fui lá, peguei meu celular, esqueci pegar água. Esqueci de pegar água. A mamãe tá na a metade dele, tá? Uhum. Não, tranquilo. O meu pequeno agora veio me trazer uma água aqui também. Sem açúcar. A minha tá agora se acabar que não ficar tudo quietinho. Aham. Aí tomou banho já. Aí sim, hein. Sim, sim. Aí sim.  
**Luiz Jorge:** Oi.  
**Evelyn La:** Oi.  
**Luiz Jorge:** Oi.  
**Evelyn La:** Consegue me enviar ali o comprovante, Luiz?  
**Luiz Jorge:** Deixa eu ver.  
**Evelyn La:** Só pra gente anexar e já passar.  
**Luiz Jorge:** Deixa eu ver como é que eu faço.  
**Evelyn La:** Ah, tranquilo.  
**System Digital:** Mais um acelerado lá do outro lado do C Bárbara também.  
**Evelyn La:** Opa. Aí sim,  
**Luiz Jorge:** Aí sim. Aí eu quero ser sócio também para poder ganhar mais desse lado daí  
**Evelyn La:** hein.  
**System Digital:** E eu quero o videozinho aqui da Evely aqui fazendo,  
**Luiz Jorge:** agora.  
**Evelyn La:** Aí, ó.  
**System Digital:** fazendo aqui igual a gente fez lá com o doutor  
**Evelyn La:** Oi. Chegou aí, Renan, que daí ele nem precisa qualquer coisa. O comprovante ali que eu falei para ele me enviar o comprovante.  
   
 

### 01:33:33

   
**Evelyn La:** Vê aí se chegou.  
**Luiz Jorge:** Eu tô tentando aqui, mas eu tô meio me batendo. Deixa eu ver. Passa loginho. M.  
**Evelyn La:** Você  
**System Digital:** Ai, minhas costas tá travadinha hoje. Só foi 12 horas de reunião.  
**Evelyn La:** consegue ver aí se chegou o dele, o do Luiz que ele falou que já finalizou lá. Era só mais para  
**System Digital:** Deixa eu só dar uma olhadinha  
**Luiz Jorge:** É porque como abriu em PDF,  
**System Digital:** aqui.  
**Luiz Jorge:** eu não tô logado no PDF. Po,  
**Evelyn La:** Ah,  
**Luiz Jorge:** deve tá dando bloqueio aqui para eu fazer o  
**Evelyn La:** sim, sim.  
**System Digital:** Hoje é dia 12, né?  
**Evelyn La:** Gé isso.  
**Luiz Jorge:** compartilhamento.  
**System Digital:** Hoje é dia 12\. Dia 12 de fevereiro,  
**Luiz Jorge:** Olha aí, tu é doido. É muito Jiro entrando,  
**System Digital:** filtrar.  
**Luiz Jorge:** mano. Tem que até filtrar, hein? Quer até filtrar.  
**System Digital:** Nossa, pai.  
**Luiz Jorge:** Deixa eu ver se eu faço um print aqui da tela, pelo menos.  
**System Digital:** Ah, caiu. Deixa eu ver aqui no crédito. Caiu. Seja muito bem-vindo,  
**Evelyn La:** Seja muito bem-vindo,  
   
 

### 01:34:58

   
**Luiz Jorge:** Pronto.  
**System Digital:** doutor.  
**Evelyn La:** Luiz.  
**Luiz Jorge:** Tudo certo.  
**Evelyn La:** Parabéns pela decisão.  
**Luiz Jorge:** Vai dar certo.  
**System Digital:** Seja muito bem-vindo.  
**Luiz Jorge:** A intenção é essa.  
**Evelyn La:** Já deu,  
**System Digital:** Já deu.  
**Luiz Jorge:** Deu. Já  
**Evelyn La:** já deu aqui,  
**System Digital:** Já deu.  
**Evelyn La:** ó, mais um acelerado da Sistem.  
**Luiz Jorge:** deu.  
**System Digital:** Já deu.  
**Evelyn La:** Parabéns pela decisão. Belém será pequena,  
**Luiz Jorge:** Ô, Deus lhe  
**System Digital:** É isso.  
**Evelyn La:** hein?  
**System Digital:** É isso aí,  
**Luiz Jorge:** ouça.  
**System Digital:** meu garoto. Bora para cima. Fazer acontecer agora é aquele negócio,  
**Luiz Jorge:** Vai dar certo. Vai dar  
**System Digital:** o mais rápido possível, o mais rápido possível que você aplicar,  
**Luiz Jorge:** certo.  
**System Digital:** a gente vai tá aqui para te guiar, para te transformar e de verdade aí gerar muito impacto aí na sua vida,  
**Luiz Jorge:** Não vai.  
**System Digital:** no seu negócio e no na vida dos seus clientes também.  
**Luiz Jorge:** A gente investe para negócio dar certo.  
**System Digital:** É isso, cara.  
**Luiz Jorge:** Não vai, vai, vai dar  
**Evelyn La:** Bora fazer acontecer, Luiz.  
**Luiz Jorge:** certo. Tá beleza. Então, valeu, amigo. Obrigado.  
**Evelyn La:** Obrigada, Ran. Até mais.  
   
 

### 01:36:00

   
**Evelyn La:** Tchau. Muito bem, Luiz. Vamos lá, então. Vou montar, ó, te passar agora o passo a passo. O que que vai ser? Vou abrir o grupo VIP, vou incluir você lá no grupo, vou incluir todo o pessoal que vai cuidar junto contigo desse processo.  
**Luiz Jorge:** M.  
**Evelyn La:** Vou te pedir alguns dados ali para você preencher e enviar para nós, que aí a gente vai subir seu contrato no grupo para ser assinado e a gente já starta e marca o melhor horário para fazer seu onboarding, para fazer as reuniões e criar o grupo das suas secretárias lá. Tá bem?  
**Luiz Jorge:** Tá bom.  
**Evelyn La:** Mais uma vez, parabéns pela decisão, viu? E bora fazer acontecer agora nas cirurgias,  
**Luiz Jorge:** Não tem o que acontecer,  
**Evelyn La:** hein? Ficar mais tranquilo, mais em casa,  
**Luiz Jorge:** p\*\*\*\*.  
**Evelyn La:** com com horário de herdeiro aí para pra academia.  
**Luiz Jorge:** É fazer que nem vocês, mas a 9 da manhã, isso que é  
**Evelyn La:** Você viu?  
**Luiz Jorge:** intenção.  
**Evelyn La:** E quem sabe você venha para Foz ainda um dia, né? Comprar uns vinos na Argentina,  
**Luiz Jorge:** Fica hospedado lá naquele hotelzão. Como é o nome daquele  
**Evelyn La:** aquele hotelzão lá na beira da das cataratas.  
**Luiz Jorge:** hotel?  
**Evelyn La:** Isso aí. Parabéns, Luiz, mais uma vez.  
   
 

### A transcrição foi encerrada após 01:38:02

*Esta transcrição editável foi gerada por computador e pode conter erros. As pessoas também podem alterar o texto depois que ele for criado.*', NULL, NULL, '[]'::jsonb, '[]'::jsonb, '[]'::jsonb, '[]'::jsonb, '[]'::jsonb, '{}'::jsonb, '[]'::jsonb, NULL, NULL, NULL, NULL, NULL, 'whisper-1', 'claude-sonnet-4', NULL, NULL, NULL, '2026-03-29T23:22:04.603724+00:00', NULL, '2026-03-29T23:41:42.92551+00:00', '2026-03-29T23:40:16.117+00:00', '2026-03-29T23:41:42.92551+00:00', '2026-03-29T23:22:04.603724+00:00', '2026-03-29T23:41:52.964994+00:00', NULL, '[]'::jsonb, NULL, NULL, '[]'::jsonb, NULL, NULL, NULL);

INSERT INTO call_audits (id, organization_id, closer_id, lead_name, call_date, duration_minutes, resultado, valor_fechamento, status, error_message, score_final, classificacao, d01_frame, d02_qualificacao, d03_diag_quantitativo, d04_diag_qualitativo, d05_consequencia, d06_ensino, d07_identidade, d08_ancoragem, d09_isolamento, d10_proporcao_fala, d11_promessas, d12_checkpoints, d13_fechamento, transcricao, relatorio_completo, resumo_whatsapp, top_erros, top_acertos, plano_acao, frases_proibidas, reescrita_falas, mapa_frameworks, fases_analise, audio_path, audio_duration_seconds, drive_file_id, drive_url, drive_report_url, modelo_transcricao, modelo_analise, tokens_input, tokens_output, custo_estimado, uploaded_at, transcribed_at, analyzed_at, notified_at, completed_at, created_at, updated_at, sentiment_overall, sentiment_timeline, sentiment_score, engagement_level, objections_detected, prompt_version, report_hash, storage_report_path) VALUES
('700a5a81-9324-448f-b2a8-8ffe57259645', '4ecd8f2d-d0c5-419c-a5bc-b2e94dca0465', '171a0543-1dde-4ba4-99f8-d396c6832b60', 'Teste Verificação', '2026-03-28', NULL, 'nao_fechou', NULL, 'completed', NULL, 1.2, 'FRACA', 2.0, 1.0, 0.5, 1.0, 0.5, 1.5, 1.0, 1.0, 0.5, 3.0, 2.0, 1.0, 2.0, '## Auditoria Comercial - Teste Upload - Transcrição

### 00:00:00

**Closer:** Olá, tudo bem?
**Lead:** Tudo bem sim, obrigado.
**Closer:** Ótimo! Eu sou da System Digital e gostaria de conversar sobre nosso programa.
**Lead:** Ah sim, me falaram sobre vocês.

### 00:01:30

**Closer:** Perfeito! Deixa eu te explicar como funciona.
**Lead:** Pode falar.
**Closer:** Nosso programa é focado em resultados. Trabalhamos com harmonização facial.
**Lead:** Quanto custa?
**Closer:** O investimento é de 3.500 reais.
**Lead:** Preciso pensar.
**Closer:** Entendo. Posso te ligar amanhã?
**Lead:** Pode sim.
', '# RELATÓRIO DE ANÁLISE - CALL EVELYN

## 1. RESUMO EXECUTIVO

Esta foi uma call extremamente breve e deficiente em praticamente todas as dimensões fundamentais de vendas high ticket. A closer Evelyn não conseguiu estabelecer rapport adequado, não realizou qualificação do lead, não conduziu diagnóstico aprofundado e apresentou o valor sem contexto ou ancoragem. O lead "Teste Verificação" demonstrou interesse inicial mas rapidamente recuou quando o preço foi mencionado sem preparação adequada. A performance foi classificada como FRACA devido à ausência de estrutura comercial básica.

## 2. SCORECARD

| # | Dimensão | Peso | Nota | Ponderada | Evidência |
|---|----------|------|------|-----------|-----------|
| 1 | Frame | 8% | 2.0 | 0.16 | Não estabeleceu autoridade nem liderança na conversa |
| 2 | Qualificação | 10% | 1.0 | 0.10 | Zero perguntas sobre perfil, dor ou situação atual |
| 3 | Diagnóstico Quantitativo | 12% | 0.5 | 0.06 | Nenhuma investigação sobre números ou métricas |
| 4 | Diagnóstico Qualitativo | 8% | 1.0 | 0.08 | Não explorou emoções, frustrações ou desejos |
| 5 | Consequência | 10% | 0.5 | 0.05 | Não apresentou custos de não agir |
| 6 | Ensino | 5% | 1.5 | 0.08 | Menção superficial sobre "resultados" sem educação |
| 7 | Identidade | 5% | 1.0 | 0.05 | Não trabalhou transformação de identidade |
| 8 | Ancoragem | 10% | 1.0 | 0.10 | Preço jogado sem contexto ou comparação |
| 9 | Isolamento | 10% | 0.5 | 0.05 | Não isolou objeções nem trabalhou resistências |
| 10 | Proporção Fala | 8% | 3.0 | 0.24 | Lead falou pouco, mas closer também não conduziu |
| 11 | Promessas | 8% | 2.0 | 0.16 | Promessa vaga de "resultados" sem especificidade |
| 12 | Checkpoints | 3% | 1.0 | 0.03 | Nenhuma confirmação de entendimento |
| 13 | Fechamento | 3% | 2.0 | 0.06 | Tentativa fraca de reagendamento |

**SCORE FINAL: 1.2/10 - CLASSIFICAÇÃO: FRACA**

## 3. TOP 5 ACERTOS

1. **Identificação da empresa** - "Eu sou da System Digital" - Apresentou-se adequadamente
2. **Tentativa de reagendamento** - "Posso te ligar amanhã?" - Não desistiu imediatamente
3. **Aceitação da resposta** - "Entendo" - Demonstrou empatia básica
4. **Foco em resultados** - "focado em resultados" - Mencionou benefício
5. **Cordialidade inicial** - "Olá, tudo bem?" - Abertura educada

## 4. TOP 5 ERROS

1. **Queima de preço prematura** - "O investimento é de 3.500 reais" sem qualificação - IMPACTO: Gerou choque de preço e resistência imediata
2. **Zero qualificação** - Não fez nenhuma pergunta sobre perfil ou necessidades - IMPACTO: Perdeu oportunidade de criar conexão e relevância
3. **Ausência de diagnóstico** - Não investigou problemas ou situação atual - IMPACTO: Não conseguiu gerar urgência ou necessidade
4. **Falta de ancoragem** - Preço apresentado sem contexto de valor - IMPACTO: Lead não conseguiu justificar o investimento
5. **Estrutura comercial inexistente** - Call sem metodologia ou sequência lógica - IMPACTO: Perda total de controle da conversa

## 5. REESCRITA DE MOMENTOS CRÍTICOS

### Momento 1: Abertura e Qualificação
**Original:** "Ótimo! Eu sou da System Digital e gostaria de conversar sobre nosso programa."
**Reescrita:** "Ótimo! Antes de falarmos sobre a System Digital, me conta: o que te motivou a buscar informações sobre harmonização facial? Qual é a sua principal preocupação hoje?"
**Por quê:** A abertura deve focar em descobrir a dor antes de apresentar soluções, criando relevância e conexão emocional.

### Momento 2: Investigação da Dor
**Original:** "Nosso programa é focado em resultados. Trabalhamos com harmonização facial."
**Reescrita:** "Entendi. E me conta, há quanto tempo você vem pensando nisso? O que mais te incomoda quando você se olha no espelho? Isso afeta sua autoestima no dia a dia?"
**Por quê:** Precisa aprofundar na dor emocional antes de apresentar qualquer solução, criando urgência e necessidade.

### Momento 3: Tratamento da Objeção de Preço
**Original:** "O investimento é de 3.500 reais."
**Reescrita:** "Deixa eu te fazer uma pergunta: se eu te mostrasse como resolver definitivamente essa questão que te incomoda há tanto tempo, quanto isso valeria pra você? Qual o valor de se sentir 100% confiante?"
**Por quê:** Deve ancorar valor antes de revelar preço, fazendo o lead pensar no retorno emocional do investimento.

### Momento 4: Isolamento da Objeção
**Original:** "Preciso pensar." / "Entendo. Posso te ligar amanhã?"
**Reescrita:** "Entendo que é uma decisão importante. Me ajuda a entender: é uma questão de timing, de investimento, ou você tem alguma dúvida sobre os resultados?"
**Por quê:** Deve isolar a verdadeira objeção para tratá-la especificamente, não aceitar objetos genéricas.

## 6. PLANO DE AÇÃO 30 DIAS

1. **Treinamento de Qualificação**
   - O que fazer: Dominar pelo menos 10 perguntas de descoberta sobre dor e perfil
   - Por que: Base fundamental para qualquer venda consultiva
   - Como treinar: Role play diário com script de perguntas, prática com gravação
   - Prioridade: Alta

2. **Metodologia de Ancoragem de Valor**
   - O que fazer: Aprender a criar valor antes de apresentar preço
   - Por que: Preço sem valor gera resistência automática
   - Como treinar: Estudar técnicas de ancoragem, criar scripts de valor
   - Prioridade: Alta

3. **Estrutura Comercial Básica**
   - O que fazer: Implementar sequência lógica: Rapport → Qualificação → Diagnóstico → Apresentação → Fechamento
   - Por que: Calls sem estrutura são ineficazes e desperdiçam oportunidades
   - Como treinar: Memorizar estrutura, praticar transições entre etapas
   - Prioridade: Alta

4. **Tratamento de Objeções**
   - O que fazer: Dominar isolamento e tratamento das 5 objeções mais comuns
   - Por que: "Preciso pensar" é escape, não objeção real
   - Como treinar: Simular objeções em role play, criar arsenal de respostas
   - Prioridade: Média

5. **Desenvolvimento de Rapport**
   - O que fazer: Melhorar conexão emocional e confiança com leads
   - Por que: Pessoas compram de quem confiam e gostam
   - Como treinar: Técnicas de espelhamento, escuta ativa, empatia
   - Prioridade: Média

## 7. ANÁLISE DE SENTIMENTO DO LEAD

**Sentimento Geral:** Neutro evoluindo para resistência
**Score de Engajamento:** 2.0/10 - Baixo
**Nível de Interesse:** Médio no início, baixo no final

**Timeline Emocional:**
- **Início (0-30s):** Neutro/Receptivo - "Tudo bem sim, obrigado" - Demonstrou educação básica
- **Meio (30s-90s):** Curioso/Interessado - "Ah sim, me falaram sobre vocês" - Mostrou conhecimento prévio
- **Final (90s+):** Resistente/Evasivo - "Preciso pensar" - Recuou após choque de preço

**Objeções Identificadas:**
- **Preço:** "Quanto custa?" seguido de "Preciso pensar" - Não foi adequadamente tratada
- **Tempo:** Implícita no "preciso pensar" - Indicando falta de urgência

O lead demonstrou interesse inicial genuíno mas foi perdido devido à abordagem inadequada da closer, principalmente pela queima prematura de preço sem construção de valor.', '🔴 AUDITORIA: Evelyn x Teste Verificação
📅 2026-03-28 | ⏱ N/Amin
📊 Score: 1.2/10 — FRACA

✅ Top Acertos:
1. Identificação da empresa
2. Tentativa de reagendamento
3. Aceitação empática

❌ Top Erros:
1. Queima de preço prematura
2. Zero qualificação
3. Ausência de diagnóstico', '[{"rank": 1, "title": "Queima de preço prematura", "description": "Revelou R$3.500 sem qualificação ou ancoragem de valor - Gerou choque e resistência"}, {"rank": 2, "title": "Zero qualificação", "description": "Não fez nenhuma pergunta sobre perfil, dor ou necessidades - Perdeu conexão e relevância"}, {"rank": 3, "title": "Ausência de diagnóstico", "description": "Não investigou problemas ou situação atual - Não gerou urgência"}, {"rank": 4, "title": "Falta de ancoragem", "description": "Preço sem contexto de valor - Lead não justificou investimento"}, {"rank": 5, "title": "Estrutura inexistente", "description": "Call sem metodologia - Perdeu controle total"}]'::jsonb, '[{"rank": 1, "title": "Identificação da empresa", "description": "Apresentou-se adequadamente como ''System Digital''"}, {"rank": 2, "title": "Tentativa de reagendamento", "description": "Não desistiu imediatamente, propôs contato futuro"}, {"rank": 3, "title": "Aceitação empática", "description": "Demonstrou compreensão com ''Entendo''"}, {"rank": 4, "title": "Foco em resultados", "description": "Mencionou que programa é ''focado em resultados''"}, {"rank": 5, "title": "Cordialidade inicial", "description": "Abertura educada e respeitosa"}]'::jsonb, '[{"rank": 1, "title": "Treinamento de Qualificação", "por_que": "Base fundamental para venda consultiva", "prioridade": "alta", "o_que_fazer": "Dominar 10 perguntas de descoberta sobre dor e perfil", "como_treinar": "Role play diário com script, prática gravada"}, {"rank": 2, "title": "Metodologia de Ancoragem", "por_que": "Preço sem valor gera resistência", "prioridade": "alta", "o_que_fazer": "Criar valor antes de apresentar preço", "como_treinar": "Estudar ancoragem, criar scripts de valor"}, {"rank": 3, "title": "Estrutura Comercial", "por_que": "Calls estruturadas são mais eficazes", "prioridade": "alta", "o_que_fazer": "Implementar sequência Rapport → Qualificação → Diagnóstico → Apresentação → Fechamento", "como_treinar": "Memorizar estrutura, praticar transições"}, {"rank": 4, "title": "Tratamento de Objeções", "por_que": "Preciso pensar não é objeção real", "prioridade": "média", "o_que_fazer": "Dominar isolamento das 5 objeções comuns", "como_treinar": "Role play com objeções, arsenal de respostas"}]'::jsonb, '[]'::jsonb, '[{"impact": "Cria relevância e conexão emocional", "reason": "Deve descobrir dor antes de apresentar solução", "original": "Ótimo! Eu sou da System Digital e gostaria de conversar sobre nosso programa.", "rewritten": "Ótimo! Antes de falarmos sobre a System Digital, me conta: o que te motivou a buscar informações sobre harmonização facial?", "description": "Abertura após apresentação"}, {"impact": "Gera urgência e necessidade", "reason": "Precisa aprofundar dor emocional", "original": "Nosso programa é focado em resultados. Trabalhamos com harmonização facial.", "rewritten": "E me conta, há quanto tempo você vem pensando nisso? O que mais te incomoda quando se olha no espelho?", "description": "Apresentação do programa"}, {"impact": "Lead pensa no retorno do investimento", "reason": "Deve ancorar valor antes do preço", "original": "O investimento é de 3.500 reais.", "rewritten": "Se eu te mostrasse como resolver definitivamente essa questão, quanto isso valeria pra você?", "description": "Resposta sobre preço"}, {"impact": "Trata resistência real, não genérica", "reason": "Deve isolar objeção específica", "original": "Preciso pensar. / Entendo. Posso te ligar amanhã?", "rewritten": "É uma questão de timing, investimento, ou você tem dúvida sobre os resultados?", "description": "Tratamento da objeção"}]'::jsonb, '{}'::jsonb, '[]'::jsonb, NULL, NULL, NULL, NULL, NULL, 'whisper-1', 'claude-sonnet-4-20250514', 1347, 3828, 0.0615, '2026-03-28T00:33:57.936382+00:00', NULL, '2026-03-28T17:19:36.995+00:00', '2026-03-28T17:30:54.513282+00:00', '2026-03-28T17:30:54.513282+00:00', '2026-03-28T00:33:57.936382+00:00', '2026-03-28T17:30:54.513282+00:00', 'negative', '[{"moment": "Receptivo e educado", "period": "Início", "sentiment": "neutro", "confidence": 0.7}, {"moment": "Interesse por conhecer a empresa", "period": "Meio", "sentiment": "positivo", "confidence": 0.6}, {"moment": "Resistência após choque de preço", "period": "Final", "sentiment": "negativo", "confidence": 0.8}]'::jsonb, -0.3, 'low', '[{"text": "Quanto custa? Preciso pensar", "type": "preço", "handled": false}]'::jsonb, '2.0', NULL, NULL);

INSERT INTO call_audits (id, organization_id, closer_id, lead_name, call_date, duration_minutes, resultado, valor_fechamento, status, error_message, score_final, classificacao, d01_frame, d02_qualificacao, d03_diag_quantitativo, d04_diag_qualitativo, d05_consequencia, d06_ensino, d07_identidade, d08_ancoragem, d09_isolamento, d10_proporcao_fala, d11_promessas, d12_checkpoints, d13_fechamento, transcricao, relatorio_completo, resumo_whatsapp, top_erros, top_acertos, plano_acao, frases_proibidas, reescrita_falas, mapa_frameworks, fases_analise, audio_path, audio_duration_seconds, drive_file_id, drive_url, drive_report_url, modelo_transcricao, modelo_analise, tokens_input, tokens_output, custo_estimado, uploaded_at, transcribed_at, analyzed_at, notified_at, completed_at, created_at, updated_at, sentiment_overall, sentiment_timeline, sentiment_score, engagement_level, objections_detected, prompt_version, report_hash, storage_report_path) VALUES
('2803799a-e97b-48f1-a144-078cf8a66124', NULL, '171a0543-1dde-4ba4-99f8-d396c6832b60', 'Tutoria Gravada (Drive)', '2026-03-24', 88, NULL, NULL, 'completed', NULL, 2.9, 'FRACA', 4.0, 2.0, 1.0, 3.0, 2.0, 8.5, 6.0, 3.0, 1.0, 3.0, 4.0, 5.0, 1.0, ' Espera só um pouquinho. Para gravar? Está gravando. Está gravando. Mas espera só um pouquinho que eu pedi a Mari para fazer um aviso lá nos grupos. Certo. Obrigado. E aí E aí Só me dá o ok daí, Matheus, quando eu iniciar? Acho que pode iniciar. Eu não estou conseguindo falar com a Mária aqui. Certo Eu vi que ela tinha passado um comunicado nos grupos ali Mas Vamos ver se foi em todos Mas vamos lá Tem mais gente pedindo para entrar aqui Bom, vamos lá então. Vamos dar início hoje à nossa tutoria aqui. Muito boa noite para todo mundo, quem está chegando em casa, quem já chegou, quem ainda está no trabalho. Eu me chamo Evelyn, hoje faço parte do time da System. Alguns aqui acredito que já me conheçam e até tenho iniciado e dado start através de mim na System. E vamos lá então, a gente vai falar um pouquinho sobre temperamentos e perfil DISC. Como assim temperamentos e perfil DISC? Deixa eu só aceitar aqui. Boa noite, quem está chegando. Sejam muito bem-vindos. Vou compartilhar minha tela aqui já. Aí fica mais fácil. Então vamos lá, vamos entender um pouquinho mais sobre pessoas hoje. Que é isso, né? Basicamente é tudo sobre pessoas. Antes de começar, vou me apresentar rapidamente para vocês. Eu me chamo Evelyn Camila Lambiani, eu sou bióloga de formação, mestre em genética, trabalhei durante 10 anos na área, com pesquisas e análises médicas e microbiológicas dentro da genética. tive meu próprio negócio durante quatro anos, depois que eu saí da área laboratorial eu engravidei, casei, tive meu filho depois eu abri um próprio negócio, divorciei e entrei para o mundo digital. Eu comecei a estudar vendas comportamento humano neurovendas em 2023 e atualmente trabalho na CIS, tenho unindo tanto conhecimento da área da saúde tem um pouco dessa trajetória e vivência, com a parte de relacionamento, pessoas e vendas, no geral. A venda, querendo ou não, ela é um relacionamento. Deixa eu só ir aceitando o pessoal que está entrando aqui. Então, quando a gente fala sobre vendas, a gente fala sobre pessoas, certo? Para quem chegou agora, muito boa noite, seja muito bem-vindo. Então a gente está falando sobre pessoas. E quando eu falo sobre pessoas, eu preciso minimamente entender sobre pessoas. Então quando a gente fala sobre temperamento disc, é justamente para que a gente possa ter uma leitura um pouco mais refinada para quando a gente vai tanto atender um paciente, quanto contratar pessoas para o time, quanto para eu poder me compreender muitas vezes. Isso faz parte. Todo mundo aqui concorda que só existe uma profissão no mundo, que essa profissão é a venda? É para refletir aí. só existe uma profissão no mundo e é a venda se a gente for parar pra pensar por que que às vezes eu vejo um outro profissional faturando mais que eu vendendo muito mais que eu tendo muito mais visibilidade do que eu sabendo que eu sou melhor que ele muitas vezes no que ambos fazem seja muito bem vindo Diogo, boa noite então às vezes a gente olha por fora e pensa, poxa, mas por que fulano de tal vende tanto fatura tanto ou faz tanto e eu aqui sou muito melhor do que ele, sei que eu tenho muito mais capacidade e estou estagnado claro, envolve inúmeros outros processos aí mas basicamente ele se vende melhor do que você Então, tudo no mundo é venda. Se a gente for pesquisar no dicionário, o que significa venda? Você vai achar lá. Significado de vender. Transferir a propriedade de bem ou mercadoria e serviço em troca de pagamento convencionado. Ou seja, o que eu faço é a minha moeda de troca. O que eu vendo é a minha moeda de troca. Eu vendo cirurgia, eu vendo serviço, eu vendo um produto físico. Até mesmo ONGs, se não souberem se vender, não conseguem pessoas das quais apoiem seus projetos. Então hoje nós vamos trabalhar um pouquinho A compreensão do que é o temperamento O que é um perfil DISC Qual a importância disso para eu me compreender E qual a importância disso no meu dia a dia Para eu lidar com o meu time Para eu lidar com o meu paciente E para eu me vender melhor E ao mesmo tempo vender melhor O serviço do qual eu presto, né? Ou qual eu tenho, enfim. Então, vamos lá. Primeira coisa. Você vende do jeito que você gosta de comprar? Por quê? Como assim, Evelyn? Você vende do jeito que você gosta de comprar? O ser humano naturalmente tem uma coisa chamada sales chute. Significa barreira de vendas. Porque eu odeio que me vendam, mas eu amo comprar. Porque é nostálgico, é prazeroso, é dopaminérgico comprar. Mas eu odeio que venham me vender. E aí, eu preciso entender como é que, primeiro, eu tomo as minhas decisões de compra, para eu poder entender como é que o meu paciente toma a decisão de fechar comigo um procedimento. E aí, a gente vai entender um pouco mais o que é o temperamento e do que é o perfil DISC, para que automaticamente vocês compreendam melhor quais as maneiras mais assertivas de se comunicar com o seu paciente e de se comunicar até mesmo no seu ambiente de trabalho, de network, de familiar. Por quê? Porque a comunicação é muito do que o outro entendeu e não, teoricamente, sobre o que você falou. Por quê? Porque cada um tem um temperamento diferente. Boa noite, Marjorie, tudo bem? Ó, acertei de primeira, hein? Marjorie. Então, a gente compreender sobre temperamento, sobre perfil de risco, nos ajuda a entender melhor como é que eu me comunico com o outro. Porque eu posso falar a mesma coisa para diferentes pessoas e cada uma vai entender e vai assimilar aquilo que ela quer. Boa noite, consegui. Boa noite, seja bem-vinda. porque as pessoas compram pelas razões delas. E qual que é o nosso papel, então? Para quem está ativo na venda do seu procedimento, ou até mesmo aqueles que buscam ter outros que façam isso, quem está nessa linha de frente de fazer o fechamento, precisa entender necessariamente, compreender mais sobre o temperamento, sobre o perfil da outra pessoa. Não que você vai ser um... Nossa, para eu bater o olho hoje e eu saber qual o perfil de cada um, você precisa de um certo treino. Mas eu compreendendo um pouco mais sobre cada temperamento... Boa noite, Carla. Seja bem-vinda. Sobre eu entender um pouco mais sobre o temperamento de cada um, eu vou conseguir passar melhor essa informação. Então, vamos lá. Primeiro, eu vou explicar para vocês um pouco mais sobre o que é os temperamentos, o que é um perfil DISC, e depois a gente vai linkar essas duas informações. Por quê? Porque vocês vão ouvir falar, talvez vocês já tenham ouvido falar, sobre temperamentos e também sobre o perfil DISC. E há uma correlação entre eles, sim. A diferença é que um veio antes e o outro depois. Mas, basicamente, ambos vão ser para explicar melhor sobre o comportamento de cada um de nós, cada ser humano. Tá bom? Então, vamos lá. Opa. Pessoas compram de pessoas e cada um decide do seu jeito Que é aquilo que eu falei A comunicação é muito sobre o que o outro entende E não muito sobre o que se fala de fato Então a gente compreender o outro melhor traz clareza Para que eu me comunique de forma mais assertiva com essa pessoa Então lá no século V O pai da medicina, Hipócrates surgiu com uma teoria que cada ser humano tem um tipo de temperamento. E o temperamento, nós temos quatro tipos. E o temperamento, você nasce com ele. E Hipócrates relacionou muito esse temperamento com fluidos corporais. Então, cada temperamento está correlacionado a um determinado fluido corporal que você tem e que, de fato, você tem uma predisposição a produzir mais daquele fluido. Então, você é considerado do temperamento X, Y, Z. Então, Hipócrates, lá no século V a.C., já tinha essa visão sobre os temperamentos, já estudava e afirmava que isso influenciava no tipo de tomada de decisão, no tipo de comportamento, o tipo que você faz qualquer coisa. E ele ainda afirmou mais. O teu temperamento, você nasce e ele é fixo. Você não muda de temperamento. O que acontece muitas vezes? ao longo da nossa evolução, do nosso desenvolvimento, como pessoas, como seres humanos, como profissionais, desenvolvemos habilidades que são de outros temperamentos. Então, por isso que vocês vão entender depois, mais para frente, vocês vão bater o olho e vão falar, ah, eu acho que eu sou tal coisa. Mas às vezes você não é aquela tal coisa, você é outro temperamento, mas de tanto que foi necessário você desenvolver certa habilidade, você acredita talvez que você seja um determinado tipo de temperamento. Mas o temperamento não se muda. Temperamento você serve para quê? Para você se conhecer e temperamento se tempera. Como assim? Eu vou entender que o meu temperamento vai ter os seus pontos positivos e o seu lado negativo, ou seja, o lado que eu tenho de mais luz, o meu lado sombra, que é o desafio. que é o desafio que eu vou aprender a lidar com o meu comportamento. Nossa, top. Olha, nossa. E aí? Diogo, você pode silenciar seu áudio com a sua gentileza? Ou quer falar alguma coisa? Sim, pode ser com você. Obrigada. Aí lá, em 1945, surgiu um psicólogo chamado William Marston, com uma teoria de perfis DISC, que é a mais utilizada no mundo das vendas. Hoje, o DISC é o mais usado para vendas. E o DISC, ele é muito visto como o quê? Como um rótulo. Como assim, Evelyn? No DISC, você vai entender que existem ali também os quatro perfis DISC que se correlacionam com os quatro temperamentos. No perfil DISC, você vai entender que, dependendo do perfil que mais predomina em você, é o seu temperamento fixo, ou seja, a personalidade fixa da qual você nasceu. No perfil diz que ele te dá uma porcentagem. Por exemplo, eu vou ser mais dominante, 40% influente, 20% conforme, enfim. E isso vai me trazer uma clareza do quê? Quais são as minhas habilidades mais fortes? Quais habilidades que talvez eu precise desenvolver para determinadas coisas? E o temperamento, eu vou entender a minha personalidade fixa, que eu nasci. com ela. A partir disso eu também vou me autoconhecer e isso vai se refletir no conhecimento do outro lá também. Então vamos começar por temperamentos. Lembrando que o temperamento e o perfil disc se correlacionam depois. Por que eu trago temperamentos e perfil disc numa mesma abordagem? Porque às vezes o pessoal vai falar, ah, eu sou dominante. Aí o dominante do perfil diz que você já vai entender que ele é o colérico do temperamento. Então, para que vocês conheçam e saibam, existem os dois e um está correlacionado com o outro. Então, eu sempre pergunto, quem será que é você no rolê dos temperamentos? Vamos entender um pouquinho sobre temperamento. Existem quatro tipos e você nasce com um fixo. Você nasceu desse jeito, você vai morrer desse jeito. Sim. Por quê? Porque é uma coisa biológica. Lá atrás, o pai Hipócrates, lá da medicina, já afirmou e outros estudos também afirmam e trazem que o colérico tem um certo de fluido a mais no corpo. É uma predisposição. Lembrando que é uma predisposição a isso. Eu vou aceitando o pessoal aqui que vai chegando. Então, vamos entender aqui quais são os quatro temperamentos que a gente tem hoje. Eu tenho o colérico e o sanguíneo. Por que eles estão com essas cores e por que eles estão nesse lado de cima? Porque eles são considerados temperamentos quentes. Quentes. E os temperamentos que ficam embaixo, fleumático e melancólico, eles são temperamentos frios. Não quer dizer quente, no sentido de ser uma pessoa muito... Sim, tem um pouco de correlação em relação a isso de ser uma pessoa mais esquentadinha. Mas o frio não quer dizer que é frio de frieza, de antipatia. Não, mas que são perfis mais introspectivos, mais fechados. E o colérico e sanguíneo são perfis mais explosivos. Eles falam com muita facilidade, eles pegam realmente o... Como dizia minha avó, pegam na partida se precisar. E sim, porque é natural. É um perfil quente. Então, o colérico, ele vai ter mais predisposição a um fluido corporal chamado bile amarela. A bile amarela produzida ali pela vesícula biliar, ela muitas vezes, quando esse colérico, ele não consegue trabalhar muito do lado dele explosivo, ele vai ter uma tendência a ter dores de estômago. Com certeza vocês já ouviram casos de que a bile derrama no estômago. Acontece muito com o colérico mesmo. Então, o elemento, os elementos da natureza, né? São quatro também, fogo, água, terra e ar. O elemento qual está mais correlacionado ao colérico é o fogo. Por quê? Porque o col ele aquela pessoa que ele explode muito f Mas ele tamb uma pessoa que transmuta muito f Como assim Ele resolve, ele acha uma solução. Deu um problema, não tem problema. Cai, levanta. Aconteceu um problema, ele foca na solução. Ele não fica remoendo demais. Ele quer resultado, ele quer agilidade, ele quer bola para frente. Normalmente, empresários, empreendedores, são coléricos. Normalmente, não é uma regra. Mas aqueles dos quais são coléricos, eles têm mais facilidade em correr riscos. Porque às vezes eles não pensam na consequência, eles tomam a decisão e vão. No meio do caminho, ele acha a solução. Sanguíneo. O sanguíneo, também um temperamento quente, mas o elemento que se relaciona com ele é o ar e o fluido corporal que mais predomina é o sangue. O sanguíneo, por que que correlaciona muito ao ar? O ar é leve. O ar, o vento, ele muda de direção a todo momento. Então, o sanguíneo tem muita essa característica. Ele toma uma decisão rápido, mas ele muda muito de ideia a todo momento. Uma hora ele quer uma coisa, outra hora ele quer outra, outra hora ele quer não sei o que. E ele é quente também. Ele é um temperamento quente, ou seja, ele é um temperamento extrovertido. Tanto colérico quanto sanguíneo são extrovertidos. E aí a gente tem o fleumático. O fleumático, a gente já vai estar falando de temperamentos frios aqui, ou seja, introspectivos. O temperamento introspectivo, ele tem mais fluido corporal de fleuma ou da linfa. Ficam localizados, ele tem uma tendência a produzir mais muco. E ele está muito correlacionado ao elemento água, ou seja, são pessoas muito emotivas. Tem uma tendência a ser emotivas. E elas são mais quietinhas, são pessoas que demoram tomar decisões, são pessoas que têm uma calma, não falam, não agiam, não gostam de falar muito sobre eles, são pacíficos, não se metem em briga, não gostam de discussão, são muito pacificadores, não gostam de expor muito a opinião deles. E o melancólico também é considerado temperamento frio porque ele é introspectivo, ele é mais para dentro do que extrovertido para fora, e ele tem a tendência de produzir mais o fluido corporal, que é a bile negra. E aí ele tem isso muito forte, e o que isso acaba influenciando? No baço, a produção de células e de imunidade. Então, eles normalmente são pessoas que têm uma tendência a ter resistência imunológica muito alta. É uma pré-exposição de melancólicos. E o elemento que correlaciona muito a eles é o terra. Por quê o terra? Porque eles são como rocha mesmo. Eles são muito constantes, estáveis. Estáveis no sentido fixos. Eles são muito resistentes, são pessoas que demoram muitas vezes tomar decisões, mas quando eles tomam, eles vão até o final. Então, são pessoas muito resilientes, resilientes muitas vezes também, de forma natural. Então, isso é um pouquinho sobre o temperamento. E o perfil DISC? Aí a gente vai correlacionar agora. No perfil DISC, as características são as mesmas, a correlação com elementos é o mesmo. E aí você vai só mudar o que? A nomenclatura. Então, quando eu ouvi falar sobre dominante no perfil DISC, eu sei que eu estou falando com colérico. Então, o dominante, o colérico, ele vai ser movido a quê? A resultado. Lembra? Ele é fogo. Ele transmuta, ele quer resultado, resultado no relacionamento, resultado na empresa, resultado na amizade, resultado... Ele sempre vai entrar em uma sociedade, em qualquer coisa que ele vai fazer, pensando no quê? O que eu ganho com isso? Ele quer resultado, ele vive, ele é movido a resultado. Se ele não tem resultado, ou se algo não está gerando resultado, ele tem uma tendência muito grande a se frustrar. Ele não fica pela amizade. Então, a tomada de decisão, inclusive, do dominante, ela é muito rápida. O influente é o sanguíneo, lembra? Ar, muda de decisão a toda hora. Mas os influentes, eles são muito amigáveis. Eles ficam, muitas vezes, pela amizade. Então, o influente, ele vai ter um foco mais no quê? Em interações sociais. Ele vai ser movido. O que move o influente na tomada de decisão na vida dele é se aquilo tem um propósito. Se ele vai conseguir gerar interações sociais. Então, o fluente vai ser muito movido a isso. Ele vai entrar num negócio pensando o quê? O quanto que eu consigo de envolvimento com as pessoas, porque eu quero fazer amizade. E a tomada de decisão dele também é rápida, porém, ele muitas vezes muda o foco. É isso que faz um fluente muitas vezes se perder na jornada. O que é de primordial para um influente ter resultado? Agenda. Rotina e trabalhar muita disciplina. Porque eles têm uma tendência de ser indisciplinados. E é uma tendência natural do perfil. Estável. É o fleumático. Aquele cara mais emotivo, aquela pessoa mais emotiva. Naturalmente mais emotiva. Ele leva muitas coisas para o coração. Então, o perfil estável, ele vai o quê? Ele vai ter muito foco em constância. Mas ele demora muito para tomar decisão. A Marjorie já se identificando. O perfil estável, eles são... E assim, a gente vai pegar. Olha que interessante. A maioria de cirurgião, médicos, essa área na saúde, a gente encontra muito número de estáveis. Porque é um perfil excelente para esse trabalho manual de detalhes. Entende? É o melhor perfil. E aí é onde a gente encontra a dor, na maioria dos casos. é porque eles precisam desenvolver um pouco mais da dominância, porque além de ser um cirurgião médico, muitos são empresários, precisam de características dominantes. E quando um dominante, ele é, no caso, um cirurgião, um médico, ele aprende a desenvolver uma característica do estável, que é essa questão tanto do estável quanto do melancólico, que é essa questão do detalhe, da paciência, do foco. E aí o estável vai ter muitas vezes a tomar decisão lenta, porque ele é movido por segurança. Tudo aquilo que parece ser mais seguro, ele vai. Aquilo do qual ele fica meio, não sei, ele tem dificuldade. Então, ele toma muitas decisões baseadas na segurança. E ele é um excelente em constância. Um perfil. Ih, tinha alguém pedindo para entrar e saiu? não sei quem é então o perfil estável ele vai ter essa habilidade grande que é a constância, quando ele começa alguma coisa ele faz e ele faz exatamente eles são ótimos para seguir processos são ótimos e aí o constante é aquele muitas vezes, aquelas pessoas que a gente olha assim que eles entram numa empresa às vezes para trabalhar e eles ficam naquela mesma função fazendo aquela mesma coisa por 20, 30, 40, 50 anos, às vezes, sem se cansar. Porque eles têm uma habilidade muito grande de lidar com essa constância. O dominante, ele já não tem muita paciência. O influente, ele quer fazer toda hora uma coisa diferente. Melancólico. O melancólico é o conforme no perfil DISC. O conforme, ele tem muito foco em detalhes e precisão. Muito. São muito precisos. São excelentes em precisão. O que o dominante não tem de precisão, o conforme veio com tudo. Deixa eu ver quem que está pedindo aqui, porque não está aparecendo para mim quem está pedindo para entrar. Então, o conforme, ele tem também uma tomada de decisão lenta. Mas por quê? Porque ele vai se focar nos detalhes. Se não tiver tudo minuciosamente detalhado, mostrado, em tabelas, em dados e tudo mais, ele demora mais para tomar a decisão. Porque ele é detalhista, de fato. Então, aqui a gente tem, unindo temperamentos com o perfil DISC, nós temos um resumão aqui, para a gente poder entender um pouquinho mais sobre as pessoas. Então, diz que o dominante do D, ele é o colérico, que o elemento relacionado a fogo. Então, sempre você vai imaginar pessoas mais explosivas. E o foco deles é sempre resultado. Eles são movidos a resultados. Tudo que eles vão fazer, eles vão buscar resultado. Influente, o I, ele é do temperamento sanguíneo, elemento ar. Porque se move para lá e para cá, muda todo momento de direção. E o foco deles vai estar mais em relacionamentos e propósito. Então, tudo que eles vão fazer na vida, no relacionamento, na amizade, no profissional, eles precisam ver propósito, de fato. Não quero saber tanto o meu resultado, mas eu quero saber o propósito. Eu quero saber como é que vai ser a minha interação, o meu relacionamento com as pessoas. Eu quero fazer amizade, eu quero ser aceito. A gente tem muito isso. O estável no DISC, o S, ele é o fleumático no temperamento. Ou seja, são as pessoas que são movidas pelo elemento água, né? Mais emoção. São excelentes terapeutas, inclusive, também. E os fleumáticos, eles vão ter foco em que? Segurança. Então, tudo aquilo que me parece mais seguro é o que eu opto pela minha vida, para minhas tomadas de decisão, relacionamento, em empresa, em trabalho, em tudo. E o C, que é o conforme, é o melancólico nos temperamentos. Eu limento terra. O mais resistente de todos. E o foco dele é precisão. Então, a precisão, o detalhe, ele é movido por coisas que vão dar precisão e detalhe. Então, os conformes, eles são muito tidos também como analíticos. São pessoas que gostam de analisar muito antes de qualquer tomada de decisão. Legal. Ok, Eve, entendi. Então, a gente tem perfil de isso, tem temperamentos. Muitos aí já devem ter se identificado. Ah, acredito que eu seja isso, acredito que eu seja aquilo. Mas e aí? Nas vendas e na minha relação com meus pacientes, na minha relação com os meus funcionários, na minha relação, enfim, conjugal, familiar, networking até mesmo. Por que é importante a gente entender? O que faz de diferença quando eu estou com um colérico, por exemplo? Se uma pessoa não compreende sobre, diz que é o temperamento, e ela vai fazer uma reunião com um colérico, ou ela vai em algum lugar e o colérico está lá, ela vai olhar e vai achar muitas vezes a pessoa grossa. Mas ela não é grossa. Mas você, por não entender, vai falar isso. Ah, é aquele grosso. Ah, falou não sei o que, é grossa. Não é, ela é direta. O papo dela é reto. Porque ela é colérica. E ela não está brigando muitas vezes com você. Ela está só sendo ela, mas você não sabe. Aí o paciente vem, ou você mesmo é assim. E você vai ser assim com o paciente, e o paciente também às vezes não vai entender. Ou você não vai entender o paciente. Ou a sua secretária não vai entender o paciente. E aí começa a confusão, porque às vezes ela é fleumática. E aí ela vai achar que o colérico brigou com ela. Que o paciente não sei o quê. E não é, né? Ele só está às vezes sendo ele. Nas vendas, a importância de você entender sobre perfil é por quê? Para a gente poder entender e alinhar a nossa comunicação. o colérico, ele vai chegar, o dominante colérico, ele vai chegar para uma reunião, uma consulta, e ele já vai chegar perguntando sobre o resultado que ele vai ter com o procedimento XYZ, às vezes ele quer pular a etapa, nem quer fazer anamnese, enfim. Aí você, se é colérica também, você também às vezes quer ir já para o... acelerar o negócio. Mas a gente acaba esquecendo que o quê? A venda é relacionamento. E aí se você pula certas etapas, você vai perder muitas vezes aquele paciente ali no meio do caminho. Até mesmo a secretária lá, se não entender que ele é um colérico, vai perder ele. Por quê? Ele vai chegar querendo o resultado, querendo isso, querendo aquilo. O que você faz? Pula o ano. Seja direto com o colérico. Não enrole o colérico, Porque ele vai perceber e ele vai se cansar de você. Seja direto. Mas mesmo sendo direto, mostre para ele que a gente vai precisar. Sim, a anamnese é importante. Para quê? Aí você fala para ele. Para isso, isso e isso. Ponto. Direto. Sim. Aí você vai ter a atenção dele. Outra coisa muito importante. Um colérico, ele só te respeita quando você mostra resultado para ele. Caso contrário... Então, você vai ter o respeito que eu digo no sentido assim, ele vai te ouvir, ele vai prestar atenção, ele vai querer até mesmo ir para um fechamento, por exemplo, para uma consulta e tudo mais, se ele de fato ver que, opa, fulana é especialista referência na área XYZ. Olha o resultado dela aqui. Ele vai olhar, tem Instagram lá, tem um resultado para o outro. É isso que ele vai olhar. É o ambiente de trabalho, é o ambiente de... É isso. O colérico, ele só... Por quê? Porque o colérico é fogo, ele não quer perder tempo. Ele detesta perder tempo. Tempo para ele é precioso. Então, se ele vai, é porque ele está interessado. Se ele não gostar, ele vai te falar. Se ele gostar, ele vai te falar também. E aí, como você se comunica com o colérico? De uma maneira mais direta, sim, sem muita enrolação, trazendo os pontos importantes para ele e mostrando para ele a jornada do resultado. E mostrando que sim, você tem resultado, que tal coisa, tal procedimento vai ter taxa XYZ de resultado para ele. E você na posição de comunicar com ele, no sentido de vendedor ali, você vai realmente, inclusive, deixar que ele tome por si a decisão. Você pode até conduzir ele a um pedaço da parte de vendas ali, que acredito que você já tenha tido tutoria sobre isso. Mas ele precisa entender que a decisão está sendo tomada 100% apenas por ele, que de fato é. Mas você conduz ele, muitas vezes, a isso. Então, o dominante, ele vai ter isso. E as características para você, mais você treina o seu olho, você vai conseguindo identificar as pessoas pela postura, pela forma como fala, pela forma como age. Fotos no Instagram, você já consegue identificar se é pessoa dominante, colérica, filmática, etc. Só pelo jeito dela falar. Pelo jeito de muitas vezes ela encolher o ombro. Falar baixinho. Ou falar mais aberto. Falar alto. Então o dominante, ele tem uma característica muito dele. Que é um olhar muito penetrante. O dominante, ele tem esse olhar. Eu trouxe até a Angelina Jolie aqui para a gente entender um pouco mais sobre isso. Pode ver, ela tem um olhar muito penetrante. E o dominante tem essa característica. Então, só de você ver, muitas vezes fotos você consegue identificar quando a pessoa tem um perfil mais dominante, polérico. Influente O influente Ele tem uma comunicação expansiva Mas ele é o mais da risadinha O colérico ele é mais sério O cara é um pouco mais fechado muitas vezes O influente já não, ele é muito da risadinha Tá sempre sorriso, sorrisão Demais, às vezes Tem uma comunicação expansiva Ele gosta de ser reconhecido ele gosta de pertencimento. E ele não é muito assim de regras, ele fala bastante, inclusive, também. Então, o influente é aquela pessoa, aquele paciente, às vezes, que você vai para a consulta, ele conta a vida inteira dele para você ou para a sua secretária antes de marcar a consulta. Ele fala da vida toda, de tudo. Ele fala, fala, fala, fala, às vezes, ele até se perde ali do que, por que ele buscou você. O que é importante para o influente? A gente precisa aprender a contornar o influente de maneira que ele não se perca realmente. Porque senão se perde do objetivo ali, tudo mais, ou ele vai querer mudar toda hora de opinião, e isso também é ruim para você. Para quem está ali, nessa posição de fechar o procedimento em si. Ou até mesmo fazer essa avaliação. E aí você precisa conduzir ele de uma maneira um pouco mais firme, o influente. Por ele ser tão expansivo, você, primeira coisa, para você se comunicar com ele, ganhar conexão logo de cara. Por que é importante a conexão logo de cara? Porque é aí que você vai conseguir ter essa pessoa mais próxima. E é da proximidade que você vai conseguir gerar os relacionamentos, para você manter o quê? Muitas vezes a sua cad de faloap a sua revenda a parte de trabalhar o seu cliente de base O influente voc vai se conectar com ele de primeira demonstrando o interesse naquilo que ele est buscando O elogio, muitas vezes, um elogio genuíno, obviamente, não, bajulador. Não, não é isso. Mas o influente, você acolhe, você ajuda ele a imaginar o cenário, ou seja, ele busca por um determinado procedimento. Você mostra para ele, fazendo ele se imaginar pós aquele procedimento. E demonstra o interesse. Então, esse é um trabalho muitas vezes que começa com a secretária, mas na hora de você atender o paciente, faz diferença. Você demonstrar interesse genuíno por ele. Ele vai se sentir mais à vontade com você. Por que eu preciso que o meu cliente se sinta à vontade comigo? Porque, primeira coisa, ele precisa confiar em mim. Se ele confiou uma vez, confiar a segunda, a terceira, a quarta vai ser muito mais fácil. Cuidar de quem já está dentro, contigo, no seu ecossistema, é muito melhor do que você ficar tentando captar fora toda hora. Sim, é importante. Sim, é necessário. Mas você manter o relacionamento, ele aumenta muito mais o que a gente fala? LTV. Lifetime Value. O tempo que esse cliente fica e investe em você. É muito mais gratificante e o retorno é muito maior. Então, você se conectar de maneira certa de uma primeira vez, é para quê? Para ele confiar em você. Se você confia em você, confia no seu trabalho? Estável. O estável, o fleumático, ele é aquela pessoa que tem uma comunicação lenta. Ele não fala rápido, ele fala de forma mais gradativa, devagar, tinho, muitas vezes. Ele é aquela pessoa que não gosta de se incomodar e nem incomodar ninguém. Então ele tem uma comunicação assim mais Mais para dentro que a gente fala, mais introspectiva até mesmo Eles não gostam muito de mudanças também Mudanças bruscas O estável eles são por natureza calmos e harmônicos Eles buscam a harmonia Sempre E eles não funcionam sob pressão. Se não adianta querer pressionar demais um estável. Se pressionar demais um estável, ele vai o quê? Vai escapulir. Por quê? Porque ele não gosta de ser lidado sob pressão. E aí a gente tem que fazer um trabalho do quê? de criar um relacionamento, muitas vezes, de follow-up maior, cadência de follow-up maior com os estados. Ou se for para, de fato, ele vir para fechar o procedimento, você vai, primeira coisa, conduzir com muita calma. Porque ele vai agir e tomar decisão por segurança. Então, você precisa falar com tranquilidade, mostrar, de fato, a segurança que gera no procedimento XYZ que ele está em busca. Então, o estável vai ter muito isso. Na linguagem corporal, vamos dizer assim, os estáveis são aquelas pessoas que você olha e fala assim, carinha de tímido. O Wagner Moura, adoro ele, inclusive. ele tem isso né eles são, parece assim aquelas pessoas parece que é doce eles são, sabe queridinhas então o estável ele é muito assim sabe, às vezes ele anda até meio assim encolhidinho às vezes senta nos lugares e tal, o estável ele não gosta nem que ele vai sempre pra um cantinho ele não gosta muito de que olhem pra ele que todo mundo veja que ele chegou aqui. Já os perfis quentes, que é o colérico e o influente, eles te chegam o colérico nem tanto, mas o influente, você sabe quando uma pessoa é um influente que está chegando, porque ela chega no lugar e ela quer que todo mundo olhe para ela, que todo mundo repare nela, repare muitas vezes na roupa que ela está usando. O influente, ele é assim. O estábulo já é mais tranquilo. E aí, quando você é uma polérica ou uma influente, você vai atender um perfil estável, você tem que muitas vezes segurar a tua dominância ou a tua expansividade. Porque os estáveis, às vezes, eles até se assustam com isso. E aí, desconecta. Por que é importante entender do ponto dessa primeira conexão? A primeira conexão, a gente sempre chama do que? Rapor. O rapor é a conexão. seja da sua secretária com o paciente, seja de você com o paciente ali. Mais que o paciente já venha te namorando pelo perfil do Instagram ali, para tomar a decisão e ir até na consulta, quando ele chegar na consulta, de fato, a primeira impressão é que fica. Então, é a conexão. E aí o estável, se você é num perfil mais quente, vai atender um perfil que você vê que ele é um pouco mais ou melancólico ou estável, aí a gente tem que ter esse cuidado só. porque expansão demais atrapalha também no fechamento. Conformes. Bill Gates é um exemplo aqui, né? Para quem é mais analítico, detalhista do que esse homem aqui. Então, o Bill Gates, ele é um exemplo aí de conforme. Normalmente, eles usam óculos. Não é uma regra, né? Mas a maioria das vezes usam óculos ali. o conforme ele tem uma comunicação também lenta mas a lenta do estável é porque ele não gosta de se expor mesmo de falar, de dar opinião o analítico é lento porque ele está processando tudo ele observa tudo ele pega mínimos detalhes ele está quietinho ali mas ele está prestando atenção de caba-raba em tudo então ele tem a comunicação lenta muitas vezes porque ele processa isso e aí ele se posiciona. Então, ele gosta de detalhes, ele gosta de processo, ele gosta de dados, muitas vezes. Me prove com dados. O dominante quer que você prove com resultado. O influente, muitas vezes, não quer nem prova. Ele quer curtir. O estável, ele quer que você mostre a segurança. E o conforme, ele quer que você prove por dados, processos. Ele precisa disso. e eles são muito questionadores, muitas vezes. O conforme, ele é, dependendo dos casos, obviamente, ele é uma pessoa que, quando está um conforme e um dominante junto, normalmente o dominante, às vezes, acaba se estressando com o conforme, porque ele questiona. Então, se o dominante também não aprende a lidar com isso, e não sabe reconhecer, dá choque. E aí, como vendedor, o que a gente precisa mostrar, muitas vezes para esse perfil mais conforme, mais analítico? Tem que mostrar o processo passo a passo, pontuar, mostrar, trazer cronograma, trazer para ele realmente detalhes de tudo o que vai ser feito e como vai ser, porque é o que vai trazer a firmeza, a tranquilidade que ele precisa. E também é um decisor mais lento, muitas vezes. São pessoas que tomam decisões aí, às vezes, um pouco mais, precisam analisar um pouco melhor antes de fazer qualquer coisa. Bom, por que a gente precisa entender sobre pessoas? Por que é legal entender sobre temperamento? por que é importante saber essa correlação temperamento-disque. Porque a venda em si, ela é isso. O relacionamento em si, seja você como empresário e empresa funcionário, seja na hora da contratação, seja... Você vai precisar minimamente entender sobre pessoas. Quando você vai contratar, aí que entra uma questão dos perfis. Quando você contrata alguém para a área administrativa, financeira, gestão, processos, os estáveis e os conformes são os melhores perfis para isso. Porque eles já naturalmente amam seguir processo passo a passo, saber o que vem depois. Para a área de vendas, pré-vendas, é bem mais fácil você contratar quem seja do perfil dominante ou influente. Porque eles são mais extrovertidos, a comunicação para eles é uma coisa mais fácil até mesmo. Ah, mas então um fleumático inconforme não pode ser vendedor, um bom vendedor? Com certeza. Com certeza, inclusive eu conheço grandes vendedores do mercado, grandes que eu estou falando, grandes mesmo. Tiago Konzer, o próprio Flávio Augusto, que são conformes. Uau, mas o que eles entenderam? Eles entenderam que era necessário trabalhar algumas partes da dominância. Então, não é que a pessoa do perfil conforme estável não serve para vender, mas é importante saber que vai ser uma pessoa que é necessário mais investimento em treino. Ela vai ter uma desenvoltura, vamos dizer assim, mais lenta do que um colérico ou um influente para a venda. Agora, põe um dominante, um colérico ali, para alimentar a planilha. No outro dia ele pede a conta. Tem que ter paciência. Estar sentado atrás de um computador não dá. Mas, o que acontece? Eu, por exemplo. Vamos lá, se vocês realmente prestaram atenção aqui, né? Que perfil vocês acham que eu sou? Pode escrever no chat ou abrir o microfone, quem quiser aí, fica à vontade. O que vocês acham que eu sou? Vou até o solo dominante. O Henrique abriu o microfone. O que você acha, Henrique? Eu estou caçando aqui. É o conforme ou o antes? Eu esqueci o nome. O estável? É. Aí, ó. O Fernando, a colérica. Olha só, temos várias opiniões aqui, hein? Bem mesclado. Eu digo que você é estável. A Nubia achou que eu sou estável. Olha, para quem está achando que eu sou conforme ou estável, eu estou bem feliz, viu? Sinal de que eu consigo... Com força. Sinal de que eu consigo trabalhar o meu temperamento, vocês viram? Eu sou DI. Eu sou dominante e influente. Eu tenho mais de dominância do que influência. Mas eu tenho um pouco da influência também. O meu temperamento fixo é colérico. Tanto que por anos eu tive muito problema de estômago. Você vê como pode, né? Porque eu não sabia trabalhar o quê? A minha explosão. A minha raiva, muitas vezes. Mas olha aí, vocês viram o que é um perfil treinado? A maioria, uma grande porcentagem, achou que eu era conforme. Ou estável. Por quê? Porque é treino. É conhecimento, autoconhecimento, inclusive. E um perfil treinado, um perfil bom nesse sentido, ele vai saber o quê? O que a gente precisa muito também? A escutativa. E a escutativa é natural do conforme e do estável. O dominante infante quase não tem. Então, foi uma coisa que eu treinei muito. Que eu fui buscar entender, fui buscar estudar, fui buscar me autoconhecer, para eu mudar a minha relação comigo mesma e depois com os outros, com os meus clientes, inclusive. Eu falei lá atrás, eu fui empresária também, já, né? Empreendi aí no nicho do varejo. Eu tive uma loja por durante quatro anos aqui na minha cidade, era um produto físico. E eu, com a minha dominância, eu não tinha paciência para tal da gestão, alimentar a planilha e fazer controle financeiro. Imagina só como é que não ia ser o negócio. Tinha coragem, o risco. Rapidinho aqui, só se vocês tiverem dúvidas, Carla. Se não, já encerrou aqui a parte de passado sobre hiperfísio e diz que está encerrado. Se você precisa sair de alguma coisa, fica à vontade. Então, eu mesma fui um exemplo de dominante que precisei o quê? Entender os meus pontos fracos ali do temperamento. E não é buscar melhorar, é treinar. A gente não tem como eu sair de um perfil colérico e querer ser um estátua. Não existe isso. Você vai se frustrar. Por quê? Porque você vai criar um personagem daí. O personagem não se sustenta. O que a gente precisa entender? A gente precisa entender sobre os perfis. isso te traz uma clareza, te ajuda a melhor se relacionar consigo mesmo e se relacionar com os outros. Consequentemente, com os seus pacientes. Porque você vai trazer para eles, de fato, uma comunicação da qual eles vão entender. Eu vou falar com o dominante de uma maneira um pouco mais direta, uma maneira onde eu possa realmente mostrar para ele o meu resultado. O influente, eu vou trazer ele mais para perto de mim, vou mostrar para ele a transformação sem muito detalhe, ele só quer saber realmente como é que ele vai ficar e o quanto isso vai impactar para as outras pessoas, inclusive, se ele vai chamar a atenção. Então, o estável, eu vou mostrar para ele o que? De fato, o quanto que vai ser seguro a tomada de decisão pelo meu procedimento XYZ, olha só, vai melhorar a estética em si, vai te trazer mais autoestima. E o conforme eu vou fazer o quê? Eu vou mostrar para ele detalhes sobre como vai ser o passo a passo de cada processo ali, né, ao longo do procedimento todo, enfim, pós-operatório e tudo mais. E vou mostrar para ele o quê? Olha, se você precisa pensar, muitas vezes o conforme ele não vai ser aquele cara que vai tomar a decisão na hora. Mas se você quer Se viu que ele está interessado E que de fato Você vai resolver o problema dele Sim Você confia no seu trabalho Seu trabalho vai transformar a vida dele E ele já confiou em você Você só vai conduzir para contornar Qual detalhe a mais Do processo você ainda não entendeu Que você precisa que eu te mostre Para que você tome a decisão comigo hoje para que a gente feche esse procedimento. E aí, se ele falar para você, eu não estou, não, porque não sei o que, não sei o que, se ele insistir, não pressione muito. Porque o que é o risco não conforme? O risco é dele não gostar mais de você e, de fato, ele excluir você e bloquear. E aí, é uma pessoa que você pode sim vir a fechar um procedimento, mas talvez ela vai precisar de um ou dois follow-ups a mais após o que ela já consultou com você. Só que, claro, conforme vocês já viram na técnica de vendas, a gente tem o valor protagonista e o valor de tabela. Por que existe isso? Óbvio que é para ajudar vocês a fechar mais, fazer mais futuramento, ganhar mais previsibilidade. É uma estratégia de vendas. O conforme, muitas vezes, ele não vai se encaixar nessa estratégia de vendas. E está tudo bem. Está tudo bem. E aí você vai falar para ele o quê? Fulano, seja conforme, seja estável. Fulano, tudo bem para você, então, se você precisar pensar a respeito e a gente fechar então no outro valor? porque você entende que também, para mim, existe XYZ, por isso que eu te dou essa bonificação, você não... E aí você mostra para ele que está tudo bem. E é isso, a gente não vai encher uma arma na cabeça da pessoa e vai falar assim, compra. Ou faz. Mas você entender mais sobre os perfis, você entende mais sobre o que faz ele tomar a decisão com você, muitas vezes na hora do fechamento. E isso vai trazer para você mais o quê? Margem, previsibilidade, vai te ajudar você a escalar melhor, você fazer o quê? Tomada de decisões depois baseada em dados melhores ainda. O fechamento na hora, o fechamento em call, ele não é para pressionar a pessoa. Ele é para ajudar na sua empresa, no seu ganho. consequentemente você reflete isso no quê? Na bonificação que você dá para ele, ele também ganha com isso. Então, às vezes a gente tem um certo preconceito, muitas vezes, que é aquilo que eu falei, é o sales shield, a barreira. A gente tem esse certo preconceito de, ah, não sei o quê, não sei o quê, Mas se ele já está ali é porque ele já tomou uma decisão. Você só vai ajudar a encontrar o porquê. E o porquê está no quê? Nos perfis. O dominante quer algum resultado X. O influente, muitas vezes, ele quer se aparecer para os amigos, para a rede de network, para onde ele está de outro jeito. O estável quer mais autoestima. A autoestima vai vindo do quê? Da segurança, da transformação que o seu procedimento vai ocasionar. E o conforme, muitas vezes, ele quer o quê? Ele quer mais qualidade de vida, ele quer mais estética também. Às vezes, ele nem vai assumir tanto assim, mas por trás da decisão dele é isso. Então, pessoal, entender sobre pessoas é o que te faz chegar mais longe. em qualquer nicho. Não é só aqui. Aqui a gente está falando especificamente, claro. Mas em qualquer lugar. Entender sobre pessoas é o que te faz chegar mais longe. É você treinar, inclusive, os seus pontos. É você se autoconhecer. É você entender um pouco mais sobre o seu temperamento. Porque n temos os nossos lados a que muitas vezes s considerados travas Os nossos bloqueios a Voc claro fica vontade Eu estou só falando aqui, mas quem tem dúvida, pergunta, podem ficar à vontade, é hora. Você quer abrir o microfone? Acho que pode abrir, não precisa eu autorizar não, né? GCN, pode falar? Tá me ouvindo agora? Agora tô. Boa noite. Boa noite. Eu queria saber como abordar uma pessoa que é mais sanguínea, de uma forma mais sutil. para fazer uma venda, para explicar de uma forma mais completa. Como conhecer, de fato, uma pessoa em questão da conversa, que essa parte eu não entendi muito bem. Certo. Você diz, então, primeiro, como eu identifico se ele é um influente e como que eu me comunico com ele, isso? Exato. Tá, vamos lá. A pessoa influente vai ser uma pessoa muito de fácil comunicação. Então, por exemplo, vamos simular que eu sou um paciente influente que estou chegando para conversar com a GCN. Eu vou falar assim Oi, Gisele, tudo bem? Então, é o seguinte Eu tava pensando em fazer uma harmonização facial Por quê? Ah, porque eu já tô na idade, porque não sei o quê, nananã Porque a minha amiga fez e ela achou que o resultado foi muito bom Indicou você E aí, essa semana, eu tava vendo na minha agenda aqui E aí eu fui rolando Instagram, achei você Acabei lembrando que a minha amiga já tinha indicado, não sei o quê e eu queria entender sobre vocês, como que funciona, como que é. Então, ele vai falando rápido. Ele vai falando assim. E quando vê, ele está seu amigo, às vezes, na conversa. Então, é uma pessoa que vai sempre conduzir a... Praticamente, conduzir a venda. Muitas vezes, o influente, se você não souber direcionar ele, ele toma a frente. Ele começa a falar sem parar. E aí a nossa posição, no caso, você atendendo o influente. O que você precisa desenvolver? A dominância de você direcionar ele. Por quê? Porque senão ele toma a frente do negócio e ele que domina. Porque ele começa a falar sem parar, você vai deixando, ele vai falando e o negócio não tem um fim. Então o influente tem muito essa característica de que ele chega e ele já fala rápido e ele já conversa com você e ele já conta o que aconteceu. Então o influente vai chegar e vai falar assim gente, se eu estava chegando aqui, meninas acredita que eu parei na esquina ali e quase atropelei um gato, porque o gato passou na frente do meu carro, que nossa senhora, eu não achava lugar pra estacionar depois, mas ainda bem, graças a Deus eu consegui um lugar, tô aqui atrasei 15 minutos, mas cheguei. O influente ele é assim. Bem prolixo. Oi? Uma pessoa bem prolixa, então. Bastante. Entendi Os influentes tem uma tendência muito grande De ser prolixo Eles perdem o foco, porque eles são ar Vento Nossa, vai a loucura Aí o que é o nosso papel? Você ia falar pra mim assim Nossa Evelyn, sério Menina do céu, mas realmente Tá cada vez mais difícil Achar estacionamento aqui perto, né Mas vamos lá, senta aqui, toma uma aguinha Me diga lá Aí você começa que você toma à frente para conduzir. No meio do processo, muitas vezes, ele vai começar a se perder. E aí você tem que ter o feeling de ir fazendo o quê? Conduzindo ele. Mas o que você deseja hoje? Ah, eu quero isso, eu quero isso aqui. Muito bem. Vamos lá. Você vai fazer uma anamnese, você vai fazer uma consulta, você vai mostrar para ele o qual é o melhor para o caso dele. Perfeito. E aí você vai conduzindo e você vai puxando ele de volta para o seu interesse. Se ele começa a voar demais, você faz o quê? Você falaria para mim. Entendi, entendi. Mas vamos lá então. Voltando aqui. Você me disse, você sempre puxa ele de volta. Porque senão, às vezes a consulta que era para ser 40 minutos demora duas horas e meia. E aí o influente, ele é muito bom para tomada de decisão. Se ele gostar, se você mostrar para ele o quê, como é que eu vou resolver e como é que vai ser feito, o resultado que ele vai ter, o que ele vai chegar, ele vai tomar a decisão ali com você, muitas vezes sim. A única coisa que tem que cuidar na abordagem com o influente é o quê? Você acolhe. O que é o acolher? Ele vai chegar falando lá, lá, lá, lá. Você escuta, escuta ativa. Escutou, acolheu, ok. Agora a gente vai dar início à tal coisa. Quando você vê que ele na conversa começou a se perder, você volta, puxa ele de novo, de uma maneira gentil. Não interpele o influente de um jeito muito ríspido. Eu estou lá toda empolgada te contando que eu não achava lugar para estacionar o carro e você vai lá, fecha a cara e fala. Entendi, vamos lá então, vamos fazer anamnese ou não sei o que. Eu já vou olhar e falar assim, nossa, que mal humorada. O influente pensa assim. Não, precisa ser Você vai de uma maneira muito gentil e sutil Você vai falar Nossa, realmente Mas vamos lá Entra aí, senta, toma uma Quer uma aguinha? Você vai conduzir ele E a abordagem que você usa muito Para um influente É a apreciação genuína Porque ele gosta de ser reconhecido Então, você levanta muito para ele. Obrigada, Núbia, pela presença aí. Bom descanso. Você conduz muito ele e você aprecia de forma muito genuína, que a gente diz. Não é uma bajulação, é diferente. Mas você vai pegar os pontos positivos, você vai ver assim, o influente, ele te revela muito na conversa do que ele gosta e aonde ele gosta de ser apreciado. O influente, ele te fala muito no que ele diz, assim. E aí você usa isso pra quê? Pra se conectar com ele. Então, por exemplo, eu sou uma influente e tô lá. Aí eu falo, aí eu chego falando do meu filho. Ai, menina, porque eu tenho um pequeno de sete anos e, nossa senhora, a escola dele me chamaram essa semana da escola, não sei o que, que você acredita que ele já aprendeu a ler, e começa a falar. Aí você, se ele fala mais do filho, começa falando muito do filho, ou de alguma outra coisa específica, tenha certeza de que ele gosta de ser apreciado por isso. E aí você faz uma apreciação genuína. Oh, que bacana, nossa Evelyn, ele já aprendeu a ler nessa idade, que legal, nossa. E aí você dá a sequência e continua com, de fato, o objetivo, né? Mas o influente, ele revela muito fácil. São as pessoas muito fáceis de ler. Eu, quando olho um perfil, eu já imagino, esse é influente. Por quê? O influente, ele gosta de se mostrar. Ele gosta de se aparecer. Então, quando é mulher, então, a mulher tá lá toda bonitona, toda bela, a cabelão, a foto, o vestido que chama atenção, sorrindo, sorrisão. Muitas gostam de mostrar mais o corpo, não tem problema com isso. Então, põe um decotão mais lá às vezes. Elas gostam. É do perfil, eles não têm problema, eles se aceitam. Eles gostam de se mostrar mais. Homem também. Quando é perfil influente, assim, você vê. Ele gosta de se mostrar mais, gosta de mostrar os lugares de fato que ele tá e fazer e tal. Os conformes e os estáveis já não gostam muito. De se mostrar muito, já são mais quietinhos. E os dominantes, eles até gostam de se mostrar, mas muitas vezes eles gostam de mostrar e transparecer poder nos perfis. Então, até na postura. Você pega um casal muitas vezes. Por que eu sei que a mulher é dominante? Só de olhar numa foto. E muitas vezes, ela tá com o marido do lado e ela tá à frente. Ela tá na frente, assim, posturada. Postura de poder. O marido, às vezes, tá mais atrás. Então, são detalhes sutis, às vezes, que quando você vai treinando mais o seu olho, entendendo mais o perfil, você consegue determinar. Até na maneira como a pessoa senta, chega para você na sua frente. Mas muito da comunicação você consegue entendendo um pouco mais, sobre, ah, eu sei que quando é mais extrovertido, se abre de maneira mais fácil, ou ele é um dominante ou ele é um influente, e quando a pessoa é mais recatada, eu sei que ele vai ser um estávão conforme. Aí como é que eu vou fazer? Se eu vejo que ele é mais quente, ou seja, ele é mais aberto, mais extrovertido, mais falante, mais comunicativo e tudo mais, eu sei que eu vou conduzir de uma maneira, ou seja, vou trazer mais resultado, vou trazer um pouco mais do... ele se imaginar realmente no pós-transformação dele e se eu sei que ele não conforma o estável, eu já vou agir com mais tranquilidade e já vou trazer mais da segurança, mais de dados, mais de passo a passo. Evidentemente, eu só trazer um ponto aqui E Essa personalidade Ela pode ser antecipada pelo pré-vendas Então o pré-vendas De vocês já pode falar Qual que é a personalidade desse cliente Que está vindo fazer a consulta Porque aí você já se prepara Exatamente E isso muda o jogo totalmente Porque você já sabe que vai atender uma dominante Você já sabe que vai atender uma influente Então você já se prepara Então, a importância de você ter essa comunicação com a sua secretária, com a sua STR. E muitas das vezes isso não acontece. Às vezes você só agenda e não sabe nem quem é o cliente que vai chegar em você. Não sabe o nome, você não sabe a idade, você não sabe quais são os objetivos, quais são as dores. E o pré-vendas tem esse papel de trazer essas informações e também trazer a personalidade. Exatamente. Muito bem colocado aí, Matheus. Porque é o que o Matheus falou, essa comunicação entre quem faz a parte do fechamento da venda, que na maioria dos casos são os doutores, precisa ter essa relação com a sua secretária, sua SDR, seja quem for que está na função, muito ativa. Sim. É importante também que o SDR saiba identificar o mínimo que seja dos perfis. Porque ele também já vai te trazer. Ou, por mais que ele não tenha tanta expertise de identificar, ele vai te falar às vezes, viu? Às vezes ele vai até chegar desse jeito. Nossa, que mulher chata. Se prepara aí. Ela vai estar perguntando isso, isso, isso, isso, isso, isso, isso. Aí você já se liga. ou ela é uma conforme ou ela grande possibilidade de ela ser uma conforme analítica porque ela ficou perguntando e aí você já vai saber que opa, o que eu vou fazer com um conforme? eu vou precisar mostrar pra ele um passo a passo o que vai ajudar? vai ajudar na tomada da decisão dela se conectar comigo logo de cara ela vai mostrar o passo a passo, ela vai entender opa, não, beleza às vezes ela vai até falar, inclusive nossa, eu já fui em tal ou tal lugar, o quê? E ninguém me mostrou. Ou ninguém fez isso, ninguém teve atendimento XY. Então, essa comunicação realmente precisa ser muito ativa. Tem que estar andando ali, pré-vendas e vendas. Tem que estar aqui, juntinho. Assistem hoje. Pré-vendas e vendas é assim, o tempo inteiro. Gustavo, Laís, Carol, que é nossos pré-vendas, estão o tempo inteiro em contato, em comunicação com quem está na venda. E precisa ter essa comunicação. A gente precisa se preparar para poder entender. Exatamente. Porque se a gente fica a Deus dará, como dizia minha amor, qualquer caminho serve. Se eu não tenho clareza, se eu não tenho direcionamento, se eu não consigo desenvolver, não começo a desenvolver habilidades aí da venda e não tomo essa consciência, o fulano de tal lá da esquina que faz o serviço mais porco que tem vai passar na minha frente. Sim. E às vezes só por conta da comunicação que você teve. Por conta da comunicação que você teve. A influência, enfim. Às vezes a pessoa... Só porque você foi simpática com ela. Ela faz uma cirurgia com você só porque você foi simpática com ela. Porque o influente, ele gosta disso. Ele gosta que você seja simpática com ele. E aí ele não vai pelo preço... Ele gosta de te ver como um amigo. Sim. Exatamente. Ele não vai pelo preço, ele não vai pela segurança, não vai por nada. Ele coloca o peito dele na bala por você, porque ele gostou de você. E a maioria dos negócios se fecham no sentido assim, né? Você consegue boas vendas, escala e tudo, não é pelo preço. É pela experiência que você causa na pessoa. É o como você fez ela se sentir. como que eu me sinto sendo atendida pelo Mateus. O que o Mateus fez eu sentir? Se eu entender que, poxa, o Mateus, ele me compreendeu, ele me ouviu. Lá no final, ele vai me falar o preço dele. Pra mim, interessa o preço. Eu vou dar um jeito, eu vou fazer. Se eu tenho, eu vou pagar à vista. Porque ele me ouviu. e ele soube se conectar e conversar comigo e me falou exatamente do jeito que eu queria ouvir muitas vezes. É a comunicação. É como você se comunica. Isso a gente pode pegar grandes exemplos de várias empresas que têm isso. Como ela se comunica. Hoje a nossa apresentação é voltada totalmente para isso. Então ela fala com todos os perfis. Exatamente. Ela está preparada para todos os perfis. Mas o script, a forma que você conduz, que vai diferenciar. Exatamente. A apresentação sempre vai ser a mesma. O produto, muitas vezes, ele é o mesmo. O mesmo produto, a mesma cirurgia que resolve a minha papada, vai resolver a papada da minha vizinha. É a mesma coisa. Mas a forma como eu vou ser atendida, recebida e conduzida para eu fechar o procedimento é diferente de como vai ser com a minha vizinha. O produto final é o mesmo. O que muda é o jeito que você conduz. Por isso que entender de perfis vai ajudar muito nessa melhoria e nessa tomada de decisão, nessa tomada do valor protagonista. porque é no valor protagonista que a gente vai ganhar a tal da previsibilidade de vendas. Senão, infelizmente, você será engolida pelo tubarão que vai dominar essa arte. E é isso. Às vezes a gente tem a dificuldade de... Obrigada, Marjorie, pela presença. A gente tem essa dificuldade muitas vezes de... Ai, não gosto de vender. É, não quero vender. Mas não é isso. A vida é uma venda, parafraseando o Tiago Consor. A vida é uma venda. Tudo é venda. Seu posicionamento, tudo, para tudo. Então não é em si o vender, não é o produto, né? É o quão você é bom em se relacionar com pessoas. Eu fiquei feliz, então, que vocês acharam que eu sou estável conforme, sinal que eu estou bem treinada. o Matheus eu acho eu já falei o Matheus eu penso ser muito analítico eu acho que eu sou analítico conforme um pouco dominante é, mas desenvolve a habilidade da dominância eu fui mudando muito ao longo do tempo mas é isso a gente vai eu por exemplo, eu não tinha muito essa coisa do conforme o analítico ali. Mas quando eu abri a loja, ou eu me desenvolvia, ou eu me desenvolvia. Não tem jeito, né? Já era, não ia durar. Mas depois a gente vai mandar para vocês também o teste do DISC. Isso. De cada um lá no grupo. Quando for fazer o teste do DISC, eu sempre falo assim, tem uma dica, tem alguns outros, até o Renan mandou um outro site para fazer também um teste ali, né? Tem vários hoje no mercado, até que se encontra gratuito. Mas quando você vai fazer algum teste desse, eu sempre falo assim, uma dica é você voltar um pouco de você na infância para você poder responder as perguntas. Claro que algumas perguntas vão ser muito específicas para a rotina atual e tal, mas sempre tenta buscar lembrar. Eu, por exemplo, como era a Evelyn na infância, tomando decisão, fazendo qualquer coisa. Porque a infância, ela é a fase mais pura, de fato, que a gente tem. Depois, ao longo do nosso desenvolvimento, a gente vai sofrendo alterações ali e influências do nosso meio externo. E é onde a gente acaba desenvolvendo essas outras habilidades, inclusive de outros perfis. Então, se eu fosse parar hoje para analisar a Evelyn hoje, eu tenho características e habilidades de conforme, de analítica, mas eu não sou analítica de raiz. E aí é interessante fazer o perfil, lembrando muito sobre como você era na infância, porque aí você vai extrair de fato seu temperamento, sua personalidade fixa, para você poder se compreender, entender os seus pontos de melhoria, e a partir disso, depois você entende também o que muitas vezes você precisa desenvolver. Exatamente. Vamos ver se alguém tem alguma dúvida. É, se alguém mais tem alguma dúvida. Foi uma hora e meia aí, né? Bastantinho. O pessoal já está cansado, com fome, com sono? Acho que não, né? É isso? É isso. Você sai sempre arrumado assim? Oi? Alguém falou comigo ou foi do Matheus? Não, foi aqui. É isso? Então, pessoal, muito grata pela presença de todos vocês, pela atenção de todos. E qualquer dúvida, qualquer coisa, a gente está à disposição ali nos grupos. Está bem? Uma boa noite. Boa noite. Boa noite. Obrigada. Tchau, tchau. Boa noite. para a gravação deixa eu parar aqui', '# RELATÓRIO DE ANÁLISE DE CALL - TUTORIA GRAVADA

## 1. RESUMO EXECUTIVO

Esta análise refere-se a uma tutoria gravada sobre temperamentos e perfil DISC, conduzida por Evelyn para profissionais da área da saúde. A sessão teve duração de 88 minutos e abordou conceitos de comportamento humano aplicados às vendas e relacionamento com pacientes.

**Contexto:** Tutoria educacional em formato de webinar sobre temperamentos e perfil DISC, com foco em aplicação prática para profissionais da saúde que precisam "vender" seus serviços.

**Performance:** Evelyn demonstrou domínio técnico do conteúdo e engajamento da audiência, mas a abordagem foi predominantemente educacional ao invés de comercial, perdendo oportunidades de conversão direta.

**Pontos Críticos:** Falta de estrutura de vendas clara, ausência de qualificação dos participantes, e não identificação de oportunidades comerciais diretas durante a apresentação.

**Resultado:** Sessão educacional bem-sucedida, mas sem direcionamento claro para conversão comercial ou captação de leads qualificados.

## 2. SCORECARD

| # | Dimensão | Peso | Nota | Ponderada | Evidência |
|---|----------|------|------|-----------|-----------|
| 1 | d01_frame | 8% | 4.0 | 0.32 | "só existe uma profissão no mundo, que essa profissão é a venda" - frame limitado |
| 2 | d02_qualificacao | 10% | 2.0 | 0.20 | Não houve qualificação dos participantes nem identificação de dores específicas |
| 3 | d03_diag_quantitativo | 12% | 1.0 | 0.12 | Ausência completa de diagnóstico quantitativo dos problemas |
| 4 | d04_diag_qualitativo | 8% | 3.0 | 0.24 | Abordou dores genéricas: "por que fulano vende mais que eu" |
| 5 | d05_consequencia | 10% | 2.0 | 0.20 | Mencionou superficialmente: "será engolida pelo tubarão" |
| 6 | d06_ensino | 5% | 8.5 | 0.43 | Excelente conteúdo educacional sobre temperamentos e DISC |
| 7 | d07_identidade | 5% | 6.0 | 0.30 | Estabeleceu autoridade: "bióloga, mestre em genética, trabalho na System" |
| 8 | d08_ancoragem | 10% | 3.0 | 0.30 | "valor protagonista vs valor de tabela" - ancoragem limitada |
| 9 | d09_isolamento | 10% | 1.0 | 0.10 | Não houve isolamento de objeções ou criação de urgência |
| 10 | d10_proporcao_fala | 8% | 3.0 | 0.24 | Falou 95% do tempo, pouca interação com audiência |
| 11 | d11_promessas | 8% | 4.0 | 0.32 | Promessas vagas: "entender pessoas te faz chegar mais longe" |
| 12 | d12_checkpoints | 3% | 5.0 | 0.15 | Alguns checkpoints básicos: "todo mundo concorda que..." |
| 13 | d13_fechamento | 3% | 1.0 | 0.03 | Não houve fechamento comercial, apenas agradecimento |

**SCORE FINAL: 2.9/10 - CLASSIFICAÇÃO: FRACA**

## 3. TOP 5 ACERTOS

1. **Domínio do Conteúdo Técnico** - "Hipócrates, lá no século V a.C., já tinha essa visão sobre os temperamentos" - Demonstrou conhecimento profundo e histórico do assunto.

2. **Uso de Exemplos Práticos** - "Bill Gates é um exemplo aqui, né? Para quem é mais analítico, detalhista que esse homem" - Utilizou referências conhecidas para ilustrar conceitos.

3. **Engajamento da Audiência** - "que perfil vocês acham que eu sou? Pode escrever no chat" - Criou momentos de interação para manter o engajamento.

4. **Autoexposição Estratégica** - "Eu sou DI. Eu sou dominante e influente... vocês viram o que é um perfil treinado?" - Usou sua própria experiência como case.

5. **Conexão com a Realidade dos Participantes** - "A maioria de cirurgião, médicos... a gente encontra muito número de estáveis" - Fez conexões diretas com o público-alvo.

## 4. TOP 5 ERROS

1. **Ausência de Qualificação** - Não identificou quem são os participantes, suas dores específicas ou necessidades comerciais. **Impacto:** Perda de oportunidades de conversão e follow-up direcionado.

2. **Falta de Estrutura de Vendas** - A apresentação foi puramente educacional sem direcionamento comercial claro. **Impacto:** Zero conversões diretas e ausência de captação de leads qualificados.

3. **Não Criou Urgência ou Escassez** - Terminou apenas com "qualquer dúvida, a gente está à disposição nos grupos". **Impacto:** Participantes saem sem call-to-action específico.

4. **Proporção de Fala Inadequada** - Falou 95% do tempo sem dar espaço para descobrir as necessidades individuais. **Impacto:** Perda de oportunidades de identificar prospects qualificados.

5. **Ausência de Diagnóstico Quantitativo** - Não explorou números, faturamento atual ou metas dos participantes. **Impacato:** Impossibilidade de dimensionar o problema e criar proposta de valor específica.

## 5. REESCRITA DE MOMENTOS CRÍTICOS

### Momento 1 - Abertura
**Original:** "Muito boa noite para todo mundo... eu me chamo Evelyn, hoje faço parte do time da System"
**Reescrita:** "Antes de começarmos, preciso entender: quantos aqui faturam menos de 100k por mês e sabem que poderiam estar ganhando mais? Levantem a mão ou escrevam no chat"
**Por quê:** Qualifica imediatamente os participantes e identifica o gap entre situação atual e desejada

### Momento 2 - Frame Inicial  
**Original:** "só existe uma profissão no mundo e é a venda"
**Reescrita:** "Médicos excelentes estão fechando consultórios enquanto outros medianos faturam milhões. A diferença? Os que faturam milhões dominaram a única habilidade que não ensinam na faculdade: comunicação persuasiva"
**Por quê:** Cria contraste emocional e urgência, conectando diretamente com a dor do público

### Momento 3 - Momento de Diagnóstico
**Original:** "às vezes a gente olha por fora e pensa, poxa, mas por que fulano de tal vende tanto"
**Reescrita:** "Me digam no chat: quanto vocês perderam no último mês por não saber se comunicar adequadamente com diferentes perfis de pacientes? Quanto isso representa em reais?"
**Por quê:** Quantifica a dor e torna o problema tangível em valores financeiros

### Momento 4 - Ensino sem Aplicação
**Original:** [Explicou todo o conteúdo de DISC sem aplicação prática]
**Reescrita:** "Agora que entenderam os perfis, quero que façam um exercício: pensem no último paciente que não fechou. Qual perfil ele era e como vocês deveriam ter abordado diferente?"
**Por quê:** Transforma conhecimento teórico em aplicação prática imediata

### Momento 5 - Encerramento
**Original:** "qualquer dúvida, a gente está à disposição ali nos grupos"
**Reescrita:** "Quem quer descobrir exatamente como dobrar o fechamento usando essas técnicas nos próximos 30 dias? Temos 5 vagas para uma masterclass exclusiva amanhã às 20h. Link nos comentários"
**Por quê:** Cria urgência, escassez e call-to-action específico para conversão

## 6. PLANO DE AÇÃO 30 DIAS

### Ação 1: Implementar Estrutura de Qualificação
**O que fazer:** Criar roteiro de 5 perguntas para identificar perfil e dor dos participantes nos primeiros 10 minutos
**Por que:** Permitir personalização da apresentação e identificação de prospects
**Como treinar:** Role-play diário com perguntas de qualificação por 1 semana
**Prioridade:** Alta

### Ação 2: Desenvolver Framework de Vendas Consultivas
**O que fazer:** Estruturar apresentações educacionais com momentos de diagnóstico e fechamento
**Por que:** Transformar tutorias em máquinas de conversão
**Como treinar:** Estudar 2 calls de alta conversão por semana e adaptar estrutura
**Prioridade:** Alta

### Ação 3: Criar Sistema de Follow-up Estruturado
**O que fazer:** Implementar sequência de follow-up para participantes qualificados
**Por que:** Maximizar conversões pós-apresentação
**Como treinar:** Desenvolver scripts específicos por perfil identificado
**Prioridade:** Média

### Ação 4: Implementar Técnicas de Ancoragem
**O que fazer:** Incluir âncoras de preço e valor durante as apresentações educacionais
**Por que:** Preparar terreno para futuras propostas comerciais
**Como treinar:** Praticar ancoragem sutil em conversas cotidianas
**Prioridade:** Média

### Ação 5: Desenvolver Promessas Específicas e Mensuráveis
**O que fazer:** Substituir promessas vagas por resultados quantificáveis e prazo determinado
**Por que:** Aumentar credibilidade e urgência
**Como treinar:** Lista 10 resultados específicos que pode entregar com prazos definidos
**Prioridade:** Baixa

## 7. ANÁLISE DE SENTIMENTO DO LEAD

**Overall:** Positivo  
**Score:** 0.7  
**Engagement Level:** Alto  

### Timeline do Sentimento:
- **Início (0-10min):** Neutro/Positivo - Chegada dos participantes, apresentação inicial
- **Desenvolvimento (10-30min):** Positivo - Engajamento com conteúdo sobre temperamentos  
- **Meio (30-60min):** Muito Positivo - Interação ativa, perguntas sobre perfis
- **Final (60-88min):** Positivo/Declinante - Cansaço natural, mas manteve interesse
- **Encerramento:** Positivo - Agradecimentos e satisfação com conteúdo

### Objections Identificadas:
- **Tipo:** Ceticismo - "não gosto de vender"
- **Handled:** Parcialmente - Evelyn abordou superficialmente: "não é o vender, é se relacionar"

A audiência manteve-se engajada durante toda a apresentação, demonstrando interesse genuíno no conteúdo educacional, mas não foi direcionada para ação comercial específica.', '🔴 AUDITORIA: Evelyn x Tutoria Gravada (Drive)
📅 2026-03-24 | ⏱ 88min
📊 Score: 2.9/10 — FRACA

✅ Top Acertos:
1. Domínio do Conteúdo Técnico
2. Uso de Exemplos Práticos
3. Engajamento da Audiência

❌ Top Erros:
1. Ausência de Qualificação
2. Falta de Estrutura de Vendas
3. Não Criou Urgência ou Escassez', '[{"rank": 1, "title": "Ausência de Qualificação", "description": "Não identificou quem são os participantes, suas dores específicas ou necessidades comerciais, perdendo oportunidades de conversão"}, {"rank": 2, "title": "Falta de Estrutura de Vendas", "description": "Apresentação puramente educacional sem direcionamento comercial, resultando em zero conversões diretas"}, {"rank": 3, "title": "Não Criou Urgência ou Escassez", "description": "Terminou apenas com disponibilidade genérica nos grupos, sem call-to-action específico"}, {"rank": 4, "title": "Proporção de Fala Inadequada", "description": "Falou 95% do tempo sem descobrir necessidades individuais dos participantes"}, {"rank": 5, "title": "Ausência de Diagnóstico Quantitativo", "description": "Não explorou números, faturamento atual ou metas, impossibilitando proposta de valor específica"}]'::jsonb, '[{"rank": 1, "title": "Domínio do Conteúdo Técnico", "description": "Demonstrou conhecimento profundo sobre temperamentos e DISC com referências históricas precisas"}, {"rank": 2, "title": "Uso de Exemplos Práticos", "description": "Utilizou referências conhecidas como Bill Gates e Angelina Jolie para ilustrar conceitos"}, {"rank": 3, "title": "Engajamento da Audiência", "description": "Criou momentos de interação pedindo para identificarem seu perfil no chat"}, {"rank": 4, "title": "Autoexposição Estratégica", "description": "Usou sua própria experiência como case de perfil treinado"}, {"rank": 5, "title": "Conexão com Público-Alvo", "description": "Fez conexões diretas com realidade de médicos e cirurgiões"}]'::jsonb, '[{"rank": 1, "title": "Implementar Estrutura de Qualificação", "por_que": "Permitir personalização da apresentação e identificação de prospects", "prioridade": "alta", "o_que_fazer": "Criar roteiro de 5 perguntas para identificar perfil e dor dos participantes nos primeiros 10 minutos", "como_treinar": "Role-play diário com perguntas de qualificação por 1 semana"}, {"rank": 2, "title": "Desenvolver Framework de Vendas Consultivas", "por_que": "Transformar tutorias em máquinas de conversão", "prioridade": "alta", "o_que_fazer": "Estruturar apresentações educacionais com momentos de diagnóstico e fechamento", "como_treinar": "Estudar 2 calls de alta conversão por semana e adaptar estrutura"}, {"rank": 3, "title": "Criar Sistema de Follow-up Estruturado", "por_que": "Maximizar conversões pós-apresentação", "prioridade": "média", "o_que_fazer": "Implementar sequência de follow-up para participantes qualificados", "como_treinar": "Desenvolver scripts específicos por perfil identificado"}, {"rank": 4, "title": "Implementar Técnicas de Ancoragem", "por_que": "Preparar terreno para futuras propostas comerciais", "prioridade": "média", "o_que_fazer": "Incluir âncoras de preço e valor durante as apresentações educacionais", "como_treinar": "Praticar ancoragem sutil em conversas cotidianas"}]'::jsonb, '[]'::jsonb, '[{"impact": "Permite personalização da apresentação e identificação de prospects qualificados", "reason": "Qualifica imediatamente os participantes e identifica gap entre situação atual e desejada", "original": "Muito boa noite para todo mundo... eu me chamo Evelyn, hoje faço parte do time da System", "rewritten": "Antes de começarmos, preciso entender: quantos aqui faturam menos de 100k por mês e sabem que poderiam estar ganhando mais?", "description": "Abertura da apresentação"}, {"impact": "Aumenta relevância e cria necessidade de mudança", "reason": "Cria contraste emocional e urgência conectando com a dor do público", "original": "só existe uma profissão no mundo e é a venda", "rewritten": "Médicos excelentes estão fechando consultórios enquanto outros medianos faturam milhões. A diferença? Os que faturam milhões dominaram a única habilidade que não ensinam na faculdade", "description": "Frame inicial sobre vendas"}, {"impact": "Cria urgência financeira e justifica investimento em solução", "reason": "Quantifica a dor e torna o problema tangível em valores financeiros", "original": "às vezes a gente olha por fora e pensa, poxa, mas por que fulano de tal vende tanto", "rewritten": "Me digam no chat: quanto vocês perderam no último mês por não saber se comunicar adequadamente com diferentes perfis de pacientes?", "description": "Momento de diagnóstico"}, {"impact": "Transforma participantes em prospects qualificados com próxima etapa definida", "reason": "Cria urgência, escassez e call-to-action específico para conversão", "original": "qualquer dúvida, a gente está à disposição ali nos grupos", "rewritten": "Quem quer descobrir exatamente como dobrar o fechamento usando essas técnicas nos próximos 30 dias? Temos 5 vagas para masterclass exclusiva amanhã às 20h", "description": "Encerramento"}]'::jsonb, '{}'::jsonb, '[]'::jsonb, 'drive://1N4XHEu7WtulZp56ryabtn9RbXqhbxwA9', NULL, '1N4XHEu7WtulZp56ryabtn9RbXqhbxwA9', NULL, NULL, 'whisper-1', 'claude-sonnet-4-20250514', 19278, 4746, 0.129, '2026-03-25T10:07:23.191332+00:00', NULL, '2026-03-28T17:25:27.468+00:00', '2026-03-28T17:30:54.513282+00:00', '2026-03-28T17:30:54.513282+00:00', '2026-03-25T10:07:23.191332+00:00', '2026-03-28T17:30:54.513282+00:00', 'positive', '[{"moment": "Chegada dos participantes, apresentação inicial", "period": "Início", "sentiment": "neutro", "confidence": 0.8}, {"moment": "Engajamento com conteúdo sobre temperamentos", "period": "Desenvolvimento", "sentiment": "positivo", "confidence": 0.9}, {"moment": "Interação ativa, perguntas sobre perfis", "period": "Meio", "sentiment": "muito positivo", "confidence": 0.9}, {"moment": "Cansaço natural, mas manteve interesse", "period": "Final", "sentiment": "positivo", "confidence": 0.7}, {"moment": "Agradecimentos e satisfação com conteúdo", "period": "Encerramento", "sentiment": "positivo", "confidence": 0.8}]'::jsonb, 0.7, 'high', '[{"text": "não gosto de vender", "type": "confiança", "handled": false}]'::jsonb, '2.0', '526ab851a1c713e2', '2803799a-e97b-48f1-a144-078cf8a66124/auditoria_2026-03-24_tutoria-gravada-drive.md');

INSERT INTO call_audits (id, organization_id, closer_id, lead_name, call_date, duration_minutes, resultado, valor_fechamento, status, error_message, score_final, classificacao, d01_frame, d02_qualificacao, d03_diag_quantitativo, d04_diag_qualitativo, d05_consequencia, d06_ensino, d07_identidade, d08_ancoragem, d09_isolamento, d10_proporcao_fala, d11_promessas, d12_checkpoints, d13_fechamento, transcricao, relatorio_completo, resumo_whatsapp, top_erros, top_acertos, plano_acao, frases_proibidas, reescrita_falas, mapa_frameworks, fases_analise, audio_path, audio_duration_seconds, drive_file_id, drive_url, drive_report_url, modelo_transcricao, modelo_analise, tokens_input, tokens_output, custo_estimado, uploaded_at, transcribed_at, analyzed_at, notified_at, completed_at, created_at, updated_at, sentiment_overall, sentiment_timeline, sentiment_score, engagement_level, objections_detected, prompt_version, report_hash, storage_report_path) VALUES
('94f54fba-e9e5-4756-9d2f-83af7e1d7a73', '4ecd8f2d-d0c5-419c-a5bc-b2e94dca0465', '171a0543-1dde-4ba4-99f8-d396c6832b60', 'Marcos', '2026-03-13', 60, NULL, NULL, 'completed', NULL, 3.0, 'FRACA', 3.0, 2.0, 5.0, 6.0, 1.0, 3.0, 2.0, 4.0, 1.0, 2.0, 3.0, 4.0, 2.0, '13 de mar. de 2026

## Auditoria Comercial \- Marcos  \- Transcrição

### 00:00:00

   
**Dr Marcos Gesuele:** Olá,  
**Evelyn La:** Olá, Marcos.  
**Dr Marcos Gesuele:** tudo bem? Tá me vendo aí?  
**Evelyn La:** Tô te  
**Dr Marcos Gesuele:** Tá que eu tô dirigindo.  
**Evelyn La:** vendo.  
**Dr Marcos Gesuele:** Eu vou participar da reunião direto do carro porque não deu tempo de chegar em casa.  
**Evelyn La:** Certo. E a Rosana  
**Rosana Mara Dias de Oliveira Elias:** aqui.  
**Dr Marcos Gesuele:** Acho que se não entrou entrar.  
**Evelyn La:** tá me ouvindo, Rosana?  
**Rosana Mara Dias de Oliveira Elias:** Estão me ouvindo?  
**Dr Marcos Gesuele:** Não,  
**Rosana Mara Dias de Oliveira Elias:** Tô, tô sim, vi. Daqui a pouco eu abro minha  
**Dr Marcos Gesuele:** mas o seu tá dando dando um choque  
**Rosana Mara Dias de Oliveira Elias:** câmera.  
**Dr Marcos Gesuele:** aí.  
**Evelyn La:** Vai ter mais alguém que vai participar com a gente?  
**Dr Marcos Gesuele:** O Luca, o Luca tá aí.  
**Rosana Mara Dias de Oliveira Elias:** Tá, tá sim. Deixa eu ver que eu tô em outro, eu tô em outro lugar. Pera aí.  
**Dr Marcos Gesuele:** Tá, o seu som tá horrível. E aí,  
**Rosana Mara Dias de Oliveira Elias:** Gente, só um pouquinho. Luca tá entrando também.  
   
 

### 00:01:39

   
**Dr Marcos Gesuele:** R?  
**Rosana Mara Dias de Oliveira Elias:** Luca tá entrando também. Só um  
**Evelyn La:** Tranquilo.  
**Rosana Mara Dias de Oliveira Elias:** minutinho. Ai ai.  
**Dr Marcos Gesuele:** Meu Deus, que enrolação. Evelin, vamos tocar o barco. Vai,  
**Evelyn La:** Acho que o é Luca tá tá pedindo aqui para entrar.  
**Dr Marcos Gesuele:** toca.  
**Evelyn La:** Pera aí, deixa eu liberar aí. Aí, agora sim. Todos  
**Dr Marcos Gesuele:** E aí, Lu? Beleza?  
**lucca elias:** Opa.  
**Evelyn La:** aqui.  
**Dr Marcos Gesuele:** Tá bom. E a mãe? A mãe tá com o som? Tá ruim. O som da mãe tá  
**lucca elias:** É que ela tá no  
**Rosana Mara Dias de Oliveira Elias:** Não,  
**Dr Marcos Gesuele:** ruim.  
**Rosana Mara Dias de Oliveira Elias:** eu já tirei, eu já tirei do Wi-Fi e eu tô no fone, mas eu tô vou começar ouvindo aqui,  
**lucca elias:** fone.  
**Rosana Mara Dias de Oliveira Elias:** tá bom?  
**Evelyn La:** Tá ouvindo?  
**Rosana Mara Dias de Oliveira Elias:** Já, já eu entro com na câmera. Tô ouvindo bem.  
   
 

### 00:03:04

   
**Evelyn La:** Tá certo.  
**Rosana Mara Dias de Oliveira Elias:** Á.  
**Dr Marcos Gesuele:** Evely a dificuldade  
**Evelyn La:** Imagina, imagina. Pessoal, deixa eu me apresentar rapidinho.  
**Dr Marcos Gesuele:** aí  
**Evelyn La:** Sou a Evelyn. Faço parte aqui do time da System. E aqui nós estamos com uma família. Então é isso. Vocês são da onde,  
**Dr Marcos Gesuele:** e o mais bonito e o mais inteligente é o pai.  
**Evelyn La:** pessoal?  
**Dr Marcos Gesuele:** O resto é consequência.  
**Evelyn La:** Bom, mas é isso é importante, né? Temos que que é a base, a raiz e o resto.  
**Dr Marcos Gesuele:** Aí,  
**Evelyn La:** Isso aí.  
**Dr Marcos Gesuele:** a propaganda é a alma do  
**Evelyn La:** Com certeza. Com certeza.  
**Dr Marcos Gesuele:** negócio.  
**Evelyn La:** Vocês são da onde?  
**Dr Marcos Gesuele:** São Paulo.  
**Evelyn La:** São Paulo,  
**lucca elias:** E  
**Dr Marcos Gesuele:** São Paulo.  
**Evelyn La:** capital mesmo.  
**Dr Marcos Gesuele:** Isso. Capital.  
**Evelyn La:** Eu falo de Cascavel,  
**Dr Marcos Gesuele:** Você fala de onde?  
**Evelyn La:** Paraná.  
**Dr Marcos Gesuele:** Cascavel.  
**Evelyn La:** Isso.  
**Dr Marcos Gesuele:** Tá.  
**Evelyn La:** A empresa em si tem escritório físico em Floripa, né? A metade da equipe fica presencial, metade home office.  
   
 

### 00:04:03

   
**Evelyn La:** Eu faço parte dos home office.  
**Dr Marcos Gesuele:** Perfetto.  
**Evelyn La:** Muito bom, pessoal. O Gustavo me passou um pouquinho do briefing de vocês ali, né? E eu gosto sempre de deixar bem claro que hoje eu tô aqui para ajudar vocês. A gente vai, né, vou conhecer um pouquinho aí da tanto da parte de clínica, parte de como que tá a rotina de vocês, enfim. Eh, a nossa intenção é sempre buscar uma solução que possa encaixar e ajude, é claro, nesse momento, mas claro, eu preciso também fazer algumas análises, entender se de fato vocês estão no momento de estar no nosso ecossistema, né? senão não faz sentido eh a gente querer encaixar qualquer coisa, mas eu vendo que faça sentido, aí a gente dá sequência e aí a gente fala um pouquinho mais sobre soluções, questões específicas da empresa em si, método, né? Tá  
**Dr Marcos Gesuele:** Perfeito.  
**Evelyn La:** bem,  
**Dr Marcos Gesuele:** Me dá um, me dá passa um briefzinho da sua empresa, só pro pessoal saber o que que você  
**Evelyn La:** claro.  
**Dr Marcos Gesuele:** faz.  
**Evelyn La:** A Cistem hoje ela tem o foco em trabalhar duas frentes importantes para qualquer cirurgião de face hoje, qualquer um que tenha realmente clínica, enfim. Ah, nós trabalhamos com a gerar a demanda qualificada e fazer a estruturação comercial para que essa demanda seja de fato muito bem aproveitada e convertida, né?  
   
 

### 00:05:33

   
**Evelyn La:** Ou seja, gerada em venda. Nós somos uma empresa hoje que a gente não é uma agência de tráfego pago e nem mentoria. Nós trabalhamos como um parceiro da clínica. No qual sentido? Nós desenhamos estratégias, eh, nós já temos algumas, inclusive estratégias validadas da parte comercial para que sejam implantadas na clínica e que, de fato, isso venha a gerar resultado quanto antes. Ah, Evelyn, isso serve para todo mundo? Não, por isso que é realizado o diagnóstico para eu entender como que tá o momento da clínica, o momento do cirurgião, de fato, entender se o que nós temos como implementação hoje de metodologia faz sentido pro momento que o cirurgião está. Não é nem pelo fato de, ah, é para ele ou não é, não. É pela questão do momento. Existem aqueles que estão realmente no momento de fazer e dar esse passo, outros que não. Por quê? Porque é uma metodologia que eh não é mamão com açúcar, como disse minha avó, rapadura é doce, mas não é mole, né? Então é trabalhoso, é trabalhoso. É eh tem algumas etapas ali do processo que a gente precisa realmente assim um comprometimento também do outro lado, porque senão não gera o resultado esperado.  
   
 

### 00:06:59

   
**Evelyn La:** E a gente não gosta aí de, né? poxa, investimentos tem que gerar ROI, seja ele de R$ 10, seja ele de R.000,  
**Dr Marcos Gesuele:** Sì.  
**Evelyn La:** seja ele tem que gerar ROI, né? E aí a gente busca muito avaliar, entender isso, porque vai influenciar também, né?  
**Dr Marcos Gesuele:** Perfetto.  
**Evelyn La:** Mas a gente trabalha como parceiro dentro dos nossos eh eh dentro do que a gente trabalha como método, nós fazemos o tráfego pago também. Ele está incluso. É um serviço que ele está incluso, mas o nosso foco não é tráfego pago. Então não, por isso que a gente diz sempre, né? Não somos agência. Por quê? Porque a gente busca não só o tráfego pago, a gente busca com foco maior nas estratégias e na estruturação comercial, porque é daí que vai trazer a previsibilidade da da venda em si, né? Não, só o tráfego pago ali, gerando leo, volume e às vezes sem conversão.  
**Dr Marcos Gesuele:** Certo,  
**Evelyn La:** Certo?  
**Dr Marcos Gesuele:** perfeito. Então vamos lá. Agora,  
**Evelyn La:** Vamos lá.  
**Dr Marcos Gesuele:** agora é o, agora é só a nossa vez.  
**Evelyn La:** Isso.  
   
 

### 00:08:10

   
**Dr Marcos Gesuele:** Pode perguntar.  
**Evelyn La:** Queria que vocês me falassem um pouquinho brevemente aí como que é hoje a clínica, como que vocês têm atuado. Não sei se vocês têm clínica, vocês têm consultório, como que é isso? Todos trabalham juntos.  
**Dr Marcos Gesuele:** Trabalhamos todos, na realidade,  
**lucca elias:** Sim.  
**Dr Marcos Gesuele:** o consultório é do Luca, né?  
**Evelyn La:** Ah,  
**Dr Marcos Gesuele:** Eu atendo em na no Anália Franco,  
**Evelyn La:** legal.  
**Dr Marcos Gesuele:** atendo no Tatuapé, atendo na Vila Mariana, trabalhos que eu faço na área de ortopedia funcional dos maxilares.  
**Evelyn La:** Aham.  
**Dr Marcos Gesuele:** Eh,  
**Evelyn La:** Aham.  
**Dr Marcos Gesuele:** consultório é um consultório hoje focado em reabilitação em prótese, reabilitação de carga imediata, cirurgia de carga imediata, onde o paciente chega de manhã eh com a boca toda desmontada,  
**Evelyn La:** Угуm.  
**Dr Marcos Gesuele:** a gente termina de desmontar, faz os implantes e já coloca a prótese no mesmo dia. Então, a nossa o nosso foco hoje é esse, o nosso forte. Aí eu fiz o curso o ano passado,  
**Evelyn La:** Ага.  
**Dr Marcos Gesuele:** eh, no mês de outubro. Outubro é, acho que foi outubro para novembro, eu fiz um curso de cirurgia eh da face, de estética da face,  
   
 

### 00:09:27

   
**Evelyn La:** Legal.  
**Dr Marcos Gesuele:** fizá e resolvi que eu que eu quero investir, queria investir naquela época nisso daí.  
**Evelyn La:** Certo.  
**Dr Marcos Gesuele:** Só que tenho noal na área, eu não tenho nenhum conhecimento. O consultório é um consultório que tem cerca de 30 anos de trabalho, né? A clínica odontológica Jesuele, que começou comigo, passou agora a há 5 anos, o meu filho se tornou sócio, agora ele é dono exclusivo da da clínica. Eh, e a minha esposa, a Rosana, que tá aí, ela faz a parte administrativa, mas ela também está se formando em odontologia e o nosso foco é cirurgia, só que eu não sei fazer, não sei como trazer o  
**Evelyn La:** Entendi.  
**Dr Marcos Gesuele:** paciente.  
**Evelyn La:** Hoje vocês dependem mais do que para fazer gerar indicação. Não. Bom,  
**Dr Marcos Gesuele:** acabou com a indicação, mas como eu não tenho eu não tenho eh eh não tenho um um moststruário de de pacientes, né? Não tenho eh expertise nisso, isso é bastante difícil. Então, minha ideia era começar com pacientes eh modelo para eu formar um um um é criar minha identidade na  
**Evelyn La:** alguns cases, né?  
**Dr Marcos Gesuele:** área, né? Apesar de eu ter 36 anos de  
   
 

### 00:10:47

   
**Evelyn La:** Sim, sim.  
**Dr Marcos Gesuele:** formado,  
**Evelyn La:** Mas a questões das cirurgias da face é recente, né, que você comentou.  
**Dr Marcos Gesuele:** novo para mim é tudo novo,  
**Evelyn La:** Uhum. E o Luca fica também nos implantes. Luca,  
**Dr Marcos Gesuele:** tá?  
**Evelyn La:** como que é?  
**lucca elias:** Eu fico mais na parte de prótese, né? Eu eu que cuido da parte de trazer a estética final pro pros pacientes.  
**Evelyn La:** Ah, que legal. Muito bom.  
**lucca elias:** Parte dois do de onde vai onde vai cada coisa, né?  
**Evelyn La:** Uhum. Show de bola. É um brzão que tem atrás de ti aí.  
**lucca elias:** É, é um  
**Evelyn La:** Gostei.  
**Dr Marcos Gesuele:** É o brasão da  
**lucca elias:** brzão.  
**Evelyn La:** Ah, é.  
**Dr Marcos Gesuele:** nossa  
**Evelyn La:** Eu tenho um também da minha. Que legal.  
**Dr Marcos Gesuele:** Brasão da família Jesuele.  
**Evelyn La:** Jesu Jesu é o quê?  
**Dr Marcos Gesuele:** Foi, foi estudado.  
**Evelyn La:** É italiano,  
**Dr Marcos Gesuele:** Ele é italiano,  
**lucca elias:** Itália.  
**Evelyn La:** né? O meu é L. O meu é Lampugnane.  
**Dr Marcos Gesuele:** era da mar.  
**Evelyn La:** Nós é tudo da máfia.  
   
 

### 00:11:40

   
**Evelyn La:** Então,  
**Dr Marcos Gesuele:** É, você, a sua família é de qual parte da Itália?  
**Evelyn La:** é do lado de Milão ali de como que é o nome daquela cidade? L é ler alguma coisa.  
**Dr Marcos Gesuele:** Ah, não.  
**Evelyn La:** Nossa.  
**Dr Marcos Gesuele:** Eh, a minha sobrinha inclusive está morando em Milão, foi para lá no final desse ano. O meu, a minha família é mais calabres, é um povo mais nervosinho,  
**Evelyn La:** Aham.  
**Dr Marcos Gesuele:** né?  
**Evelyn La:** Ah, eu tinha o nome da cidade aqui direto. O pessoal às vezes me pergunta, eu sempre esqueço o nome da cidade, mas lá na Itália eles chamam lampunhao, né? Aqui brasileiraram e colocaram lampugnan, mas nós somos todos lampunha na  
**Dr Marcos Gesuele:** Lampunhano, nome  
**Evelyn La:** Itália.  
**Dr Marcos Gesuele:** muito,  
**lucca elias:** Oi. Cortou, pai.  
**Evelyn La:** É.  
**Dr Marcos Gesuele:** é um nome muito bonito.  
**Evelyn La:** Ah,  
**Dr Marcos Gesuele:** Falei meu nome bem  
**Evelyn La:** obrigada. É bem italiano,  
**Dr Marcos Gesuele:** italiano,  
**Evelyn La:** né? É o meu, eu por relaxo não,  
**Dr Marcos Gesuele:** Belice  
**Evelyn La:** eu por relaxo não,  
**lucca elias:** M.  
**Evelyn La:** não aprendi a fluência do italiano.  
   
 

### 00:12:55

   
**Dr Marcos Gesuele:** são dois.  
**Evelyn La:** Meu vô fala ainda muito bem, mas eu por relaxa aí,  
**Dr Marcos Gesuele:** Eu vou vender tanta cirurgia da face que eu vou vou fazer um curso  
**Evelyn La:** ó. Eh,  
**Dr Marcos Gesuele:** de italiano.  
**Evelyn La:** eu eu falo que eu ainda vou fazer um também, mas que bacana, pessoal. Eh,  
**Dr Marcos Gesuele:** Legal.  
**Evelyn La:** tem bastante no aí, né, como o Marcos falou. E então iniciando agora então nessa, querendo ou não, essa nova estruturação aí, né, que fizeram, deu certo até agora, mas para próxima jornada precisamos mexer alguns parafusos,  
**Dr Marcos Gesuele:** Isso  
**Evelyn La:** quem sabe, né? Vamos lá. Ah,  
**Dr Marcos Gesuele:** tá  
**Evelyn La:** a Rosana que cuida do atendimento com os pacientes, como que é? Você  
**Dr Marcos Gesuele:** responde aí, R ela sim.  
**Rosana Mara Dias de Oliveira Elias:** Sim, sou eu. Sou eu, eu que cuido,  
**Evelyn La:** que faz  
**Rosana Mara Dias de Oliveira Elias:** eu que faço atendimento geral,  
**Evelyn La:** toda  
**Rosana Mara Dias de Oliveira Elias:** faço fechamento, faço cobrança. Toda a parte ADM financeira é comigo.  
**Evelyn La:** show a venda e a pré-venda ali contigo também, então.  
**Rosana Mara Dias de Oliveira Elias:** Sim, sim.  
   
 

### 00:14:05

   
**Rosana Mara Dias de Oliveira Elias:** É, hoje a gente é bem enxuto, né? Então eu que assumo essa parte.  
**Evelyn La:** Sim. Legal. Deixa eu te perguntar, Rô. Você, ó, eu já tô chamando você de Rô aí, ó. Tenho esse esse pequeno  
**Rosana Mara Dias de Oliveira Elias:** Sem problema, sem  
**Evelyn La:** pessoal.  
**Rosana Mara Dias de Oliveira Elias:** problema.  
**Evelyn La:** Você tem algum processo nessa parte de abordagens e coisas referente à parte comercial em si mesmo com o cliente ali?  
**Rosana Mara Dias de Oliveira Elias:** Hum. Ah, é um processo meu, assim, eu não sigo nada, mas é um processo que eu que eu tenho assim da minha vivência na área,  
**Evelyn La:** Угуm.  
**Rosana Mara Dias de Oliveira Elias:** né? Sempre trabalhei na área dele. Então, assim, eu não tenho, hoje em dia, eu digo que vocês são mais cent, quem trabalha com isso é mais centrado, né? tem algumas alguns scripts formados e tal, até mesmo para poder passar isso pro pro pra equipe. Eu não tenho não. Eu vou conforme eu sinto a necessidade.  
**Evelyn La:** E  
**Rosana Mara Dias de Oliveira Elias:** Eu não sou eu não sou muito eh voraz na venda.  
   
 

### 00:15:17

   
**Rosana Mara Dias de Oliveira Elias:** Tem gente que é muito voraz, né? Que venda, venda, venda, venda. Não, eu vou, eu sou mais sutil, delicada. E essas as pessoas se sentem mais tranquilas. confiam. Enfim,  
**Evelyn La:** sim,  
**Rosana Mara Dias de Oliveira Elias:** então eu acabo por conta disso.  
**Evelyn La:** Mas é importante. Uhum. Hum. Não, mas esse é um ponto muito muito positivo, na verdade, essa sutileza, né, eh, de você realmente trazer o paciente mais para perto, ele se sentir um pouco mais até mesmo seguro por conta da sutileza aí de você fazer o atendimento. Eu te questionei só referente à questão de processos para entender de fato se você tem essa essas abordagens específicas para quando é um primeiro atendimento, por exemplo, se é alguém que já é recorrente ou um ex-paciente, por exemplo, que às vezes tá sendo reaquecido,  
**Dr Marcos Gesuele:** Так.  
**Evelyn La:** que a gente diz, né?  
**Rosana Mara Dias de Oliveira Elias:** Aham. Aham. Sim, sim. É, eu não tenho assim essa metodologia, tá?  
   
 

### 00:16:16

   
**Rosana Mara Dias de Oliveira Elias:** Não trabalho desse jeito.  
**Evelyn La:** Uhum.  
**Rosana Mara Dias de Oliveira Elias:** Talvez vocês escutem meu cachorro latir, tá? Mas é não consigo segurar  
**Evelyn La:** Tranquilo, imagina. Tranquilo.  
**Rosana Mara Dias de Oliveira Elias:** isso.  
**Evelyn La:** Certo. Entendi. E aí, então a Rô faz toda a parte de atendimento, negociação e joga e toca pro Luca. É  
**Rosana Mara Dias de Oliveira Elias:** Aham.  
**Evelyn La:** isso.  
**Rosana Mara Dias de Oliveira Elias:** Isso. Exato. Exatamente. O eles fazem a avaliação. Vou te falar como é que é. Eles fazem avaliação. A avaliação, a venda é praticamente feita dentro do consultório,  
**Evelyn La:** Uhum.  
**Rosana Mara Dias de Oliveira Elias:** né? Eh, depois que vem feita, o que eu o que eu faço é o fechamento.  
**Evelyn La:** Угу.  
**Rosana Mara Dias de Oliveira Elias:** Eu viabilizo a pessoa de adquirir o serviço que ela tá desejando, né? Então, então assim, o parcelamento, forma, as formas de pagamento, na verdade, se vai ter desconto, não vai.  
   
 

### 00:17:08

   
**Rosana Mara Dias de Oliveira Elias:** E aí eu fico tentando entender qual que é o problema da pessoa, qual que é a dificuldade que ela tá tendo de não fechar no primeiro momento para tentar ajudar de alguma forma que possível aí melhorar e etc e tal,  
**Evelyn La:** Entendi. Certo.  
**Rosana Mara Dias de Oliveira Elias:** entendeu?  
**Evelyn La:** Bom, entendi. Deixa eu colocar aqui. E hoje vocês então só dependem exatamente da indicação. A tráfego pago não tem feito. Já fizeram alguma vez?  
**Rosana Mara Dias de Oliveira Elias:** Já fizemos,  
**Evelyn La:** Que que vocês sentiram do trabalho  
**Rosana Mara Dias de Oliveira Elias:** não deu certo.  
**Evelyn La:** contrári?  
**Rosana Mara Dias de Oliveira Elias:** A gente não não gostei. Fiquei três meses com a agência e recendi o contrato.  
**Evelyn La:** Certo.  
**Rosana Mara Dias de Oliveira Elias:** Veio de desqualificado. é muito distante da minha região, eh poder aquisitivo muito abaixo daquilo que a gente pratica. Eh, então assim, a gente não gostou do do Não sei se se eu posso chamar de tipo  
**Dr Marcos Gesuele:** M.  
**Evelyn La:** Sim,  
**Rosana Mara Dias de Oliveira Elias:** de serviço prestado ou é,  
**Evelyn La:** sim. Uhum.  
**Rosana Mara Dias de Oliveira Elias:** então pra gente não deu certo.  
   
 

### 00:18:25

   
**Rosana Mara Dias de Oliveira Elias:** Gente, não deu  
**Evelyn La:** Entendi. Provavelmente eh foi feito um trabalho fora do ICP de vocês que a gente diz que  
**Rosana Mara Dias de Oliveira Elias:** certo.  
**Evelyn La:** é a matriz ICP, ela serve é um como se fosse um estudo de fato, um mapeamento prévio para se fazer depois pago. Éonde a gente busca realmente entender o ICP, o perfil do cliente ideal. Então, provavelmente a agência não deve ter feito isso antes e lançou sua campanha aleatória,  
**Rosana Mara Dias de Oliveira Elias:** Uhum.  
**Evelyn La:** né? E aí acontece o resultado normalmente de trazer até bastante volume, mas sem qualificação.  
**Rosana Mara Dias de Oliveira Elias:** Sim.  
**Evelyn La:** Uhum.  
**Rosana Mara Dias de Oliveira Elias:** É, exatamente. E aí, e os poucos que agendavam ainda faltavam,  
**Evelyn La:** Não compareceu.  
**Rosana Mara Dias de Oliveira Elias:** mesmo a gente confirmando um dia antes, tal,  
**Evelyn La:** Hum.  
**Rosana Mara Dias de Oliveira Elias:** faltavam.  
**Evelyn La:** Hum. Ah, não. Aí, aí é complicado mesmo. Fora essa vez, teve alguma outra que vocês chegaram a investir, que chegar a fazer?  
**Rosana Mara Dias de Oliveira Elias:** de tráfego pago, a gente investiu duas vezes e as duas vezes a gente teve o mesmo  
   
 

### 00:19:31

   
**Evelyn La:** Certo?  
**Rosana Mara Dias de Oliveira Elias:** problema.  
**Evelyn La:** Entendi. Então, nem dá para contar aí que  
**Rosana Mara Dias de Oliveira Elias:** É, a nossa experiência não foi muito  
**Evelyn La:** Uhum. Sim, sim. Mas é o que acontece com a maioria das agências, viu?  
**Rosana Mara Dias de Oliveira Elias:** boa.  
**Evelyn La:** Olha, eu converso com tantas, tantos cirurgiões aqui descontentes, eh, com essa questão de agência que já tá cansado, porque uma promete, outra promete, outra não sei o quê, e aí vai e acaba entrando na mesma roda, né? Mas é por conta disso,  
**Rosana Mara Dias de Oliveira Elias:** Eh,  
**Evelyn La:** a maioria eh como eles precisam entregar volume, eles precisam eh mostrar serviço, vamos colocar aqui, entre aspas, eles focam muito nessa entrega só de lead, mas sem muita preocupação com qualificação, né? Aí é um aí é um grande gargalo que se forma,  
**Rosana Mara Dias de Oliveira Elias:** Uhum.  
**Evelyn La:** na verdade, na operação desse cirurgião. Certo? Tô fazendo só algumas anotações,  
**Rosana Mara Dias de Oliveira Elias:** Sim.  
**Evelyn La:** tá? Por isso que eu tô tô olhando para baixo aqui,  
**Rosana Mara Dias de Oliveira Elias:** Perfeito.  
**Evelyn La:** só para poder entender aqui um pouquinho mais.  
   
 

### 00:20:36

   
**Evelyn La:** Uhum. E vamos lá. Me diz uma coisa aí com a vinda agora do Marcos mais para essa área de cirurgias da face, o Luca que já domina aí essa parte de implantes, o que que vocês têm como objetivo para esse ano? Poxa, tô faturando X, quero chegar a Y, quero aumentar, sei lá, porcentagem de cirurgias, que que vocês estão almejando aí para esse ano 2026 da no  
**Dr Marcos Gesuele:** O objetivo,  
**Evelyn La:** consultório?  
**Dr Marcos Gesuele:** o nosso objetivo com a cirurgia da face é diminuir a clínica, né? Porque a clínica é dá muito gasto, dá muito trabalho e dá pouca lucratividade. Aumentar a rotatividade do consultório,  
**Evelyn La:** Uhhum.  
**Dr Marcos Gesuele:** trazendo as cirurgias de face. Eh, e ao mesmo tempo aumentar a cap a a parte financeira do consultório, né, a lucratividade. Eh,  
**Evelyn La:** Aham.  
**Dr Marcos Gesuele:** a gente quer chegar pelo menos a R$ 60.000 mensais, que é uma, se se você for ver, é baixo, mano,  
**Evelyn La:** Com certeza, ainda mais pela região que vocês estão aí,  
**Dr Marcos Gesuele:** é é,  
**Evelyn La:** super possível, né?  
   
 

### 00:21:46

   
**Dr Marcos Gesuele:** tá? Então, mas assim, para não sonhar alto,  
**Evelyn La:** Tá  
**Dr Marcos Gesuele:** eu prefiro buscando um objetivo menor,  
**Evelyn La:** certo.  
**Dr Marcos Gesuele:** alcançando em menor tempo, ou se não alcançar, pelo menos é uma curva de aprendizado pra gente mudar as estratégias, pra gente rever a a a aquilo que nós estamos, onde nós estamos errando e a partir daí sim buscar novos horizontes,  
**Evelyn La:** Mhm.  
**Dr Marcos Gesuele:** novas novos objetivos até com pensando em a aumentar a a nossa clínica. Mas hoje a clínica tem um potencial de atendimento muito grande e eu tenho ociosidade,  
**Evelyn La:** Uhum.  
**Dr Marcos Gesuele:** então eu preciso mudar  
**Evelyn La:** Sim, sim. Perfeito. E você, Luca, que que você enxerga aí como para pro seu lado aí? Que que você gostaria assim?  
**lucca elias:** Bom, é mais ou menos isso que ele falou, né, na questão de alcançar os 60.000, ou a gente começar essa parte aí da cirurgia da face e eu no meu caso ali são as cirurgias de carga imediata, que é o que eu mexo mais, né, que é que mais o consultório mais oferece  
**Evelyn La:** Uhum. Uhum.  
**lucca elias:** hoje.  
**Evelyn La:** Você faz quantas dessa por mês hoje, Luca?  
   
 

### 00:22:59

   
**lucca elias:** Hoje a gente tá numa média aí, acho que de duas por  
**Evelyn La:** Uhum.  
**lucca elias:** mês.  
**Evelyn La:** E você gostaria de chegar a quanto?  
**lucca elias:** Acho que uma, se a gente chegasse, eu vou colocar uma média bem baixa hoje, umas quatro por mês, já ia ficar bem feliz.  
**Evelyn La:** Uhum.  
**lucca elias:** Seria uma por semana.  
**Evelyn La:** Uhum. Vamos por cima. Qual que é normal? Qual que é a variável do ticket de vocês?  
**Dr Marcos Gesuele:** em média 12 a 13.000.  
**Evelyn La:** Uhum.  
**Dr Marcos Gesuele:** Quando nós caímos em em em protocolo de carga imediata,  
**Evelyn La:** Sim.  
**Dr Marcos Gesuele:** nósando aí de 14 a 17.000,  
**Evelyn La:** Uhum.  
**Dr Marcos Gesuele:** é a média, né?  
**Evelyn La:** Sim. Show.  
**Dr Marcos Gesuele:** 14\.  
**Evelyn La:** E com as cirurgias da face ali, Marcos, você pretende fazer o quanto?  
**Dr Marcos Gesuele:** Ah, então eu tava pensando nisso aí. Se se eu conseguisse alcançar hoje 60.000 juntando tudo, já era um bom começo pra gente sair da crise financeira,  
**Evelyn La:** Certo. Uhum.  
**Dr Marcos Gesuele:** porque nós estamos em crise financeira aqui no Consultó,  
   
 

### 00:24:10

   
**Evelyn La:** Sim.  
**Dr Marcos Gesuele:** né? Então,  
**Evelyn La:** É  
**Dr Marcos Gesuele:** mas meu objetivo é trabalhar com R$ 200.000. O objetivo é esse, porque eu sei que não tem dificuldade para isso, principalmente na área facial,  
**Evelyn La:** claro.  
**Dr Marcos Gesuele:** que é uma área que tá atraindo muito paciente, então a gente consegue eh eh capitalizar nesse sentido.  
**Evelyn La:** Sim.  
**Dr Marcos Gesuele:** Mas eu eu preciso sair, como te falei, o meu objetivo hoje ele é baixo para eu poder alcançar esse objetivo e começar eh eh do  
**Evelyn La:** Pé chão,  
**Dr Marcos Gesuele:** gargalo.  
**Evelyn La:** né?  
**Dr Marcos Gesuele:** Eu tô eu tô com todo mês assim, ah, falta não sei o quê, p\*\*\*, tem que pagar a água. Não, não, tem que pagar o telefone porque, ah, isso enche o saco, né?  
**Evelyn La:** Claro,  
**Dr Marcos Gesuele:** Às vezes dá vontade trabalhar  
**Evelyn La:** claro, claro. Super entendo.  
**Dr Marcos Gesuele:** funcionário.  
**Evelyn La:** Eh, deixa eu, deixa eu pedir para vocês, qual que é o Instagram que vocês usam? É é da clínica ou é do Marcos particular?  
**Dr Marcos Gesuele:** Eu tenho o meu particular, o Luca tem o particular dele e nós temos o da clínica  
**Evelyn La:** O que que vocês mais movimentam hoje?  
   
 

### 00:25:03

   
**Dr Marcos Gesuele:** também.  
**Evelyn La:** Só para eu dar uma olhadinha aqui como que tá o  
**Dr Marcos Gesuele:** Para clínica da clínica,  
**Evelyn La:** posicionamento.  
**Dr Marcos Gesuele:** né, Luc?  
**lucca elias:** Hoje a gente movimenta mais o da clínica.  
**Evelyn La:** É, qual que é? Me passa aí, Louca.  
**lucca elias:** Deve tá como Odonto  
**Evelyn La:** Eu vou abrir aqui para dar uma odonto  
**lucca elias:** Jesuele.  
**Evelyn La:** Jesus. Clínica odonto ou não só  
**lucca elias:** Eh,  
**Evelyn La:** odonto?  
**lucca elias:** o @ é só Donto.  
**Dr Marcos Gesuele:** Så  
**lucca elias:** Deixa eu só ver aqui se eu falei o ar certo. É mesmo. E aí o perfil deve est escrito Odonto Jesuele com rzinho na frente.  
**Evelyn La:** É, ele não puxou aqui para mim. Destra.  
**lucca elias:** Quer que eu te mando o link?  
**Evelyn La:** Deixa eu ver que ele apareceu um na hora que eu  
**Dr Marcos Gesuele:** Você tá pondo l com  
**Evelyn La:** tá tô pondo Jesus com G e S,  
**Dr Marcos Gesuele:** G?  
**Evelyn La:** né?  
**lucca elias:** Isso,  
**Dr Marcos Gesuele:** É isso é que às vezes as pessoas põem com J.  
**Evelyn La:** Aqui o é um símbolo dourado e prata. Ah, perfeito.  
   
 

### 00:26:23

   
**lucca elias:** isso,  
**Dr Marcos Gesuele:** Isso,  
**Evelyn La:** Deixa eu dar uma olhadinha. Rua Catão, São Paulo. Isso, né?  
**lucca elias:** isso. Isso.  
**Dr Marcos Gesuele:** isso.  
**Evelyn La:** Ah, legal. Aqui apareceu Marcos aqui já.  
**Dr Marcos Gesuele:** Ja.  
**Evelyn La:** Show. Uhum. Bacana. Ué. Gção da client. Tá. Sempre eu dou dar uma olhadinha para ver como tá o posicionamento, mas vamos lá. Eh, bom, pessoal, que que eu que que eu eu vejo hoje, né? A gente teria bastante trabalho no sentido do quê? Das duas frentes mesmo, tanto em gerar mais demanda para vocês, porque hoje vocês estão só com indicação, né? Só com a indicação vocês dificilmente vão conseguir sair dessa estagnação realmente financeira, né? Então, teria que investir aí, começar de fato a trabalhar toda essa parte de melhoria no posicionamento para depois construir matriz de CP,  
**Dr Marcos Gesuele:** Так.  
**Evelyn La:** entender o perfil do cliente que vocês querem atingir e acertar mais nas estratégias de marketing para poder gerar uma demanda qualificada, tá? Eh, e trazendo inclusive cases do Marcos, como ele falou aí, para começando a construir essa questão das cirurgias da face, né, e trabalhando isso eh eh em simultâneo ali no perfil da clínica para gerar uma demanda mais qualificada e também a parte de estrutura comercial, que ela é primordial, assim pelo fato do quê?  
   
 

### 00:28:16

   
**Evelyn La:** criar processos aí para Rosana, porque provavelmente vocês têm dinheiro parado até eh com os próprios pacientes, expacientes, que é a base que a gente fala, né, clientes de base. Então, às vezes vocês devem ter muita grana parada aí pelo tempo que vocês têm de consultório, pelo no todo do Marcos aí. Eh, então trabalhar uma estrutura, uma estratégia para reaquecer, inclusive para eh gerar revenda até mesmo das cirurgias da face que o Marcos vai começar tomar à frente agora, né? Então, teria bastante eh pontos em relação a essa questão do processo mesmo,  
**Dr Marcos Gesuele:** Sim.  
**Evelyn La:** de estruturar um processo comercial, estruturar um pré-venda, estruturar uma cadência para que os comparecimentos aconteçam. a gente precisa ter aí 80% de comparecimento para que desses 80% a gente melhore cada vez mais os pontos na hora da venda também, inclusive ali para que venha ter a conversão de no mínimo 40 a 50% desses comparecimentos, tá?  
**Dr Marcos Gesuele:** S.  
**Evelyn La:** Então seria o caso de trabalhar realmente toda a frente com eh captação e estrutura comercial, né?  
**Dr Marcos Gesuele:** Certo.  
**Evelyn La:** Então assim, eh,  
**Dr Marcos Gesuele:** Так.  
**Evelyn La:** que que eu vou falar para vocês referente a questões de poder ajudá-los, nós temos, né, a nossa metodologia, vocês têm estrutura, né, tem pessoas no time paraa execução, então seria bem interessante eh a gente conseguiria implementar isso, porque o que que a gente leva muito em consideração, se tem pessoa no time que vai conseguir executar e de fato fato cumprir o processo, porque é dessa constância que a gente vai conseguir e extrair depois os  
   
 

### 00:30:15

   
**Evelyn La:** resultados, né? Então, assim, vocês têm time, né, tem a Rosana que fica focada aí nessa nessa parte comercial e seria interessante a Rosana ter até mesmo esse processo. Por quê?  
**Rosana Mara Dias de Oliveira Elias:** Угу.  
**Evelyn La:** Porque quando começa a aumentar o volume e você precisa de alguém para te ajudar, você já tem um processo definido. E aí, claro, o feeling que você falou, né, esse feeling de eh ser mais sutil, o cuidado, isso é o feeling que você passa pra pessoa, mas o processo em si, é bom você ter o script, você ter toda essa parte documentada, parte de vendas, para você também não se apertar, né? no sentido assim, começar, quando começar de fato gerar um pouco mais volume, começa a crescer e tal, aí o processo vai fazer toda a diferença. Então assim, nós temos hoje uma metodologia que ela se chama se chama metodologia face 100K. Face Senk. Por quê? Hoje nós temos dentro do nosso ecossistema cases, né? A gente chama de cases aí que fazem 100.000 dia, 100.000 e 100.000 uma, né? Essa é a nossa metodologia para aumentar e realmente fazer acontecer. Eh, por que que ela dá muito certo e por que muitos chegam realmente a esses 100.000 mês, 100.000 eh semanal?  
   
 

### 00:31:43

   
**Evelyn La:** o porque nós mexemos em toda a estrutura de parte comercial e parte de captação, porque muitas vezes eh não eh o o, né, a clínica em si, a a o time ali, ele não tem a clareza até mesmo em agregar valor dentro dos protocolos que a própria clínica já tem. E a gente tá falando aqui, ó, num ticket médio de 12 a 13.000, quatro cirurgias, a gente já tá falando perto de uns 50k. Se a gente conseguir trazer mais quatro a cinco no na parte de faces pro Marcos, a gente tá falando aí de R$ 100.000 R$ 1000 fácil em um mês.  
**Dr Marcos Gesuele:** Zero.  
**Evelyn La:** É muito possível isso, mas não é milagroso. Como eu digo, tem todo um trabalho, tem um passo a passo, tem um processo que precisa de fato ser executado. Então nós temos pessoas que em um mês, nos primeiros 15 dias chegaram a esse número, pessoas que um mês e outros casos dos quais a gente teve. O Artur, por exemplo, é um dos nossos dos nossos cases aqui. Ele faturava entre 7 a 10.000 mês e ele saiu desse faturamento para 90 em 4 meses, tá? Então assim, cada um tem o seu momento, tem seu tempo,  
   
 

### 00:32:59

   
**Dr Marcos Gesuele:** Eu  
**Evelyn La:** mas é possível. E o Artur não tinha tanta estrutura, ele fazia muita coisa sozinho ainda. Vocês já têm um time que, poxa, dá para trabalhar bem, né? Eu vou apresentar um pouquinho mais. Marcos, você tá vai conseguir ver  
**Dr Marcos Gesuele:** vou, mas eu já eu já eu já passei por essa apresentação. Essa apresentação hoje é mais pra Rosana e pro Luca.  
**Evelyn La:** pro Luca. Ah, perfeito. Bom,  
**Dr Marcos Gesuele:** Isso.  
**Evelyn La:** tudo bem.  
**Dr Marcos Gesuele:** Tá.  
**Evelyn La:** Você já fez?  
**Dr Marcos Gesuele:** Então eu tenho, eu já vi  
**Evelyn La:** Aham.  
**Dr Marcos Gesuele:** essa  
**Evelyn La:** Você conversou com alguma nossa alguma das nossas especialistas, então, um tempo atrás?  
**Dr Marcos Gesuele:** cara, eu não vou lembrar. Eu tava num processo tão complicado com saúde do meu pai e e eu lembro que eu  
**Evelyn La:** Ah\!  
**Dr Marcos Gesuele:** passei, você mostrou agora o Fá Senk, eu lembro que eu vi essas imagens, mas desculpa, eu não tô recordando como que foi que  
**Evelyn La:** Ah, certo. Vamos lá.  
**Dr Marcos Gesuele:** aconteceu  
**Evelyn La:** Eu vou ir falando aqui. Com certeza você vai já assimilar um pouco mais rápido, então, pelo fato de você ter visto.  
   
 

### 00:34:02

   
**Dr Marcos Gesuele:** isso aí.  
**Evelyn La:** Mas aí a Rosana e o Luca, fiquem à vontade. Caso queiram perguntar alguma coisa, queiram me interromper aqui, fiquem bem à vontade, tá? Eu gosto sempre de fazer só um combinado que é o quê? Eu vou falar um pouquinho sobre a empresa, sobre nosso método e aí eu vou pedir uma confirmação de vocês se o método em si faz sentido mesmo e aí a gente dá sequência se for o caso. Senão a gente para no método. Por quê? Porque eh não adianta só eu querer ajudá-los, não adianta só eu eh falar para vocês: "Olha, nossa metodologia é possível implementar no cenário que vocês estão". Se vocês não acharem que é momento para isso, tá bom?  
**Dr Marcos Gesuele:** Perfeito.  
**Evelyn La:** Então, vamos lá. Vou falar um pouquinho sobre o Renan e o Mateus aqui para Rosana e o Luca conhecer,  
**lucca elias:** Так.  
**Evelyn La:** né? O Marcos recordar. Então, ã, eles são os donos hoje da System, são os nossos os nossos expert aí, né? Nessa parte comercial, a gente tem a empresa já há 6 anos, eu estou com eles há 2 anos. De nosso foco é o que eu falei, né?  
   
 

### 00:35:08

   
**Evelyn La:** Trabalhamos nessa frente de gerar a demanda qualificada e os processos comerciais ali. O Renan tá há 5 anos já gerindo esses times de alta performance, já fez mais de 15 milhões em venda só pelo digital com as clínicas, né? E o Mateus é o nosso sócio estratégico. O Renan fica mais à frente da parte de estratégias comerciais. E o Mateus, ele é o nosso sócio estratégico que fica na parte de otimização de processos e também a estratégia de marketing, estratégia de posicionamento, essa parte mais operacional, tá? Dentro do nosso ecossistema, hoje nós temos a alguns embaixadores, alguns cases de sucesso. A Débora é um deles. A Débora ela fica em Paraapebas, ela do Pará, é um dos nossos eh maiores cases, vamos dizer, até agora, porque a gente maiores cases em em período curto de espaço, tá? De tempo. Ela entrou faturando 100, 150 e em pouco tempo ela chegou a 490\. E agora a gente tá com projeto para levar alavancar a clínica dela para bater 1 milhão, né? E a gente foi fazendo a escadinha com ela também, né? Não foi assim, eh, do dia paraa noite, mas agora ela já tá no momento que a gente vai conseguir virar bastante essa chave na empresa.  
   
 

### 00:36:29

   
**Evelyn La:** Até o Renan e o e o Mateus estavam no no consultório, na clínica dela essa semana passada, presencial para treinar um pouco mais de perto lá toda a equipe. Esse já foi um dos resultados que nós conseguimos gerar com uma clínica, 1.800. E o que que a gente tem muito do mercado atual? Por que que a Sistem eh começou a nichar em cirurgiões da face? Eh, alguns médicos a gente também atende. Ah,  
**lucca elias:** M.  
**Evelyn La:** eh maioria é dentista, mas a gente atende médicos também, porque o que que acontece hoje? A, eh, o cirurgião, empresário em si, ele foca muito na técnica e é isso, né? Mas aí o lado, o lado que é o coração da empresa que a gente diz que é essa parte comercial,  
**Dr Marcos Gesuele:** Sì.  
**Evelyn La:** ele fica um pouquinho deixado ali no cantinho e de fato é o coração da empresa que vai bombear aí pros outros pilares. Então se a gente precisa ter estratégia e hoje a gente sente cada vez mais essa necessidade de um comercial mais estruturado, por mudou muito a forma de se consumir as coisas, né? E nós somos vendedores, querendo ou não, hoje o Marcos,  
**Dr Marcos Gesuele:** S  
**Evelyn La:** ele, se ele não souber se vender, eh, a gente não consegue atingir muitas vezes o esperado, né?  
   
 

### 00:37:59

   
**Evelyn La:** O Luca, a mesma coisa. A Rosana, se ela não conseguir vender o comparecimento, o agendamento, então tudo gira realmente em torno da venda, né? Eu gosto muito de parafrasear o Thiago Cer que ele diz assim: "A vida é uma venda e de fato é para tudo, né? Seja você médico, seja você advogado, seja você cirurgião, dentista, seja a vendedora da padaria, realmente. Então, tudo gira em torno disso, é o como você conduz. E o que que a gente encontra muito no mercado hoje por essa questão de qualificação de leads, né, que até a Rosana trouxe o ponto ali, chegava muito desqualificado. O lead ele se torna cada vez mais caro. Então nós temos hoje uma demanda muito alta em relação a volume, só porém pouca qualificação. E quando você vai qualificar mais, ele é mais caro e cada vez mais ficando mais alto ainda. Então, a gente tinha ali qualificados até um tempo atrás por R$ 10, R$ 12 e hoje a gente tá chegando a pagar até R, R$50 por lead, tá? O como que a gente consegue eh gerar ROI eh com lead tão alto assim? Então, uma das estratégias, né, uma das soluções com a nossa parceria é justamente a estruturação comercial, porque dela vai vir outras estratégias para se trabalhar outras formas de captação, não depender só da indicação e nem só do tráfego pago, para que quando você invista o tráfego no tráfego pago de maneira mais assertiva, você obtenha bons resultados também, né?  
   
 

### 00:39:38

   
**Evelyn La:** Então a nossa solução ela traz tanto a solução pra parte de marketing quanto a parte de estrutura comercial. É isso que vai realmente fazer acontecer, né? Muitas vezes os riscos de fazer sozinho. A gente encontra aí muito cenário até que a Rosana tá, né? Eh, só ela para fazer, só ela para atender. Eh, não tem processo hoje.  
**Dr Marcos Gesuele:** Ah.  
**Evelyn La:** Então, se entrar uma pessoa amanhã, ela com certeza vai perder muito tempo em treinar essa pessoa, né? E aí isso dá o quê? Perde tempo, gera muitas vezes frustração, eh perde espaço até mesmo paraa própria concorrência ali que tá trabalhando um pouco mais eh eh avançado em relação a isso, né? Então, a System, ela tem o objetivo de otimizar o tempo desse cirurgião, desse empresário, dessa clínica, como aumentando o ticket médio, trabalhando estratégias de venda e estruturação comercial para aumentar inclusive a conversão e aumentando o LTV. Que que é o LTV? É um, o L TV é uma cicla em inglês que significa lifetime valory, que é o tempo, o quanto que esse paciente investe e reinveste nessa clínica. Em qual sentido? O quanto que ele compra de você, por quanto tempo? Então, por exemplo, hoje nós temos uma base de clientes, né, focados mais na parte em que o Luca tá atuando, mas essa mesma base nós podemos utilizar para reaccer e desses aí tem uma boa porcentagem de vendas para a parte de cirurgias da face com o Marcos.  
   
 

### 00:41:25

   
**Evelyn La:** Então isso é LTV, é aquela recompra. E aí a gente traz um uma estratégia para montar essa metodologia, para ficar isso um pouco mais claro, como que eu posso revender para um mesmo paciente algo diferente. Então a gente sempre diz, né, quanto valeria hoje para vocês ter de fato todos esses processos, né? Pergunto diretamente até paraa R aí, quanto valeria hoje, R você ter processo comercial e trabalhar com um pouco mais de tranquilidade, previsibilidade, inclusive de vendas,  
**Rosana Mara Dias de Oliveira Elias:** Eu acho  
**Evelyn La:** né?  
**Rosana Mara Dias de Oliveira Elias:** que quando você tem retorno, né, eu acho que tudo acaba ficando barato, né? O problema é o problema, meu minha experiência foi uma experiência ruim,  
**Evelyn La:** Uhum.  
**Rosana Mara Dias de Oliveira Elias:** né?  
**Evelyn La:** Sim,  
**Rosana Mara Dias de Oliveira Elias:** Foram duas duas empresas e as duas empresas eu tive o mesmo mesmo mesmo  
**Evelyn La:** sim.  
**Rosana Mara Dias de Oliveira Elias:** resultado. Mas eh eh eu acho que a partir do momento que você se você se você compra algo, seja um produto, seja um serviço, você compra já pensando no retorno que aquilo vai te trazer, na na benfeitoria que aquilo vai te trazer. Então dependendo da da do tamanho da benfeitoria, é o tamanho que você paga também, né?  
   
 

### 00:42:40

   
**Evelyn La:** Exato. Exato. Não, perfeito. Mas eu digo no valor, na questão emocional até, eu eu penso assim, não tem nem como precificar, vamos dizer, né? Porque você trabalhar com mais tranquilidade e sair dessa corrida dos ratos, que nem aquela aquilo que o Marcos falou: "Poxa, tá preocupado que eu tenho que pagar isso, tem aquilo, aí de repente brota outro boleto daqui." Você trabalhar com mais tranquilidade em relação a isso, acredito que não tenha nem preço, né? Pelo fato de você ter a essaidade,  
**Rosana Mara Dias de Oliveira Elias:** Ah, sim, com certeza. Com certeza.  
**Evelyn La:** né? E esse aqui é justamente o novo mercado do qual, com a nossa metodologia a gente tem ajudado algumas clínicas a saírem desse sufoco. A Débora mesmo até deu um depoimento muito muito lindo assim pro pro Renan essa semana referente a isso. Ela falou assim: "Renal, fazia 15 anos que eu não sabia o que que era não pagar juro de cartão e não precisar de empréstimo." Então, com a nossa metodologia, foi uma grande virada de chave. foi a que alcançou os 490.000, né, de faturamento. Mas eh é um alívio emocional que eu falo assim, não tem preço isso, né, você ficar mais tranquilo.  
   
 

### 00:43:55

   
**Evelyn La:** Então esse é o nosso sistema, a nossa metodologia face sem cá. Dentro desse sistema, nós temos oito pilares principais. Esses oito pilares, eles vão contemplar justamente todo o que a gente vai fazer em execução com durante os se meses de acompanhamento. E a gente não faz uma coisa de cada vez, a gente executa de forma simultânea. Então, por exemplo, para um primeiro passo, o que que a gente foca? A gente foca em construir os seus ofertas e e produtos. Por a maioria não consegue muitas vezes alavancar e aumentar a conversão porque não tem uma oferta. E a oferta ela é diferente de você simplesmente passar um preço por algo, né? Tentar vender de forma isolada. Então a gente constrói a oferta. De que maneira que a gente faz isso? A gente pega todas a os procedimentos, né? por exemplo, vamos pegar do Marcos e do Luca e a gente vai, a gente cria uma esteira, ou seja, produtos que são produtos de entrada, produtos principais e produtos de saída. Dentro dessa metodologia, nós alavancamos o ticket médio para cada produto. Por quê? Isso vai trazer uma clareza para depois a gente trabalhar funil de mar. Aí sim a gente consegue uma matriz, um mapeamento mais específico para trazer um cliente mais qualificado e assim a conversão ela tende a ser maior.  
   
 

### 00:45:35

   
**Evelyn La:** Então a gente vai fazendo de forma simultânea. Depois a gente vai trabalhar pré-venda, venda, né, junto ali, eh, técnicas e estratégias para se vender melhor, pré-vendas, técnicas e estratégias para você aumentar o nível de comparecimento. Outra pilar bem interessante que a gente tem dentro da metodologia são os protocolos de caixa. Esse daqui são estratégias para você gerar faturamento sem necessariamente você precisar investir, por exemplo, em tráfego pago. É para trabalhar a base aqui. E a gestão do processo, a gente tem um dashboard pronto hoje, que é só para você alimentar, para de fato você ter uma ideia, uma noção ali de questões de métricas mesmo, números para depois tomar decisões baseadas mais em dados. do quanto que tá convertendo do tráfego, quanto tá convertendo o protocolo de caixa, só para entender e ter mais clareza ao longo do processo. Então, o funil de marketing, começar a falar detalhadamente um pouquinho de cada um sobre a metodologia. A gente tem uma estrutura aonde a gente define, primeira coisa, os funis de aquisição. Que que é o funil de aquisição? São as portas de entrada dos pacientes. Então, por onde eu vou captar paciente? No funil de marketing, a gente vai definir isso.  
   
 

### 00:46:58

   
**Evelyn La:** E toda a estratégia utilizada, ela tende a seguir para quê? Para que ocorra a venda no final, seja um produto principal, seja um produto de entrada. Parte de pré-vendas. Aqui a gente estrutura o processo do agendamento. Todo o processo, todos os scripts nós temos prontos, né? e a gente cria uma cadência de followups, de retornos, de confirmações. Dentro desse processo de pré-venda, inclusive nós trazemos até os contornos de objeções. Que que é isso? Porque muitos pacientes eles já vêm com algumas resistências no pré-atendimento e aí a gente tem script pronto, tem tudo detalhado do como você contornar e nós temos um processo de acompanhamento para isso também. Nós temos as meninas que ficam nesse acompanhamento, as nossas estrategistas ficam direcionando. Então, às vezes acontece lá, ah, eh, tô com uma dúvida aqui de como contornar eh tal questão específica com um paciente. Aí você pode mandar isso no grupo VIP de acompanhamento que a gente cria e as meninas vão ajudar nesse processo, tá? as cadenças de followup que eu falei que essa parte de retornos e tudo mais geridos, né, num CRM, que é muito importante para você ter mais organização. E aí outro pilar que temos é o funil de vendas.  
   
 

### 00:48:23

   
**Evelyn La:** Nós temos dois modelos comerciais para venda. O primeiro modelo, essa estruturação que vocês estão vendo, ele só ele é definido só realmente para eh eh passar toda parte de script, eh é tudo que a gente segue e o processo em si, tá? Na execução ele é mais simples do que olhando aqui, mas é o modelo principal um, ele tem como foco do quê? Trabalhar a conversão e aumentar a conversão, vender para os leads que são novos. Então, nós temos modelos e scripts específicos para trabalhar esses leads. Que que são os novos? São aqueles que vão vir pelo tráfego pago, por indicação, pelo social cell, né? um trabalho no Instagram ali, mas que é novo. E o modelo comercial dois são as estratégias, inclusive as de caixa rápido para gerar oferta, para gerar demanda e venda de base, ou seja, pacientes antigos e pacientes que por algum motivo não fecharam, tá? Isso é o que vai fazer realmente a alta performance. Aqui todos os scripts nós temos pronto, como eu comentei, né, de processo de venda. E na construção das ofertas, então, que é o que eu falei para vocês, a gente constrói uma literalmente uma escadinha para aumentar, que que é o foco aqui? Aumentar o ticket médio de vocês. Então, a gente tem o eh a construção da oferta em si.  
   
 

### 00:49:53

   
**Evelyn La:** A oferta ela eu como você vende aquilo, mas não de forma isolada. é o como você vende a sua metodologia de fato para cada paciente. Então é onde a gente cria os produtos de entrada principais e de saída, protocolos de caixa, que foi o que eu falei, a gente trabalha lá no modelo comercial dois que eu passei antes para gerar de fato caixa rápido. Então a gente tem oito estratégias aqui. É uma, é como se fosse uma ação de vendas, tá? A gente tem cases aí que que fizeram, executaram isso em uma semana, focaram em uma semana só fazer protocolo de caixa e alguns escolhem tipo dois dias ou um dia na semana para fazer. Vai muito de acordo com o perfil, cenário da clínica e objetivo. Mas, por exemplo, nós tivemos a Sand, foi uma das nossas eh aceleradas ali, que ela faturava cerca de 70.000, 1000, né? Em um mês ali a média dela tava nesse valor e com a ação de vendas dos protocolos de caixa, ela conseguiu bater os 70.000 em uma semana. Então, foi um bom resultado que a gente conseguiu gerar para ela. Gestão dos processos. Então, aqui a gente tem a o dashboard que eu falei que vai ser alimentado só para vocês terem métricas ali, tá?  
   
 

### 00:51:19

   
**Evelyn La:** Esse aqui é mais é o importante dele é colocar de fato, ele é bem intuitivo, tá? É bem fácil de fazer isso, mas é só para vocês irem acompanhando o que que realmente tá performando melhor na clínica. Então é um dashboard mais de acompanhamento mesmo. É uma ferramenta que a gente disponibiliza no processo, porque é importante ter essa clareza. E por último, não mais e nem menos importante, o tráfego pago. O tráfego pago, como eu falei, eh a gente não foca tanto no tráfego pago, mas a gente faz também, a gente realiza ele, porque é importante você ter captação em de novos, ainda mais o Marcos agora que vai querer focar, né, em um em uma na questão das cirurgias. É importante começar com pacientes modelo, como ele falou, para ir trazendo para depois ele ir alavancando o ticket médio dele, né? E aí é interessante fazer o tráfego pago, principalmente para poder chegar nesses pacientes modelos aí. Então essa é a nossa metodologia, pessoal. Hoje a gente trabalha, como eu falei, nas duas linhas de frente, em gerar demanda e estruturar processo comercial, converter essa demanda de fato, simplificando, né? Mas isso é feito dentro dos oito pilares aqui dentro do nosso método.  
   
 

### 00:52:39

   
**Evelyn La:** Aí eu pergunto para vocês, o Marcos acredito que refrescou um pouco a memória aí,  
**Dr Marcos Gesuele:** Olha,  
**Evelyn La:** mas Rosana e Luca, que que vocês acharam? Vou ouvir primeiro vocês, depois escuto o Marcos que já viu a a metodologia antes. Mas o que vocês acharam sobre o  
**Rosana Mara Dias de Oliveira Elias:** Olha,  
**Evelyn La:** método?  
**Dr Marcos Gesuele:** pelo tudo que eu  
**Rosana Mara Dias de Oliveira Elias:** pelo tudo que eu já ouvi falar de marketing digital, né,  
**Dr Marcos Gesuele:** eu acho bem completo,  
**Rosana Mara Dias de Oliveira Elias:** eu acho  
**Dr Marcos Gesuele:** bem completo.  
**Rosana Mara Dias de Oliveira Elias:** e não tenho muita prática assim com marketing digital e tudo mais, mas é tá bem dentro assim do que a gente tá procurando, o que a gente precisa.  
**Evelyn La:** Legal, Luca. Você a que que você achou aqui de toda essa essa parte aí dos processos,  
**lucca elias:** Eu  
**Evelyn La:** tráfego, funis?  
**lucca elias:** eu achei bem legal assim a questão de tudo, como você falou, os oito pilares, né? Tudo bem dividido, cada pilar com seu processo, sua parte que junto, né, forma um ecossistema legal. Achei um ecossistema bem sadio. Eu achei bem interessante, ainda mais essa parte de eh protocolos de caixa, né?  
   
 

### 00:53:53

   
**Evelyn La:** Esse é muito bom. Vou te falar. Salvou muita clínica aqui esse protocolo de caixa, a ação de vendas ali, né? E tu, Marcos, me diga lá  
**Dr Marcos Gesuele:** Eh, abrir.  
**Evelyn La:** aí.  
**Dr Marcos Gesuele:** Beleza, Evelyin, eu vou, posso ser sincero com você, né?  
**Evelyn La:** Claro, com toda certeza.  
**Dr Marcos Gesuele:** Situação que a gente se encontra hoje é uma situação de até desânimo, sabe? a gente faz uma coisa, não dá certo, a gente faz outra, não dá certo. Nós somos dentistas, não somos gestores, eh não temos nenhum conhecimento em marketing, não temos nenhum, é, é toda a dificuldade que nós estamos passando, é porque nós não temos nenhum conscimento nessa área. Além disso, não temos dinheiro para investir em profissionais capacitados que nos ajudassem. Eh, tudo que você me fala tem muita coerência, tá? tá, tá exatamente no que eu estou precisando. Mas eh aquela história, tanta gente já prometeu tanta coisa para mim e a apresentação sempre é uma coisa muito  
**Evelyn La:** Uhum.  
**Dr Marcos Gesuele:** linda, sempre é uma coisa muito coerente. Eh, não estou desacreditando de você, Evelyn, em momento algum,  
**Evelyn La:** Sim, claro.  
   
 

### 00:55:05

   
**Dr Marcos Gesuele:** mas eu eu fico eu tô desanimado,  
**Evelyn La:** Угуm.  
**Dr Marcos Gesuele:** tô tô bem desanimado com o que eu tenho visto, mas em contrapartida, eu diria que tudo que você me apresentou é diferente de tudo que me apresentaram até hoje. Porque você tá falando em ecossistema,  
**Evelyn La:** Угуm.  
**Dr Marcos Gesuele:** você tá falando em várias áreas que são trabalhadas simultaneamente, você tá falando de de de processos que são estabelecidos dentro da empresa e esses processos precisam existir. É a grande dificuldade que eu como gestor tenho, porque ah, eu sou dentista e eu sei os processos que eu tenho para fazer uma cirurgia, eu sei dos processos que eu tenho para executar eh eh um planejamento eh ortopédico, ortodôntico. Isso aí tudo eu sei, traçados e tudo mais, mas os processos administrativos eu não tenho a mínima noção do que fazer. E aí você entra na internet e falam 1000 coisas, então eu fico eu fico zonzo e perdido.  
**Evelyn La:** Uhum. Sim. É  
**Dr Marcos Gesuele:** Eu hoje numa situação melhor para poder fazer esse tipo de coisa.  
**Evelyn La:** muito.  
**Dr Marcos Gesuele:** Por isso eu quero ouvir de você qual é a proposta que vocês têm pra gente.  
**Evelyn La:** Aham.  
**Dr Marcos Gesuele:** Mas falou é muito coerente.  
   
 

### 00:56:11

   
**Evelyn La:** Certo.  
**Dr Marcos Gesuele:** Aliás,  
**Evelyn La:** Uhum.  
**Dr Marcos Gesuele:** parabéns, você é uma brilhante apresentadora.  
**Evelyn La:** Ah, muito obrigada. Que  
**Dr Marcos Gesuele:** Se quiser trabalhar no meu consultório, tem um espaço só para você.  
**Evelyn La:** bom.  
**Dr Marcos Gesuele:** Deixa essa porcaria presa e vem fazer direto para mim.  
**Evelyn La:** Dependendo R aí,  
**Dr Marcos Gesuele:** Vem ser minha sócia.  
**Evelyn La:** ó, ó,  
**Dr Marcos Gesuele:** Venha ser minha sócia.  
**Evelyn La:** ó.  
**Dr Marcos Gesuele:** Você vem para ser  
**Evelyn La:** Viu? dependendo da negociação,  
**Dr Marcos Gesuele:** minha.  
**Evelyn La:** olha que eu já tive loja, já tive experiência aí também de gestão, então quem sabe aí,  
**Dr Marcos Gesuele:** Legal. O convite tá feito.  
**Evelyn La:** ó, Ren que se cuide.  
**Dr Marcos Gesuele:** É.  
**Evelyn La:** Então,  
**Dr Marcos Gesuele:** Pago o Renan também. O Renan para ser meu sócio também, ué.  
**Evelyn La:** é,  
**Dr Marcos Gesuele:** Ele ele deve ser um investidor.  
**Evelyn La:** é verdade.  
**Dr Marcos Gesuele:** De repente ele fala: "Vou investir numa clínica eh de saúde estética e aí ele todos vamos ganhar,  
**Evelyn La:** É, é, mas é verdade. Isso é muito possível mesmo.  
**Dr Marcos Gesuele:** né?  
   
 

### 00:57:03

   
**Evelyn La:** Hoje, hoje eu diria que, olha, eles estão começando a tomar um rumo ali com a empresa que eu falo, tá muito propício para logo acontecer ainda de ter realmente uma sociedade  
**Dr Marcos Gesuele:** Legal.  
**Evelyn La:** aí, estar ali no dia a dia mesmo, sabe? Muito  
**Dr Marcos Gesuele:** É, eu eu meu meu meu eu hoje se tivesse um sócio investidor pra gente  
**Evelyn La:** bem.  
**Dr Marcos Gesuele:** e estabelecer tudo isso que você tá falando, eu acho que em 2 meses, 3 meses nós estamos aí trabalhando com algo em torno de R$ 450, R$ 500.000.  
**Evelyn La:** Exatamente. Penso mesmo pela pelo potencial que vocês têm no e portfólio. Hum. Pelo ticket ali médio, né? Exatamente.  
**Dr Marcos Gesuele:** Perfeito.  
**Evelyn La:** Mas é isso. Eh, é sobre isso. A, a questão da metodologia, eu gosto sempre de ouvir, né? Eu sempre paro nesse slide para ouvir, entender se de fato fez sentido, se ressoou algo, porque assim, eh, não adianta nós querermos, né,  
**Dr Marcos Gesuele:** Não,  
**Evelyn La:** fazer acontecer se de fato o outro lado ali, poxa, gostei, mas não era bem o que eu procurava e tá tudo certo.  
**Dr Marcos Gesuele:** não, eu acho que bem dentro do que eu tô procurando.  
   
 

### 00:58:15

   
**Dr Marcos Gesuele:** Na realidade. Eh, todas as minhas, como é que fala? As minhas necessidades, todas as minhas dores estão dentro daquilo que você falou,  
**Evelyn La:** Certo.  
**Dr Marcos Gesuele:** né?  
**Evelyn La:** É só o financeiro, então.  
**Dr Marcos Gesuele:** O meu problema é o financeiro.  
**Evelyn La:** Só o financeiro,  
**Dr Marcos Gesuele:** Пробле  
**Evelyn La:** tá? Vamos falar disso depois. Vamos lá, então. Vou começar, vou falar, vou trazer para vocês aqui o como que seria a aplicação de fato, né? Aqui eu falei sobre metodologia, sobre o que que tudo que a gente tem, né? É como se eu abrisse o cardápio aqui, mas agora eu vou mostrar para vocês como de fato a gente implementa isso. Então,  
**Dr Marcos Gesuele:** Certo.  
**Evelyn La:** a gente implementa através da parceria, como eu falei, é uma parceria de 6 meses. Aí a gente tem quatro pontos, né, bem focados. Eh, um deles é de fato alavancar o faturamento. E eu digo que o faturamento ele vem muito da consequência da estruturação do processo, né, da organização, eh, enfim, de todo o trabalho ali. É muito consequência realmente de fato disso. Então, primeira coisa, a gente faz uma reunião exclusiva, né, que seriam, no caso aqui, seriam com vocês três e uma das nossas estrategistas para ditar esse passo a passo aí que vai ser executado nos 6 meses.  
   
 

### 00:59:32

   
**Evelyn La:** Nessa dessa reunião vocês já saem com a próxima marcada,  
**Dr Marcos Gesuele:** Tá  
**Evelyn La:** normalmente é de um dia pro outro, tá? é bem bem acelerada aqui com a gente mesmo.  
**Dr Marcos Gesuele:** Так.  
**Evelyn La:** Então você já saem com a próxima marcada que é as de plano de ação. Então a gente faz mais uma de plano de ação para definir o quê? Nessa próxima a gente vai construir a esteira de produtos já e trabalhar a parte da apresentação de vendas. Feito isso, dessa você já sai com a terceira marcada, que aí é com o Mateus e o Pedro. O Pedro é o nosso gestor de tráfego pago e o Mateus, que é o dono e o nosso estrategista. Eles vão definir aqui toda a parte de posicionamento, marketing e funis de venda. Vai ser definido todas as estratégias para ser executada com base no que foi definido e feito da esteira de produtos. Por isso que uma coisa linca e alavanca a outra. Não tem como fazer de forma isolada ali, né? Então, a gente vai seguindo e vai fazendo.  
**Dr Marcos Gesuele:** S  
**Evelyn La:** Eh, define primeiro a esteira, estratégia, venda. OK. Agora a gente vai fazer o quê? A gente vai fazer estratégia, vai definir como é que a gente vai vender isso aqui, né?  
   
 

### 01:00:42

   
**Evelyn La:** Então, a gente vai fazendo assim, tá? Nessa primeira semana que vocês entram no programa, já liberamos os protocolos de caixa, inclusive para quê? por exemplo, paraa Rosana já ir trabalhando a base que ela tem de pacientes para ir aquecendo e ativando novamente. Para quê? Até mesmo paraa captação de pacientes modelos dessa base. Dá para fazer muita coisa aí, tá? Pacientes modelos pro Marco, pro Marcos. Como que a gente faz esse acompanhamento de se meses? Essas reuniões primeiras que a gente reexecuta, elas são individuais com vocês e os estrategistas, como eu falei. E ao longo dos seis meses a gente cria um grupo VIP no WhatsApp. Nesse grupo vai estar só vocês, o Mateus, o Renan, eu e as outras três estrategistas que nós temos no time. E dentro desse grupo de VIP éonde vai se acontecer toda a nossa comunicação durante esse tempo e ela é full time. Então, assim, ali que as meninas vão mandar, eh, quando vai ter tutorias ao vivo, por exemplo, quando que a gente vai ter alguma tutoria específica, por exemplo, com o Renan, quando ele ele marca. É por ali que a gente marca as outras reuniões, porque depois dessas três planos estratégicos vocês têm direito a mais seis estratégicos exclusivos com o Mateus ou com o Renan, enfim.  
   
 

### 01:02:10

   
**Evelyn La:** Se precisar tirar qualquer dúvida, é por ali. E todo o material que a gente precisa para subir para as campanhas, vocês enviam para nós por ali. Então assim, o marketing a gente vai cuidar de dar o direcionamento para vocês e fazer a campanha, mas a gente não faz os criativos, que é o quê? Editar vídeo, essas coisas, a gente não faz. a gente precisa que isso seja enviado, pronto, pra gente poder depois fazer toda a parte de de campanhas ali, tá? Mas assim, eh, quanto a isso, o Mateus dá várias dicas, o Pedro também, vídeos que vocês mesmos podem gravar na clínica, vocês mesmos ali fazer uma edição, não precisa ser nada muito mirabolante para um primeiro momento, não. Até mesmo porque a gente tem que focar em fazer dinheiro agora, né? Não dá para ficar aí depois a gente vai pensando em outras melhorias. Mas é todo pelo grupo do pelo grupo VIP que a gente faz esse acompanhamento. Outro outro grupo, perdão, é para time comercial. Então, por exemplo, no outro grupo daria paraa Rosana ficar também, que fica mais essa parte comercial, porque é onde a gente tira mais as dúvidas e os feedbacks que a gente passa, eh, onde tem várias outras, eh, pessoas e time comerciais de outras clínicas. é mais um networking ali para troca de ideias, mas o o acompanhamento exclusivo é pelo VIP aqui.  
   
 

### 01:03:37

   
**Evelyn La:** E aqui também podem ser tiradas dúvidas referente à questão comercial e tudo mais, tá? Tutorias, nós temos sempre segunda, terça e quarta e variáveis na quinta e na sexta. Não é sempre que tem, mas sempre duas, três vezes na semana nós temos tutorias. E essas tutorias são o quê? São online? São ao vivo das 11 ao meio-dia. Eh, ou é o Mateus, ou é a Mari, ou é a Alane. Às vezes eu também, dependendo ali o dia e o tema a ser abordado, mas é para treinar, para tirar dúvidas, é sempre para estar o quê? ajudando. É um pegar na mão, de fato, e a gente trazer paraas tutorias as dúvidas e a gente conseguir otimizar o quanto antes e o máximo possível de toda essa parte comercial, eh, que se refere a pré-venda, a venda, posicionamento, enfim. Dentro do nosso programa, a gente tem algumas trilhas de conteúdo. São conteúdos gravados pro pré-vendas e para vendas. E nesse conteúdo gravado, a gente tem as estratégias dos protocolos de caixa. Então a gente libera esse conteúdo e direciona. Inclusive quando você entra, tem duas, três aulas ali específicas que a gente precisa que você assista primeiro para depois a gente conseguir montar a sua apresentação de vendas, tá?  
   
 

### 01:05:00

   
**Evelyn La:** Toda a documentação, né, ilimitada. E aqui os treinamentos. Então, como eu falei, eh, para venda, para pré-venda. E para social. Essa é a trilha de conhecimento e os protocolos de caixa.  
**Dr Marcos Gesuele:** Certo.  
**Evelyn La:** No programa nós temos uma os bônus também, as bonificações, né? Que que é o CRM? Eh, a implementação dele é gratuita, mas a mensalidade dele, por ser um parceiro nosso, ela tem um desconto, fica R$ 137 por mês. O que que é o CRM? é o é a parte para fazer a gestão dos leades, a gestão dos pacientes. Então,  
**Dr Marcos Gesuele:** Tá.  
**Evelyn La:** CRM ele é para você se organizar, né? A gente tem as cadências de followup, que é as cadências de retorno, que a gente vai cadastrando elas aqui e aí depois você vai movendo esses leads para cada passo a passo e, inclusive para não se perder em nenhum lead ficar sem retorno, sem resposta ou sem ser trabalhado, tá? gestor de tráfego pago, que é um bônus também no programa, e o painel Flashbd, que é painel das métricas. Tudo isso também documentado ali. Como executar? Vocês ficaram com alguma dúvida de como que funciona ali os se meses de execução?  
   
 

### 01:06:26

   
**Dr Marcos Gesuele:** Não, não.  
**Rosana Mara Dias de Oliveira Elias:** Amen.  
**Evelyn La:** Rosana Luca,  
**Dr Marcos Gesuele:** Deixa eu pegar.  
**Evelyn La:** alguma dúvida?  
**Dr Marcos Gesuele:** Pera aí. Eu acho que tudo vocês  
**Rosana Mara Dias de Oliveira Elias:** Ah, eu acho que todo vocês vão estar treinando, né? Então, acho que não tem muita dificuldade.  
**Dr Marcos Gesuele:** vão  
**Rosana Mara Dias de Oliveira Elias:** A gente já a gente já conhece, eu e o Lucas, a gente já conhece essa essa coisa de CRM e alguns termos assim que você falou,  
**Dr Marcos Gesuele:** ser  
**Rosana Mara Dias de Oliveira Elias:** mas logo eu já identifiquei que era alguma outra coisa que a gente já tinha eh tido  
**Dr Marcos Gesuele:** eh tira alguma M.  
**Rosana Mara Dias de Oliveira Elias:** alguma alguma experiência também. Então, acredito que não tenho muita dificuldade  
**Evelyn La:** Show.  
**Dr Marcos Gesuele:** Eh,  
**Evelyn La:** Maravilha.  
**Dr Marcos Gesuele:** eu eu que eh após os seis meses ele é renovável ou encerrou e tá, eu sigo em  
**Evelyn La:** É renovável. Uhum. Você pode estar renovando sempre,  
**Dr Marcos Gesuele:** frente.  
**Evelyn La:** tá? Você pode renovar aí por mais seis meses se você quiser. É bem bem tranquilo quanto a isso. Você pode dar sequência no acompanhamento, caso você queira.  
   
 

### 01:07:23

   
**Dr Marcos Gesuele:** Tá? A outra dúvida que eu tenho é na questão das vendas, é importante a gente com o tempo eh montar um time de vendas ou só a nossa equipe dá  
**Evelyn La:** Só a equipe de vocês dá conta,  
**Dr Marcos Gesuele:** conta?  
**Evelyn La:** tá? E antes de contratar qualquer outra pessoa, seja para venda ou seja pro pré-venda, primeiro estabelecer a previsibilidade, depois aí sim você dá o passo e ter mais alguém, né? Quando chega assim, está insustentável uma pessoa sozinha em fazer o que ela está fazendo. Por quê? Porque na venda, com o time que vocês estão,  
**Dr Marcos Gesuele:** Perfeito.  
**Evelyn La:** com a estrutura que vocês estão, é bem tranquilo. Dá para para executar isso aqui para chegar no objetivo que vocês estão. É tranquilo.  
**Dr Marcos Gesuele:** Tá.  
**Evelyn La:** Agora, por exemplo, a Evelyn daqui três, daqui 4 meses, poxa, agora eu quero chegar a 200, a 300, a 400\. Aí a gente tá falando de um gap maior de faturamento, aonde a gente vai precisar novamente ter o quê? Mais pessoas, talvez no pré-venda e uma na venda para aí sim você conseguir dar conta de em relação a isso, tá? que é o que aconteceu com a Débora, por exemplo.  
   
 

### 01:08:43

   
**Evelyn La:** A Débora hoje ela tem três pessoas no time comercial, porque ela ela tá faturando os 490, 500 ali na média, mas hoje ela tá com três pessoas, mas não começou assim, né? A gente foi indo escalando aos poucos, conforme foi tendo a necessidade, a gente foi trazendo outros pro time, enfim.  
**Dr Marcos Gesuele:** Perfeito. Beleza.  
**Evelyn La:** Tá,  
**Dr Marcos Gesuele:** Tem mais alguma dúvida, R? Então, de dúvida foi isso.  
**Evelyn La:** Luca. Luca, tem alguma dúvida? Luca,  
**lucca elias:** Não,  
**Rosana Mara Dias de Oliveira Elias:** Não.  
**lucca elias:** não tenho nenhuma.  
**Evelyn La:** que que você achou do acompanhamento ali da execução,  
**lucca elias:** Eu eu achei bem legal assim,  
**Evelyn La:** Luca?  
**lucca elias:** vai dar pra gente trabalhar bastante coisa e assim, não acho que eu já tinha escutado bastante coisa, participado de algumas reuniões de marketing, só que nunca consegui colocar em frente,  
**Evelyn La:** Uhum.  
**lucca elias:** né, nessa questão. No.  
**Evelyn La:** Sim, sim. É, a gente aqui pega na mão mesmo e vou te falar, as meninas da entrega ficam em cima ali, viu? Não tem corpo mole não com elas.  
**lucca elias:** É, não, eu imagino.  
   
 

### 01:09:44

   
**Dr Marcos Gesuele:** Legal.  
**Evelyn La:** É porque assim, a a gente a gente entende que vai ter dias que vai tá muito bom,  
**Dr Marcos Gesuele:** при  
**Evelyn La:** vai ter semanas que vai estar muito boa, mas vai ter semana que vai tá osso. E se você não tá ali com time muitas vezes eh para te ajudar, para tirar eh dúvida, para te fazer olhar para uma solução, para te direcionar às vezes para alguma coisa específica, a gente acaba eh decaindo a energia. Isso vai influenciando em várias coisas. Então, ah, nesse nesse aspecto, nós temos um acompanhamento muito próximo e as meninas da nossa entrega são muito fantásticas assim, de verdade. Não é porque eu tô no time, né, já fazendo meu jabá, né, não é, mas de fato a gente tem esse pegar na mão aí bem bem executado, tá?  
**Dr Marcos Gesuele:** Perfeito.  
**Evelyn La:** Vamos lá, parceria então de aceleração. Vamos falar de de preço agora. Vamos falar, vamos lá pro financeiro agora. Vamos ver eh o que que a gente conseguiria, quem sabe talvez eh ajudar vocês nesse ponto, né?  
**Dr Marcos Gesuele:** Me empresta.  
**Evelyn La:** Quanto vale? Oi, Marcos.  
**Dr Marcos Gesuele:** empresta R, R$  
**Evelyn La:** Ô, mas agora vamos lá, meu amigo. Pera aí que eu vou te Mas vamos lá.  
   
 

### 01:10:58

   
**Dr Marcos Gesuele:** 300,  
**Evelyn La:** Quanto vale, né? Quanto vale o preço de fato para entrar no programa? Ele tem diferença. Eu sempre falo assim, hoje quanto vale um imóvel num bairro mais nobre aí de São Paulo? São Paulo, tô falando de São Paulo, tô falando casa de 10 milhões quase, né? Mais,  
**Dr Marcos Gesuele:** por aí.  
**Evelyn La:** né? Por aí, né?  
**Dr Marcos Gesuele:** É por aí. E tem até mais.  
**Evelyn La:** Tem mais,  
**Dr Marcos Gesuele:** Tem cas aqui de 50 milhões,  
**Evelyn La:** né?  
**Dr Marcos Gesuele:** 60  
**Evelyn La:** Se se a gente passa, né,  
**Dr Marcos Gesuele:** milhões.  
**Evelyn La:** sabendo o valor da casa, passa na frente e enxerga e tá escrito lá, vende-se por 1 milhão, por exemplo, se eu pegar uma casa de 10, eu vou achar caro ou barato?  
**Dr Marcos Gesuele:** Baratíssimo.  
**Evelyn La:** Baratíssimo, né? É a mesma coisa. O preço que você paga para acesso, ele é diferente ao valor que a gente entrega. Então, o nosso valor de entrega, falando valor aqui, ele é de 268.000, né, com todos os tudo que a gente tem. Isso é o valor de entrega.  
   
 

### 01:12:03

   
**Evelyn La:** Claro que esse não é o preço do programa, mas eu falo assim, ele valeria muito fácil se a gente fosse fazer cada pilar daquele lá de forma separada, né? Se eu criasse um produto para cada coisa ali, ele teria esse valor. Aí eu pergunto assim: "Se você tivesse hoje a possibilidade de ter 75% de desconto,  
**Dr Marcos Gesuele:** Zero.  
**Evelyn La:** vocês acreditam que valeria 67?" Falando ainda sobre valores aqui, tá?  
**Dr Marcos Gesuele:** Valores. Sim.  
**Evelyn La:** Rosana, você acredita que valeria?  
**Dr Marcos Gesuele:** Sim. Aconteceu aqui. Pera aí. Tem que arrancar agora. M.  
**Rosana Mara Dias de Oliveira Elias:** Agora foi. Sim, sim, sim. Valeria.  
**Evelyn La:** Assim como vocês vem valor, a Débora foi uma nossa que viu valor, foi a que, né, acreditou aí em 5 dias fez 103.000. A Dafne, que bateu 125 em 2 meses, o Maxuell e vários outros que eu não vou ficar lendo todos os depoimentos, senão a gente fica até amanhã aqui. Case, a gente tem case sim e a gente busca que cada um que entra aqui torne-se um case, inclusive.  
   
 

### 01:13:11

   
**Evelyn La:** Então, hoje o preço para entrar no programa com todos os nossos entregáveis, ele tem o valor de 51 à vista ou 8 vezes de 740\. Esse é o preço do programa, tá? Para todos aqueles entregáveis ali. A minha pergunta para vocês é questão financeira, já entendi. Mas se fôssemos para fazer uma parceria hoje, colocar de fato em prática tudo isso e a gente conseguir adequar um valor que fique aí de parcela. Uma negociação, eu digo até mesmo, né? É uma negociação realmente pra gente começar. Vocês começariam isolando o fator preço? Tariam execução.  
**Dr Marcos Gesuele:** is isolando o fator preço, sem dúvida. E e assim,  
**Evelyn La:** Certo?  
**Dr Marcos Gesuele:** meu problema não é fazer ou não fazer, é pagar ou deixar de  
**Evelyn La:** Certo. Entendi.  
**Dr Marcos Gesuele:** pagar.  
**Evelyn La:** Marcos sobre esse valor aí. Me diga uma coisa. O que que a gente talvez conseguiria negociar para ficar mais fácil da sua entrada? Porque ao longo do processo você vai com certeza aí colhendo fruto, né? E a que que é minha a ideia? A ideia é você ter a porta de entrada para que ao longo do processo o próprio processo te dê o retorno de pagamento, entendeu?  
   
 

### 01:14:39

   
**Dr Marcos Gesuele:** É exatamente isso que eu penso agora. Qual seria o valor mínimo para eu começar? falar: "Ah, Marcos, a gente aceita trabalhar com isso. No mês que a gente trabalhar, eu já vou recuperar isso e já vou ter a segunda parcela. Porque, meu, se eu fizer isso e no primeiro mês, eu já pago o valor à vista, entendeu? Vou lá e pago a vista,  
**Evelyn La:** Sim,  
**Dr Marcos Gesuele:** porque eu não tenho problema.  
**Evelyn La:** claro.  
**Dr Marcos Gesuele:** Vocês vão ter controle, inclusive. Eh,  
**Evelyn La:** Se  
**Dr Marcos Gesuele:** eu e eu eu posso pegar todo o meu primeiro investimento e jogar direto na empresa. Problema problema é o investimento inicial.  
**Evelyn La:** Uhum.  
**Dr Marcos Gesuele:** É, é onde onde eu eu breco.  
**Evelyn La:** É o começo.  
**Dr Marcos Gesuele:** Eu não cartão de crédito,  
**Evelyn La:** Uhum.  
**Dr Marcos Gesuele:** eu não tô lesionado  
**Evelyn La:** Certo.  
**Dr Marcos Gesuele:** financeiramente.  
**Evelyn La:** Se fosse pra gente trabalhar uma entrada, você teria condições hoje no Pix?  
**Dr Marcos Gesuele:** Eh, dependendo do valor da entrada, eu vou correr atrás e fazer,  
**Evelyn La:** Tá,  
**Dr Marcos Gesuele:** entende?  
**Evelyn La:** entendi. Deixa eu abrir meu meu o meu painel financeiro aqui de propostas.  
   
 

### 01:15:42

   
**Evelyn La:** Pera aí. Para eu que daí eu jogo a proposta para ir ver se ele me autoriza. Hoje você não teria nenhum cartão, Marcos.  
**Dr Marcos Gesuele:** Não, não tenho nada. Tá tudo estourado. O meu nome tá estourado. Para você ter uma ideia. Não é só o cartão que tá estourado, né? Não sei se eles passaram para você o que aconteceu,  
**Evelyn La:** Ага.  
**Dr Marcos Gesuele:** mas nós tivemos um alaramento dentro do consultório, perdemos todo o material, temos o consultório, tive que entregar o consultório, tive uma multa de R$ 50.000,  
**Evelyn La:** Gustavo.  
**Dr Marcos Gesuele:** exatamente isso que você tá me mostrando. Foi a multa que eu tive pelos dois elevadores, eh, que queimaram. Então, eu capitalizei totalmente,  
**Evelyn La:** F.  
**Dr Marcos Gesuele:** né, e tive que mudar de consultório porque acabei não conseguindo pagar o aluguel. Eh, e aí virou uma bola de neve,  
**Evelyn La:** Na bola de neve.  
**Dr Marcos Gesuele:** né?  
**Evelyn La:** Sim.  
**Dr Marcos Gesuele:** Então nós fomos para esse consultório da da Catão, que é um prédio muito bom, legal, mas eu peguei um consultório pequenininho.  
   
 

### 01:16:39

   
**Dr Marcos Gesuele:** Eu tinha um consultório que tinha um 120 m², né?  
**Evelyn La:** Certo.  
**Dr Marcos Gesuele:** Passei para um consultório que tem hoje 30, 35 m. Tem 30\.  
**Evelyn La:** Uhum. Ô Marcos, você conseguiria hoje cinco de entrada?  
**Dr Marcos Gesuele:** Quando você fala hoje, é agora. Não,  
**Evelyn La:** Isso na  
**Dr Marcos Gesuele:** agora eu não consigo. Eu tenho que correr atrás disso no na semana.  
**Evelyn La:** semana teria que ser  
**Dr Marcos Gesuele:** É.  
**Evelyn La:** certo. Hoje não não teria nada nada.  
**Dr Marcos Gesuele:** Nada, nada. Tem tem uma conta negativa com os caras me ligando aqui para pagar um monte de gente  
**Evelyn La:** Certo.  
**Dr Marcos Gesuele:** cobrando.  
**Evelyn La:** Só para questão de segurar a proposta não teria nada,  
**Dr Marcos Gesuele:** Não tenho,  
**Evelyn La:** nada.  
**Dr Marcos Gesuele:** não tenho mesmo.  
**Evelyn La:** Só um minutinho que o meu interfone tocou aqui. Pera aí. Agora sou eu que vou ter que segundinho. Oi. Pode liberar que ele veio deixar o leitor. É o meu pequeno chegando à escola. Tá. Vamos lá,  
**Dr Marcos Gesuele:** Nesse de trabalho,  
**Evelyn La:** Marcos. Hã.  
   
 

### 01:18:13

   
**Dr Marcos Gesuele:** né? Quanto tempo nesse fluxo que você me apresenta?  
**Evelyn La:** Oi.  
**Dr Marcos Gesuele:** Em quanto tempo eu vou ter pelo menos o primeiro paciente?  
**Evelyn La:** Ah, no primeiro mês. Primeiro mês já.  
**Dr Marcos Gesuele:** No primeiroente, né?  
**Evelyn La:** principalmente essa parte de paciente modelo ali para você ter case eh das cirurgias seria a a primeira semana a gente já trabalharia os protocolos de caixa justamente para aumentar seu faturamento, fazer girar faturamento, né, na verdade, e dessa base a gente já pescar a paciente modelo para você,  
**Dr Marcos Gesuele:** Certo?  
**Evelyn La:** né,  
**Dr Marcos Gesuele:** E essa base seria a minha base de dados atual no consultório.  
**Evelyn La:** que você tem atual.  
**Dr Marcos Gesuele:** É isso,  
**Evelyn La:** Exato. Começaríamos por aí,  
**Dr Marcos Gesuele:** tá?  
**Evelyn La:** mas claro, já eh trabalhando as estratégias para captações novas também ali de tráfego depois, né, e tudo  
**Dr Marcos Gesuele:** Certo?  
**Evelyn La:** mais.  
**Dr Marcos Gesuele:** É, R$ 5.000 não é muito diferente do sete, né? que seria o o primeiro primeiro  
**Evelyn La:** Primeira parcela. Uhum. É, eh,  
**Dr Marcos Gesuele:** É.  
**Evelyn La:** para eu conseguir, eh, até mesmo segurar para você alguma proposta, eu precisaria de fato um algum compromisso do teu lado financeiro, entendeu?  
   
 

### 01:19:30

   
**Evelyn La:** Ou uma entrada, alguma coisa nesse sentido. Que daí que que eu faria? Eu tentaria conversar com o Renan aqui, já ligaria para ele até posso até dar uma ligadinha agora pra gente ver o que que a gente conseguiria fazer nesse sentido de trazer talvez alguma recorrência para você para facilitar mesmo, entende?  
**Dr Marcos Gesuele:** Tá assim,  
**Evelyn La:** E a gente fazendo  
**Dr Marcos Gesuele:** ó. Vamos fazer assim. Eh,  
**Evelyn La:** junto,  
**Dr Marcos Gesuele:** deixa eu ver o consigo de de de de de levantar dinheiro, porque a gente tem que correr atrás de alguns pacientes, ver o que a gente consegue.  
**Evelyn La:** certo?  
**Dr Marcos Gesuele:** E voltamos a nos falar no começo da semana.  
**Evelyn La:** Pode ser.  
**Dr Marcos Gesuele:** Pode ser que aí aí faz que aí fala:  
**Evelyn La:** Claro, Marcos. Claro, com  
**Dr Marcos Gesuele:** "Olha, o que eu consigo verdadeiramente é isso,  
**Evelyn La:** certeza.  
**Dr Marcos Gesuele:** porque veja bem, hoje é dia 11, 12, 12, 13 hoje, né? Dia 13\.  
**Evelyn La:** Uhum.  
**Dr Marcos Gesuele:** Eh, tudo que tem que cair cai agora. pagamento eh eh é daqui pro dia 15 é tudo que tem cair cai agora.  
   
 

### 01:20:22

   
**Evelyn La:** Sei.  
**Dr Marcos Gesuele:** Ou seja, eu tenho algumas dificuldades que eu e e dívidas que eu não posso adiar,  
**Evelyn La:** Sim.  
**Dr Marcos Gesuele:** né? Então, mas é viável fazer assim.  
**Evelyn La:** Vamos fazer o seguinte,  
**Dr Marcos Gesuele:** E qual éa que eu tenho as garantias que a empresa  
**Evelyn La:** eu Oi.  
**Dr Marcos Gesuele:** me dá?  
**Evelyn La:** Certo. Questão de garantia. Esse é um é um ponto bem eh eu diria delicado no sentido de que não tem como nós ofertarmos uma garantia 100% pelo fato de que é um trabalho que a gente precisa que a outra parte seja também comprometida em execução. Então não tem como eu dar garantia do meu da minha estratégia se ela não for executada,  
**Dr Marcos Gesuele:** S tá  
**Evelyn La:** entendeu? Mas todos os entregáveis eles vão para contrato, né? dependendo da negociação que a gente faça, ela tá em contrato também. Então assim, quanto a isso é tranquilo. Mas vamos fazer o seguinte, eh, verifica essa possibilidade de entrada e eu vou conversar com o Renan e com o Mateus ali  
**Dr Marcos Gesuele:** Tá.  
**Evelyn La:** sobre isso, sobre a gente poder eh facilitar essa entrada para você e você de fato eh pegar uma recorrência aí e conforme você vai fazendo, você vai pagando.  
**Dr Marcos Gesuele:** É, eu preciso de uma oportunidade de começar.  
   
 

### 01:21:40

   
**Evelyn La:** Pronto.  
**Dr Marcos Gesuele:** Você fala, Marcos, ó, faz assim, vamos começar. No primeiro caso, eu tenho certeza que você já vai levantar tanto, a gente vai fazer. Cara, eu não tenho problema porque você sabe que cirurgia de face não tem  
**Evelyn La:** É,  
**Dr Marcos Gesuele:** gasto.  
**Evelyn La:** e o ticket dela de lucratividade é alto,  
**Dr Marcos Gesuele:** Exato. Então,  
**Evelyn La:** entendeu?  
**Dr Marcos Gesuele:** se acreditarem,  
**Evelyn La:** É só você ter paciente hoje para você fazer.  
**Dr Marcos Gesuele:** se vocês acreditarem em mim, eh, no meu potencial, eu estamos aí, vamos fazer. Eu acho que tem para sim. Não, como te falei, não sou nem menino. Aliás, eu estou iniciando uma uma residência hospitalar na área de cirurgia  
**Evelyn La:** Sì.  
**Dr Marcos Gesuele:** e traumatologia. maxilo facial para poder inclusive aprimorar o o a qualidade do meu atendimento cirúrgico,  
**Evelyn La:** Muito bom.  
**Dr Marcos Gesuele:** né?  
**Evelyn La:** Sim,  
**Dr Marcos Gesuele:** Então isso tá para acontecer.  
**Evelyn La:** sim.  
**Dr Marcos Gesuele:** Conversa aí com com o Renan e vê o que fazer.  
**Evelyn La:** Vou conversar para deixar.  
**Dr Marcos Gesuele:** Eu quero quero muito fazer, Evelyn, mas eu vou ser sincero.  
   
 

### 01:22:39

   
**Evelyn La:** Ah,  
**Dr Marcos Gesuele:** Não adianta falar para você, eu vou fazer e não faço.  
**Evelyn La:** sim.  
**Dr Marcos Gesuele:** E eu eu vou ficar com um cara de de desonesto. Você fala: "Ah, o cara falou que ia pagar e não pagou". Não é que eu não sou que eu sou desonesto, é que eu não tenho condições de pagar  
**Evelyn La:** Sim. É,  
**Dr Marcos Gesuele:** mesmo.  
**Evelyn La:** é o momento mesmo, tá? Mas vamos fazer isso, vamos, vamos manter contato, eh, e aí eu vou conversar com o Renão, vou conversar com o Mateus.  
**Dr Marcos Gesuele:** Tá  
**Evelyn La:** Semana que vem a gente volta a se falar aí. Aí eu te dou uma ligadinha pelo Whats  
**Dr Marcos Gesuele:** como você preferir, tá bom?  
**Evelyn La:** DD 45, tá? Eu sempre aviso porque às vezes o pessoal vê o número diferente, ele fala:  
**Dr Marcos Gesuele:** Tá.  
**Evelyn La:** "E vou atender essa daqui".  
**Dr Marcos Gesuele:** É, salvar é esse número aqui, né?  
**Evelyn La:** É esse número aí que tá no grupo ali.  
**Dr Marcos Gesuele:** Tá,  
**Evelyn La:** Uhum.  
**Dr Marcos Gesuele:** eu vou salvar meu telefone não atende não,  
**Evelyn La:** que eu fiz a configuração.  
**Dr Marcos Gesuele:** ele recusa,  
**Evelyn La:** Ah,  
**Dr Marcos Gesuele:** tá?  
**Evelyn La:** certo.  
**Dr Marcos Gesuele:** Mas qualquer coisa me avisa via WhatsApp que você tá,  
**Evelyn La:** Uhum.  
**Dr Marcos Gesuele:** ó,  
**Evelyn La:** Isso.  
**Dr Marcos Gesuele:** vou ligar agora que eu fico preparado,  
**Evelyn La:** Isso. Exato. Maravilha.  
**Dr Marcos Gesuele:** tá bom?  
**Evelyn La:** Tá bom, pessoal.  
**Dr Marcos Gesuele:** É.  
**Evelyn La:** Foi o prazer aí conhecer um pouquinho mais de vocês, saber que tem potencial aí pra gente poder ajudá-los. E vamos, vou conversar com o Renan aqui para ver se a gente consegue essa facilitar um pouquinho a entrada e a gente fazer acontecer, tá bom?  
   
 

### A transcrição foi encerrada após 01:24:14

*Esta transcrição editável foi gerada por computador e pode conter erros. As pessoas também podem alterar o texto depois que ele for criado.*', '# AUDITORIA DE CALL — Evelyn x Dr. Marcos Gesuele
**Data:** 13/03/2026 | **Duração:** 84 min | **Resultado:** Não fechamento - Objeção financeira não resolvida

---

## 1. RESUMO EXECUTIVO

Call com desempenho fraco devido à falta de estrutura e protocolo. Closer não seguiu metodologia adequada, permitiu divagações excessivas sobre origem italiana (12+ minutos), falhou em qualificar adequadamente o budget e não isolou objeções antes da apresentação. Proporção de fala desequilibrada (closer ~60%), apresentação genérica sem conexão com diagnóstico específico, e objeção financeira tratada de forma superficial. Lead demonstrou interesse genuíno na metodologia, mas closer não conseguiu estruturar uma proposta adequada para o cenário financeiro restritivo. Score final baixo por múltiplas falhas estruturais.

---

## 2. SCORECARD

| # | Dimensão | Peso | Nota | Ponderada | Evidência |
|---|---|---|---|---|---|
| 1 | Frame e Liderança | 8% | 3,0 | 0,24 | Agenda indefinida, rapport excessivo (12+ min origem italiana) |
| 2 | Qualificação Preliminar | 10% | 2,0 | 0,20 | Budget obtido tardiamente, decisor confirmado, urgência superficial |
| 3 | Diagnóstico Quantitativo | 12% | 5,0 | 0,60 | Faturamento, ticket médio obtidos, mas outras métricas ausentes |
| 4 | Diagnóstico Qualitativo | 8% | 6,0 | 0,48 | Lead verbalizou dor ("desânimo", "crise financeira") |
| 5 | Perguntas de Consequência | 10% | 1,0 | 0,10 | Nenhuma pergunta NEPQ estruturada |
| 6 | Ensino Comercial | 5% | 3,0 | 0,15 | Mencionou ICP/matriz, mas sem profundidade |
| 7 | Reframe de Identidade | 5% | 2,0 | 0,10 | Tentativas fracas, sem trabalhar crenças limitantes |
| 8 | Ancoragem de Valor | 10% | 4,0 | 0,40 | Value stack apresentado, mas desconectado do diagnóstico |
| 9 | Isolamento de Objeção | 10% | 1,0 | 0,10 | Não isolou financeiro antes do preço |
| 10 | Proporção de Fala | 8% | 2,0 | 0,16 | Closer ~60% do tempo, lead ~40% |
| 11 | Segurança de Promessas | 8% | 3,0 | 0,24 | Algumas promessas genéricas, mas sem grandes riscos |
| 12 | Checkpoints | 3% | 4,0 | 0,12 | Alguns checkpoints durante apresentação |
| 13 | Controle e Fechamento | 3% | 2,0 | 0,06 | Próximos passos vagos, sem controle final |

**SCORE FINAL: 2,95/10 — CALL FRACA**

---

## 3. ANÁLISE BLOCO A BLOCO

### [00:00:00–04:03] — Abertura Técnica | Fase 1
**O que aconteceu:** Questões técnicas de conexão, múltiplos participantes entrando gradualmente, closer esperou organização
**Frameworks aplicados:** Nenhum específico
**Frameworks ausentes:** Frame de liderança, controle da agenda
**Pontos fortes:** Paciência com questões técnicas
**Erros:** Não assumiu liderança imediata, permitiu desorganização prolongada
**Veredicto do bloco:** 4/10

### [04:03–12:55] — Rapport Excessivo | Fase 1
**O que aconteceu:** Apresentação da closer, breve explicação da empresa, mas derivou para conversa de 8+ minutos sobre origem italiana das famílias
**Frameworks aplicados:** Rapport (mal executado)
**Frameworks ausentes:** Frame de três intenções, controle de tempo
**Pontos fortes:** Conexão pessoal estabelecida
**Erros:** [GRAVIDADE ALTA] Rapport desproporcional (8+ min sobre Itália), não estabeleceu agenda nem frame profissional
**Veredicto do bloco:** 2/10

### [12:55–20:36] — Diagnóstico Inicial | Fase 2
**O que aconteceu:** Mapeamento da estrutura (consultório do Luca, Marcos atende em múltiplos locais, Rosana administra), descoberta da nova área (cirurgia facial), experiência negativa com tráfego pago
**Frameworks aplicados:** SPIN parcial (situação e problema)
**Frameworks ausentes:** Qualificação preliminar adequada, perguntas de consequência
**Pontos fortes:** Descobriu estrutura familiar, nova área de atuação, experiências anteriores
**Erros:** Não qualificou budget antecipadamente, não testou decisor claramente
**Veredicto do bloco:** 6/10

### [20:36–28:16] — Objetivos e Métricas | Fase 2 continuação
**O que aconteceu:** Meta de R$60k mensal revelada, ticket médio 12-13k (implantes) e 14-17k (carga imediata), 2 cirurgias/mês atual, desejo de chegar a 4/mês
**Frameworks aplicados:** SPIN situação, diagnóstico quantitativo parcial
**Frameworks ausentes:** Perguntas de implicação, cálculo de gap financeiro
**Pontos fortes:** Métricas objetivas obtidas, meta clara estabelecida
**Erros:** Não calculou potencial de crescimento, não explorou urgência
**Veredicto do bloco:** 7/10

### [28:16–34:02] — Apresentação da Metodologia | Fase 5 (prematura)
**O que aconteceu:** Closer apresentou metodologia "Face 100K" com 8 pilares, mencionou cases como Débora (100k→490k)
**Frameworks aplicados:** Value stacking, social proof
**Frameworks ausentes:** Isolamento de objeções, validação prévia
**Pontos fortes:** Estrutura clara da metodologia, cases específicos
**Erros:** [GRAVIDADE ALTA] Apresentação prematura sem isolamento de objeções, prometeu resultados sem disclaimers
**Veredicto do bloco:** 4/10

### [52:39–58:15] — Validação e Objeções | Fase 4 (tardia)
**O que aconteceu:** Marcos expressou desânimo, experiências negativas anteriores, mas validou metodologia como "diferente" e "coerente"
**Frameworks aplicados:** Challenger sale parcial
**Frameworks ausentes:** Isolamento financeiro adequado
**Pontos fortes:** Lead validou metodologia, verbalizou dor emocional ("desânimo")
**Erros:** Não isolou objeção financeira antes de apresentar preço
**Veredicto do bloco:** 5/10

### [58:15–01:14:39] — Apresentação de Preço e Negociação | Fase 5-6
**O que aconteceu:** Preço apresentado (R$51k à vista ou 8x R$7.400), lead confirmou objeção financeira apenas, tentativa de negociação com entrada reduzida
**Frameworks aplicados:** Ancoragem, tentativa de isolamento tardio
**Frameworks ausentes:** Isolamento prévio, técnicas de fechamento estruturadas
**Pontos fortes:** Tentou encontrar solução para objeção financeira
**Erros:** [GRAVIDADE ALTA] Não isolou objeção antes, negociação sem estrutura, não conseguiu fechar nem próximos passos concretos
**Veredicto do bloco:** 3/10

---

## 4. MAPA DE FRAMEWORKS

| Framework | Presença (0-10) | Onde aplicou | Onde faltou | Impacto |
|---|---|---|---|---|
| Hormozi (CLOSER) | 2/10 | Parcial na apresentação | C.L.O.S.E.R. completo | Alto - estrutura ausente |
| Miner (NEPQ) | 1/10 | Nenhuma aplicação clara | Perguntas de consequência | Crítico - sem urgência criada |
| Belfort (Straight Line) | 3/10 | Tentou controlar na negociação | Controle durante toda call | Alto - perdeu direção |
| Cole Gordon | 4/10 | Frame inicial fraco | Isolamento adequado | Alto - objeções não tratadas |
| Eli Wilde | 2/10 | Tentativas superficiais | Reframe identitário profundo | Médio - sem mudança de crença |
| Dan Lok | 2/10 | Posição de autoridade fraca | Postura de "médico" | Alto - virou vendedor pedinte |
| Rackham (SPIN) | 5/10 | Situação e problema parciais | Implicação e necessidade | Alto - diagnóstico incompleto |
| Challenger Sale | 3/10 | Menção a ICP/matriz | Ensino comercial estruturado | Médio - sem insights únicos |
| Sabri Suby | 4/10 | Value stack apresentado | Oferta irrecusável | Alto - sem urgência de compra |
| Brad Lea | 2/10 | Nenhuma antecipação clara | 4 objeções universais | Alto - objeções surpreenderam |

---

## 5. TOP 5 ACERTOS
1. **Diagnóstico quantitativo parcial** — [20:36-28:16] — Conseguiu extrair métricas importantes: ticket médio (12-13k), volume atual (2/mês), meta (4/mês), objetivo financeiro (60k/mês)
2. **Descoberta da dor emocional** — [53:05-55:05] — Lead verbalizou desânimo e frustração: "tanta gente já prometeu tanta coisa para mim"
3. **Validação da metodologia** — [55:05-58:15] — Lead confirmou que metodologia "é diferente de tudo que me apresentaram até hoje"
4. **Flexibilidade na negociação** — [01:14:39-01:22:39] — Tentou encontrar alternativas para objeção financeira, mostrou disposição para adequar proposta
5. **Mapeamento familiar** — [08:10-14:05] — Identificou estrutura familiar (pai/filho/esposa), papéis definidos, Rosana como comercial

---

## 6. TOP 5 ERROS (por gravidade)
1. **[GRAVIDADE ALTA] Rapport desproporcional** — [04:03-12:55] — Perdeu 8+ minutos falando sobre origem italiana, não estabeleceu frame profissional nem agenda
2. **[GRAVIDADE ALTA] Ausência de perguntas NEPQ** — [Toda a call] — Não fez nenhuma pergunta de consequência estruturada tipo "o que acontece se nada mudar nos próximos 12 meses?"
3. **[GRAVIDADE ALTA] Apresentação sem isolamento prévio** — [28:16-52:39] — Apresentou metodologia completa sem isolar objeções, descobriu resistência financeira apenas no final
4. **[GRAVIDADE MÉDIA-ALTA] Proporção de fala desequilibrada** — [Toda a call] — Closer falou ~60% do tempo, lead apenas ~40%, invertendo proporção ideal
5. **[GRAVIDADE MÉDIA-ALTA] Negociação sem estrutura** — [01:14:39-fim] — Tentou negociar sem técnicas adequadas, não conseguiu fechar nem próximos passos concretos

---

## 7. REESCRITA DE MOMENTOS CRÍTICOS

### Momento 1: [04:03-12:55] — Rapport excessivo sobre Itália
**O QUE FOI DITO:** "É do lado de Milão ali... nossa família é mais calabres, é um povo mais nervosinho... Lampunhano, nome muito bonito..."
**O QUE DEVERIA TER SIDO DITO:** "Que legal, origem italiana! Tenho certeza que isso trouxe valores de família forte pro negócio de vocês. Falando nisso, deixa eu organizar nossa agenda de hoje. Tenho três objetivos: primeiro, entender exatamente onde vocês estão e aonde querem chegar. Segundo, avaliar se nossa metodologia faz sentido pro momento de vocês. Terceiro, se tudo alinhar, mostrar como podemos ser parceiros. Combinado? E antes de começar, quem toma as decisões de investimento na clínica - é você, Marcos, ou vocês decidem em conjunto?"
**POR QUÊ:** Cole Gordon - Frame inicial nos primeiros 3 minutos + qualificação do decisor
**IMPACTO ESTIMADO:** Controle da call, tempo otimizado, qualificação antecipada

### Momento 2: [20:36-28:16] — Oportunidade de NEPQ perdida
**O QUE FOI DITO:** [Após descobrir crise financeira] "Deixa eu colocar aqui... qual que é o Instagram que vocês usam?"
**O QUE DEVERIA TER SIDO DITO:** "Marcos, você falou em crise financeira. Me ajuda a entender: se nos próximos 12 meses nada mudar nesse cenário, o que acontece com o consultório? [ESPERAR RESPOSTA] E você, com 36 anos de experiência, tendo que se preocupar todo mês se vai conseguir pagar as contas - como isso afeta você pessoalmente? Sua paz, seu sono, sua família?"
**POR QUÊ:** Jeremy Miner NEPQ - Perguntas de consequência são críticas para criar urgência
**IMPACTO ESTIMADO:** Urgência emocional criada, lead sentiria que não mudar é mais caro que investir

### Momento 3: [53:05-58:15] — Isolamento de objeções
**O QUE FOI DITO:** "Qual é a proposta que vocês têm pra gente. Mas falou é muito coerente."
**O QUE DEVERIA TER SIDO DITO:** "Perfeito, Marcos. Você validou que a metodologia faz sentido e é diferente do que já viu. Agora, isolando completamente o fator financeiro - se conseguíssemos adequar um investimento que fizesse sentido pro momento de vocês, hoje vocês começariam? [AGUARDAR SIM] Além da questão financeira, existe mais alguma coisa que impediria vocês de tomar essa decisão?"
**POR QUÊ:** Cole Gordon - Isolamento de objeções antes da apresentação de preço
**IMPACTO ESTIMADO:** Objeções mapeadas, negociação focada apenas no financeiro

---

## 8. PLANO DE AÇÃO

### Recomendação 1: Protocolo de Rapport Controlado
- **O que fazer:** Limitar rapport inicial a 3-5 minutos máximo, com timer
- **Por quê:** 12+ minutos de conversa italiana mataram momentum e credibilidade
- **Como treinar:** Praticar transições: "Que legal! Falando nisso..." + agenda imediata
- **Prioridade:** ALTA

### Recomendação 2: Masterizar NEPQ
- **O que fazer:** Decorar e praticar perguntas de consequência padrão
- **Por quê:** Zero perguntas NEPQ na call - framework mais importante para urgência
- **Como treinar:** Role play diário com perguntas: "O que acontece se nada mudar?" 
- **Prioridade:** ALTA

### Recomendação 3: Qualificação nos primeiros 10 minutos
- **O que fazer:** Budget, decisor, urgência ANTES de qualquer apresentação
- **Por quê:** Descobriu objeção financeira apenas aos 53 minutos
- **Como treinar:** Script decorado: "Que tipo de investimento mensal vocês tinham em mente?"
- **Prioridade:** ALTA

### Recomendação 4: Isolamento de Objeções Obrigatório
- **O que fazer:** Nunca apresentar preço sem isolar objeções antes
- **Por quê:** Call terminou em "vamos ver" por falta de isolamento
- **Como treinar:** Frase decorada: "Isolando o fator financeiro, hoje vocês fechariam?"
- **Prioridade:** ALTA

### Recomendação 5: Controle de Proporção de Fala
- **O que fazer:** Implementar regra 70/30 (lead/closer) até apresentação
- **Por quê:** Closer falou 60%, lead apenas 40% - inversão crítica
- **Como treinar:** Timer e contagem de palavras em gravações
- **Prioridade:** MÉDIA

---

## 9. ALERTAS DE PROMESSA
**Frase de risco:** "É muito possível isso, mas não é milagroso" [31:43]
**Versão segura:** "Cases similares têm conseguido esses números, mas depende da execução da metodologia"

**Frase de risco:** "A gente tem case sim e a gente busca que cada um que entra aqui torne-se um case" [01:13:11]
**Versão segura:** "Temos diversos cases de sucesso, e nossa metodologia é desenhada para maximizar as chances de resultado"

---

## 10. ANÁLISE DE SENTIMENTO DO LEAD

### Sentimento Geral
- **Sentimento:** Misto (inicialmente positivo, depois cauteloso)
- **Score de Sentimento:** 0.1 (levemente positivo, mas com reservas significativas)
- **Nível de Engajamento:** Médio-Alto

### Timeline de Sentimento
| Trecho | Sentimento | Confiança (0-1) | Momento-Chave |
|--------|-----------|-----------------|---------------|
| 00:00-10:00 | neutro/positivo | 0.8 | Abertura cordial, questões técnicas |
| 10:00-20:00 | positivo | 0.9 | Rapport forte (origem italiana) |
| 20:00-35:00 | engajado/otimista | 0.8 | Compartilhou objetivos e métricas |
| 35:00-55:00 | interessado | 0.7 | Ouviu metodologia atentamente |
| 55:00-01:10:00 | conflituoso | 0.9 | Validou método mas expressou desânimo |
| 01:10:00-fim | preocupado/realista | 0.9 | Objeção financeira clara, transparência total |

### Objeções Detectadas
1. **Timestamp:** 17:25 | **Objeção:** "Já fizemos [tráfego], não deu certo... Veio desqualificado" | **Resposta do Closer:** Explicou ICP e matriz | **Efetividade:** boa
2. **Timestamp:** 53:05 | **Objeção:** "Tanta gente já prometeu tanta coisa... sempre é uma coisa muito linda" | **Resposta do Closer:** "Você é diferente" genérico | **Efetividade:** ruim
3. **Timestamp:** 58:15 | **Objeção:** "Meu problema é o financeiro" | **Resposta do Closer:** Tentou negociar entrada | **Efetividade:** ruim
4. **Timestamp:** 01:15:42 | **Objeção:** "Não tenho nada... meu nome tá estourado" | **Resposta do Closer:** Insistiu em entrada menor | **Efetividade:** ruim
5. **Timestamp:** 01:20:22 | **Objeção:** "Qual é a garantia que a empresa me dá?" | **Resposta do Closer:** "Não tem garantia 100%" | **Efetividade:** ruim

**Observação:** Lead foi extremamente transparente sobre limitações financeiras, mas closer não soube estruturar proposta adequada para o cenário restritivo.', '🔴 AUDITORIA: Elane x Marcos
📅 2026-03-13 | ⏱ 60min
📊 Score: 2.95/10 — FRACA

✅ Top Acertos:
1. Diagnóstico quantitativo parcial
2. Descoberta da dor emocional
3. Validação da metodologia

❌ Top Erros:
1. Rapport desproporcional
2. Ausência de perguntas NEPQ
3. Apresentação sem isolamento prévio', '[{"rank": 1, "title": "Rapport desproporcional", "severity": "GRAVIDADE ALTA", "description": "[04:03-12:55] — Perdeu 8+ minutos falando sobre origem italiana, não estabeleceu frame profissional nem agenda"}, {"rank": 2, "title": "Ausência de perguntas NEPQ", "severity": "GRAVIDADE ALTA", "description": "[Toda a call] — Não fez nenhuma pergunta de consequência estruturada tipo \"o que acontece se nada mudar nos próximos 12 meses?\""}, {"rank": 3, "title": "Apresentação sem isolamento prévio", "severity": "GRAVIDADE ALTA", "description": "[28:16-52:39] — Apresentou metodologia completa sem isolar objeções, descobriu resistência financeira apenas no final"}, {"rank": 4, "title": "Proporção de fala desequilibrada", "severity": "GRAVIDADE MÉDIA-ALTA", "description": "[Toda a call] — Closer falou ~60% do tempo, lead apenas ~40%, invertendo proporção ideal"}, {"rank": 5, "title": "Negociação sem estrutura", "severity": "GRAVIDADE MÉDIA-ALTA", "description": "[01:14:39-fim] — Tentou negociar sem técnicas adequadas, não conseguiu fechar nem próximos passos concretos"}]'::jsonb, '[{"rank": 1, "title": "Diagnóstico quantitativo parcial", "description": "[20:36-28:16] — Conseguiu extrair métricas importantes: ticket médio (12-13k), volume atual (2/mês), meta (4/mês), objetivo financeiro (60k/mês)"}, {"rank": 2, "title": "Descoberta da dor emocional", "description": "[53:05-55:05] — Lead verbalizou desânimo e frustração: \"tanta gente já prometeu tanta coisa para mim\""}, {"rank": 3, "title": "Validação da metodologia", "description": "[55:05-58:15] — Lead confirmou que metodologia \"é diferente de tudo que me apresentaram até hoje\""}, {"rank": 4, "title": "Flexibilidade na negociação", "description": "[01:14:39-01:22:39] — Tentou encontrar alternativas para objeção financeira, mostrou disposição para adequar proposta"}, {"rank": 5, "title": "Mapeamento familiar", "description": "[08:10-14:05] — Identificou estrutura familiar (pai/filho/esposa), papéis definidos, Rosana como comercial"}]'::jsonb, '[{"rank": 1, "title": "Protocolo de Rapport Controlado", "por_que": "12+ minutos de conversa italiana mataram momentum e credibilidade", "prioridade": "ALTA", "o_que_fazer": "Limitar rapport inicial a 3-5 minutos máximo, com timer", "como_treinar": "Praticar transições: \"Que legal! Falando nisso...\" + agenda imediata"}, {"rank": 2, "title": "Masterizar NEPQ", "por_que": "Zero perguntas NEPQ na call - framework mais importante para urgência", "prioridade": "ALTA", "o_que_fazer": "Decorar e praticar perguntas de consequência padrão", "como_treinar": "Role play diário com perguntas: \"O que acontece se nada mudar?\""}, {"rank": 3, "title": "Qualificação nos primeiros 10 minutos", "por_que": "Descobriu objeção financeira apenas aos 53 minutos", "prioridade": "ALTA", "o_que_fazer": "Budget, decisor, urgência ANTES de qualquer apresentação", "como_treinar": "Script decorado: \"Que tipo de investimento mensal vocês tinham em mente?\""}, {"rank": 4, "title": "Isolamento de Objeções Obrigatório", "por_que": "Call terminou em \"vamos ver\" por falta de isolamento", "prioridade": "ALTA", "o_que_fazer": "Nunca apresentar preço sem isolar objeções antes", "como_treinar": "Frase decorada: \"Isolando o fator financeiro, hoje vocês fechariam?\""}, {"rank": 5, "title": "Controle de Proporção de Fala", "por_que": "Closer falou 60%, lead apenas 40% - inversão crítica", "prioridade": "MÉDIA", "o_que_fazer": "Implementar regra 70/30 (lead/closer) até apresentação", "como_treinar": "Timer e contagem de palavras em gravações"}]'::jsonb, '[{"frase": "Temos diversos cases de sucesso, e nossa metodologia é desenhada para maximizar as chances de resultado", "descricao": ""}]'::jsonb, '[{"impact": "Controle da call, tempo otimizado, qualificação antecipada", "reason": "Cole Gordon - Frame inicial nos primeiros 3 minutos + qualificação do decisor", "original": "É do lado de Milão ali... nossa família é mais calabres, é um povo mais nervosinho... Lampunhano, nome muito bonito...", "rewritten": "Que legal, origem italiana! Tenho certeza que isso trouxe valores de família forte pro negócio de vocês. Falando nisso, deixa eu organizar nossa agenda de hoje. Tenho três objetivos: primeiro, entender exatamente onde vocês estão e aonde querem chegar. Segundo, avaliar se nossa metodologia faz sentido pro momento de vocês. Terceiro, se tudo alinhar, mostrar como podemos ser parceiros. Combinado? E antes de começar, quem toma as decisões de investimento na clínica - é você, Marcos, ou vocês decidem em conjunto?", "description": "[04:03-12:55] — Rapport excessivo sobre Itália"}, {"impact": "Urgência emocional criada, lead sentiria que não mudar é mais caro que investir", "reason": "Jeremy Miner NEPQ - Perguntas de consequência são críticas para criar urgência", "original": "[Após descobrir crise financeira] \"Deixa eu colocar aqui... qual que é o Instagram que vocês usam?", "rewritten": "Marcos, você falou em crise financeira. Me ajuda a entender: se nos próximos 12 meses nada mudar nesse cenário, o que acontece com o consultório? [ESPERAR RESPOSTA] E você, com 36 anos de experiência, tendo que se preocupar todo mês se vai conseguir pagar as contas - como isso afeta você pessoalmente? Sua paz, seu sono, sua família?", "description": "[20:36-28:16] — Oportunidade de NEPQ perdida"}, {"impact": "Objeções mapeadas, negociação focada apenas no financeiro", "reason": "Cole Gordon - Isolamento de objeções antes da apresentação de preço", "original": "Qual é a proposta que vocês têm pra gente. Mas falou é muito coerente.", "rewritten": "Perfeito, Marcos. Você validou que a metodologia faz sentido e é diferente do que já viu. Agora, isolando completamente o fator financeiro - se conseguíssemos adequar um investimento que fizesse sentido pro momento de vocês, hoje vocês começariam? [AGUARDAR SIM] Além da questão financeira, existe mais alguma coisa que impediria vocês de tomar essa decisão?", "description": "[53:05-58:15] — Isolamento de objeções"}]'::jsonb, '{"Dan Lok": {"score": 2.0, "impact": "Alto - virou vendedor pedinte", "where_applied": "Posição de autoridade fraca", "where_missing": "Postura de \"médico\""}, "Brad Lea": {"score": 2.0, "impact": "Alto - objeções surpreenderam", "where_applied": "Nenhuma antecipação clara", "where_missing": "4 objeções universais"}, "Eli Wilde": {"score": 2.0, "impact": "Médio - sem mudança de crença", "where_applied": "Tentativas superficiais", "where_missing": "Reframe identitário profundo"}, "Sabri Suby": {"score": 4.0, "impact": "Alto - sem urgência de compra", "where_applied": "Value stack apresentado", "where_missing": "Oferta irrecusável"}, "Cole Gordon": {"score": 4.0, "impact": "Alto - objeções não tratadas", "where_applied": "Frame inicial fraco", "where_missing": "Isolamento adequado"}, "Miner (NEPQ)": {"score": 1.0, "impact": "Crítico - sem urgência criada", "where_applied": "Nenhuma aplicação clara", "where_missing": "Perguntas de consequência"}, "Rackham (SPIN)": {"score": 5.0, "impact": "Alto - diagnóstico incompleto", "where_applied": "Situação e problema parciais", "where_missing": "Implicação e necessidade"}, "Challenger Sale": {"score": 3.0, "impact": "Médio - sem insights únicos", "where_applied": "Menção a ICP/matriz", "where_missing": "Ensino comercial estruturado"}, "Hormozi (CLOSER)": {"score": 2.0, "impact": "Alto - estrutura ausente", "where_applied": "Parcial na apresentação", "where_missing": "C.L.O.S.E.R. completo"}, "Belfort (Straight Line)": {"score": 3.0, "impact": "Alto - perdeu direção", "where_applied": "Tentou controlar na negociação", "where_missing": "Controle durante toda call"}}'::jsonb, '[]'::jsonb, 'test://marcos-2026-03-13.ogg', NULL, NULL, NULL, NULL, 'gemini-notes', 'claude-sonnet-4-20250514', 38839, 5353, 0.1968, '2026-03-25T04:20:50.313722+00:00', NULL, '2026-03-25T04:22:44.856971+00:00', '2026-03-25T04:34:48.094426+00:00', '2026-03-25T04:34:48.094426+00:00', '2026-03-25T04:20:50.313722+00:00', '2026-03-25T04:36:53.396222+00:00', 'mixed', '[{"sentiment": "positive", "confidence": 0.9, "key_moment": "Rapport forte (origem italiana)", "timestamp_range": "10:00-20:00"}]'::jsonb, 0.1, 'medium', '[{"objection": "Já fizemos [tráfego], não deu certo... Veio desqualificado", "timestamp": "17:25", "effectiveness": "good", "closer_response": "Explicou ICP e matriz"}, {"objection": "Tanta gente já prometeu tanta coisa... sempre é uma coisa muito linda", "timestamp": "53:05", "effectiveness": "poor", "closer_response": "Você é diferente\" genérico"}, {"objection": "Meu problema é o financeiro", "timestamp": "58:15", "effectiveness": "poor", "closer_response": "Tentou negociar entrada"}, {"objection": "Não tenho nada... meu nome tá estourado", "timestamp": "01:15:42", "effectiveness": "poor", "closer_response": "Insistiu em entrada menor"}, {"objection": "Qual é a garantia que a empresa me dá?", "timestamp": "01:20:22", "effectiveness": "poor", "closer_response": "Não tem garantia 100%"}]'::jsonb, '1.0', '75cf1096ca17b6b9', '94f54fba-e9e5-4756-9d2f-83af7e1d7a73/auditoria_2026-03-13_marcos.md');

INSERT INTO call_audits (id, organization_id, closer_id, lead_name, call_date, duration_minutes, resultado, valor_fechamento, status, error_message, score_final, classificacao, d01_frame, d02_qualificacao, d03_diag_quantitativo, d04_diag_qualitativo, d05_consequencia, d06_ensino, d07_identidade, d08_ancoragem, d09_isolamento, d10_proporcao_fala, d11_promessas, d12_checkpoints, d13_fechamento, transcricao, relatorio_completo, resumo_whatsapp, top_erros, top_acertos, plano_acao, frases_proibidas, reescrita_falas, mapa_frameworks, fases_analise, audio_path, audio_duration_seconds, drive_file_id, drive_url, drive_report_url, modelo_transcricao, modelo_analise, tokens_input, tokens_output, custo_estimado, uploaded_at, transcribed_at, analyzed_at, notified_at, completed_at, created_at, updated_at, sentiment_overall, sentiment_timeline, sentiment_score, engagement_level, objections_detected, prompt_version, report_hash, storage_report_path) VALUES
('e9a06962-8693-4977-b0aa-69d6df9552ed', '4ecd8f2d-d0c5-419c-a5bc-b2e94dca0465', '171a0543-1dde-4ba4-99f8-d396c6832b60', 'Dr. Maikon Henrique', '2026-03-03', 60, NULL, NULL, 'completed', NULL, 3.6, 'FRACA', 4.0, 3.0, 2.0, 6.0, 1.0, 7.0, 2.0, 4.0, 2.0, 3.0, 8.0, 4.0, 2.0, '3 de mar. de 2026

## Auditoria-Dr Maikon Henrique-System \- Transcrição

### 00:00:00

   
**Evelyn La:** M. Hum.  
**maikon henrique:** Olá,  
**Evelyn La:** Olá, Maicon.  
**maikon henrique:** boa noite.  
**Evelyn La:** Tudo bem?  
**maikon henrique:** Tudo bem?  
**Evelyn La:** Maravilha. Você tá ouvindo bem meu áudio aí?  
**maikon henrique:** Tô tão  
**Evelyn La:** Ah, fechou. Eu tava antes numa outra call e a moça falou que o retorno tava longe.  
**maikon henrique:** escutando.  
**Evelyn La:** Daí eu falei, acho que não, não é o meu. Então, maravilha. Vamos lá. Ma, você fala da onde?  
**maikon henrique:** Guanambi, Bahia.  
**Evelyn La:** Bahia,  
**maikon henrique:** É. E você da onde?  
**Evelyn La:** eu tô longe de ti. Tô em Paraná.  
**maikon henrique:** Tá longe,  
**Evelyn La:** Tô na outra ponta quase, né?  
**maikon henrique:** tá outra região totalmente  
**Evelyn La:** Diferente. É, é bem bem diferente para cá.  
**maikon henrique:** diferente.  
**Evelyn La:** Eu tinha uma colega da outra empresa que eu tava alguns anos atrás que ela era de Ilhelus. Bem diferente a cultura mesmo,  
**maikon henrique:** Isso.  
**Evelyn La:** Gabi. Mas vamos lá, Maicel. Ah, Carol me passou ali a respeito do seu interesse aqui para conhecer um pouquinho mais o nosso trabalho, né?  
   
 

### 00:04:51

   
**Evelyn La:** Eu estou, meu nome,  
**maikon henrique:** Uhum.  
**Evelyn La:** me chamo Evelyn, né? Deixa eu me apresentar. Primeiramente me chamo Evelyn, estou há 2 anos com a System, trabalhando aqui com eles e o nosso foco é realmente cirurgiões da face, eh profissionais que trabalham com a harmonização também, né? dentistas no geral, enfim, profissionais da saúde que abrangem esse nicho. E aí, antes de eu de, né, te apresentar um pouco mais a empresa e tudo, gostaria de entender e conhecer um pouquinho mais sobre você. Eh, já tá o bom tempo no mercado,  
**maikon henrique:** É,  
**Evelyn La:** como que foi essa essa sua chegada aí pra parte da harmonização, enfim.  
**maikon henrique:** eu tem um tempo que eu fiz um curso deização, fiz em 2019 no início, só que fiz um curso, aí depois não botei em prática,  
**Evelyn La:** Ага.  
**maikon henrique:** fiquei meio parado, fui exercer outro, fui exercer que eu sou sou dentista, né? Aí fui exercendo a odontologia. Aí tem 3 anos que eu moro aqui em Guanambi.  
**Evelyn La:** Ага.  
**maikon henrique:** Aí tem 6 meses que eu montei meu consultório agora. Antes eu trabalhava na franquia, chama Jul Laser, uma franquia que tem aqui.  
   
 

### 00:06:06

   
**Evelyn La:** Угу.  
**maikon henrique:** Aí chegou um momento que eu quis ter algo meu. Pensei: "Não, aluguei uma sala, aí tô no meus atendimentos. Aí atendo aqui no meu consultório e na Julez. Só que porém eu quero procurar melhores e vender mais.  
**Evelyn La:** Entendi.  
**maikon henrique:** Vender mais. meus pacientes entregar resultado. E tenho até um rapaz que faz meu tráfego pago, tenho tenho resultados com eles, com ele e tudo, só que eu quero melhorar mais ainda minhas minha visibilidade, a os os ticket médio dos meus pacientes, porque os ticket médic dos meus pacientes basicamente é em torno que gasta de 2 a 3.000, no máximo.  
**Evelyn La:** Certo.  
**maikon henrique:** O ticket que gasta acima disso é bem menor. É um paciente que eu tenho cada dois meses que vai gastar exemplo de 8 a 10.000 um a cada dois meses.  
**Evelyn La:** Uhum.  
**maikon henrique:** Mas o ticket no máximo é de 2 a 1\. Jábi uma cidade 100.000 habitantes,  
**Evelyn La:** Certo. Tá.  
**maikon henrique:** quase uns a 100.000 habitantes. A cidade tá em crescimento, só que porém eu ainda não não sei se o erro tá sendo em mim.  
   
 

### 00:07:20

   
**maikon henrique:** às vezes que não tô quase movimentando o Instagram. Movimento pro Instagram só, porém não sei se tá sendo tanto no meu erro, não  
**Evelyn La:** Tá.  
**maikon henrique:** sei  
**Evelyn La:** Você atende no seu no seu consultório particulares na semana  
**maikon henrique:** pá,  
**Evelyn La:** normalmente.  
**maikon henrique:** todos os dias, ó. Não, eu atendo de acordo a demanda,  
**Evelyn La:** Ah,  
**maikon henrique:** tipo assim, tando demanda, eu venho, atendo,  
**Evelyn La:** tá.  
**maikon henrique:** tem dia eu venho com consultório para ficar gravando vídeo ou senão mostrar que eu tenho algum atendimento, mas não tenho.  
**Evelyn La:** Uhum. Você tem alguém que te ajuda hoje ou é só você no consultório?  
**maikon henrique:** Só eu, eu sou que marco os pacientes e tudo.  
**Evelyn La:** Tá,  
**maikon henrique:** Sou minha secretária, só que porém tem uma secretária fictícia com outro nomeos  
**Evelyn La:** sim, sim. Uhum.  
**maikon henrique:** pacientes.  
**Evelyn La:** Entendi. Você tá com esse menino do tráfego que você falou, olha há quanto tempo já?  
**maikon henrique:** Desde quando eu comecei, setembro,  
**Evelyn La:** Угу.  
**maikon henrique:** o tráfego, tipo assim, tá me trazendo retorno, tem trazido muito paciente curioso, né?  
   
 

### 00:08:34

   
**maikon henrique:** Só que de exemplo trazer 100 mensagens, desses 100, uns 10 que eu fecho a oito, que eu vejo algum procedimento, o resto mas é curioso. E muitos pacientes tá vendo também de indicação, fez procedimento, gostou, me indicou, tá indo dessa forma. Ou senão o paciente que eu atendi na outra clínica aí quis vir fazer procedimento comigo, da seguinte forma.  
**Evelyn La:** Entendi. Você chegou através de nós por alguma indicação também ou você viu algum anúncio?  
**maikon henrique:** Foi na foi no  
**Evelyn La:** foi de anúncio.  
**maikon henrique:** Instagram.  
**Evelyn La:** Por que que eu te pergunto, Maicel? Eh, a Sistem hoje trabalha de uma forma eh que nós não somos agência de marketing e nem somos mentoria, nós somos um parceiro. Um caminho do meio. No que sentido? em buscar resolver o gargalo principal que esteja dentro da sua operação referente, seja a ele marketing ou comercial, porque uma coisa vai est linkada a outra, certo? Então, hoje a gente busca eh tanto trabalho de tráfego pago a gente também realiza, caso seja do da opção desse cirurgião, né, desse dentista, ou a gente pode também só trabalhar a parte comercial, porque às vezes o cirurgião tem aí um tráfego, um gestor que já gosta e quer manter e não tem problema nenhum.  
   
 

### 00:10:08

   
**maikon henrique:** Comercial seus é como? Explica aí.  
**Evelyn La:** Exatamente. É nesse ponto que eu queria entrar contigo. Hoje você falou que você é sozinho no teu consultório,  
**maikon henrique:** É porque eu pretendo contratar uma recepcionista,  
**Evelyn La:** certo?  
**maikon henrique:** só que porém ainda não tem uma demanda suficiente para ter, tipo assim uma pessoa igual tem hora meus atendimentos, tem hora que eu não mostro tanto porque não tem alguém para gravar. Aí comprei até um um material para gravar, um pezinho desse aqui para me ajudar.  
**Evelyn La:** Ah.  
**maikon henrique:** Só que eu, tipo assim, eu tenho alguns, eu tenho resultados bastante no meu, no meu, no meu, dos meus paciente, só que muitas vezes não sei eh, mostrar isso pro meu público no  
**Evelyn La:** Exato. Então,  
**maikon henrique:** Instagram.  
**Evelyn La:** vamos lá. Questão comercial. Primeiro que você me perguntou, né? Eh, a gente trabalha estruturando a parte comercial, seja a pré-venda que a gente fala e a venda.  
**maikon henrique:** Угуm.  
**Evelyn La:** Então, no caso, hoje o Macon ele faz tanto uma função quanto a outra e o procedimento em si, né? E aí a pré-venda ela é importante para é a primeira abordagem quando o paciente chama você, seja pelo Instagram, seja por indicação, por WhatsApp, qualquer coisa.  
   
 

### 00:11:25

   
**Evelyn La:** Dentro dessa pré-venda são pontos importantes de se analisar para que você possa ter uma um comparecimento eficaz. Que que são esses pontos na pré-venda? A taxa de agendamento, as taxas de confirmação, as cadências de retorno, tudo isso é importante um pré-vendas trabalhar, a venda em si, fechamento, negociações. E na venda é importante quando o paciente, por exemplo, vem para ser atendido pelo Michael, você ter uma apresentação de vendas. O que que é essa apresentação de vendas? é realmente mostrar ali os seus antes e depois resultados, cases, trabalhos dos quais você tenha, eh trazer um pouco também da sua jornada como profissional. Isso é interessante. Claro que você não precisa fazer uma apresentação longa para esse paciente, não. Não é esse a função, mas você ter vai te ajudar na hora de você conduzir muitas vezes a parte da venda em si, que é o fechamento ali. Mas vamos lá, para que o comercial consiga ser efetivo, você precisa uma demanda qualificada primeiramente, porque nada adianta você também ter estratégias de pré-venda, qualifica, eh, qualificação de venda, apresentação, se o lead que chega para você não tem condição nenhuma de fazer um procedimento seu. É a mesma coisa você querer tentar vender ouro, entregar ouro na mão de uma pessoa que ela não sabe que aquilo ali é ouro.  
   
 

### 00:12:59

   
**Evelyn La:** E aí a questão da qualificação a gente resolve no tráfego pago mesmo, né, nessa parte de estratégia de marketing, conversar, mapear todo o seu perfil de cliente que você quer chegar. Como assim? Vamos lá. Ah, o Maon hoje quer atingir um público específico para harmonização, para procedimento X, Y, Z. Tá? Quem são o público do Michael hoje? Ah, maioria é mulher, é homem, é faixa etária de qual idade? E qual é a real busca que eles vão eh atrás de procedimentos da face? Por exemplo, essa esse mapeamento que a gente faz é importante para depois definir o quê? Todo o seu a sua metodologia, que é o quê? Definir os seus produtos principais, produto de entrada e produto de saída. Isso vai ser importante para depois lincar as estratégias corretas. Com esse mapeamento a gente consegue gerar demanda qualificada para você, tá? Provavelmente o que tá acontecendo, que tá chegando muito volume, mas é pouca conversão, é porque o seu lead tá desqualificado, porque provavelmente não tá tendo esse mapeamento e não tá conversando. Ou seja, o posicionamento do Maconje, o posicionamento da sua campanha não tá chegando no leite, correto, a frequência tá diferente, entendeu? Não tá atingindo o público que tem que atingir, atingindo o público inferior e aí só tá gerando volume.  
   
 

### 00:14:40

   
**Evelyn La:** Provavelmente tem esse gargalo aí na sua estratégia comercial de marketing, tá? Eh, e isso é muito comum assim, não falando mal de agências, não é o meu intuito, não me entenda dessa maneira, mas a maioria das agências elas buscam de fato por entregar volume, porque elas trabalham com volume igual o Maicel, elas devem ter 30, 50 clientes, ganha no volume, mas nem todas conseguem entregar qualificação.  
**maikon henrique:** Porque os le muitas vezes chega estão lidos realmente desqualificados que conversa Só que quando passa às vezes o assamento e não tem condições. Ou seja, antes de perguntar, fal que vai, chega para mim na primeira abordagem, já pergunta preço antes mesmo eu saber o que ele deseja,  
**Evelyn La:** que que precisa é bem característico de de  
**maikon henrique:** que precisa.  
**Evelyn La:** público inferior ao de fato que é o seu perfil ideal, entendeu? Então, eh, corrigir esses gargalos e não é tão difícil assim,  
**maikon henrique:** M.  
**Evelyn La:** né? Como eu falei, a gente fazer só esse mapeamento realmente, trazer para você toda a construção da sua metodologia. Por que que é importante construção de metodologia? Que que seria a metodologia? a gente pega toda a esteira de produtos que você tem, ou seja, todos os procedimentos dos quais você realiza, e a gente cria uma metodologia em cima de três produtos, produto principal de entrada e saída, porque aí você vai ter a clareza do que, inclusive do como agregar valor em cada produto.  
   
 

### 00:16:28

   
**Evelyn La:** por exemplo, uma harmonização ali que vai tá entre dois a três, mais de retoque que seja, enfim, você consegue agregar valor depois nisso com o produto principal, trazendo mais um procedimento linkado, por exemplo, a isso e formando um protocolo exclusivo, sabe? Porque éonde a gente consegue construir suas ofertas que agregam valor. Porque a intenção de você ter uma metodologia e ter isso com clareza é justamente você saber em qual produto você consegue colocar uma gordurinha, a gente fala ali de lucro maior, sabe? E aí você consegue inclusive depois quando você vai criando base, você tá com consoro recente, né? se meses, mas a gente tá falando aí daqui um ano, eh, você já tem uma certa base. Que que é a base? São pacientes que já fizeram alguma vez procedimento com você ou até mesmo aqueles que perguntaram preço e não não vieram,  
**maikon henrique:** Угу.  
**Evelyn La:** não fecharam por algum motivo. E aí a gente consegue reativar essa base vendendo produtos da sua metodologia, revendendo produtos da sua metodologia, muitas vezes, tá? Da uma porcentagem a gente consegue converter. não é tão alta, mas a gente consegue converter sem você precisar investir. Então, a gente tem as estratégias, tem um caminho aí que é bem simples para resolver a sua questão, sabe, Michael?  
   
 

### 00:18:01

   
**Evelyn La:** É só o fato de eu entender realmente o que agora, eh, como que é a sua disponibilidade no consultório. Você falou, você vem conforme a demanda, mas você tá atendendo ainda na na franquia, né?  
**maikon henrique:** Ó, na franquia, tipo assim, hoje eles me vem como concorrente porque eu abri meu consultório.  
**Evelyn La:** Certo.  
**maikon henrique:** Eh, eu acho que eles não me dispensou ainda porque não achou uma pessoa para me substituir, porque eles me ligam, vou lá, atendo e e vou embora e faço muitos procedimentos dentro da monração.  
**Evelyn La:** Certo.  
**maikon henrique:** E eu acho que me dispensou por conta disso. Aí de manhã, em alguns atendimentos, eu ainda exerço em outra clínica a odontologia. Aí, tipo assim, no meu consultório,  
**Evelyn La:** Entendi.  
**maikon henrique:** praticamente todo dia eu tô aqui. Eu venho aqui todo dia, nem que não tem nada, eu venho aqui para fazer alguma coisa. para tentar movimentar o Instagram para alguma coisa.  
**Evelyn La:** Uhum.  
**maikon henrique:** Eu tô aqui no meu consultório. O WhatsApp tá aqui comigo tempo todo meu lado do WhatsApp,  
**Evelyn La:** Entendi.  
**maikon henrique:** né? onde correspondo alguns pacientes no número separado.  
   
 

### 00:19:07

   
**Evelyn La:** Aham. Tá. Deixa eu te apresentar eh como que seria essa ativação que a gente fala. Só para você entender, eu tenho hoje, né, na minha esteira de produtos, inclusive, soluções que vão variar aí de, ai, perdão, desculpa.  
**maikon henrique:** Saúde.  
**Evelyn La:** Obrigada. Eu vou ter soluções aí que vão variar valores de 5 a R$ 60.000, tá? Hoje a situação do Maon, né? Por que que a gente traz justamente nessa sessão aqui? Por que que eu faço esse diagnóstico entendo o seu cenário? Que não faz sentido nenhum eu pegar, por exemplo, um programa master hoje e querer colocar um micon? Por quê? Não que o micon não tenha capacidade, com certeza. potencial você deve, com certeza você deve ter, mas é pela questão da sua estrutura. Hoje, como você tá ainda muito no início, a gente precisa uma estrutura no que eu digo assim, para um programa master, você teria que ter ali uma, duas secretárias, no mínimo, pra gente conseguir rodar todas as estratégias que a gente implementa. Mas vamos lá, dá para chegar nesse nível, com certeza. Por onde a gente começa?  
**maikon henrique:** E tipo assim, igual você falou do secretário Eu queria até, não sei se seu comercial tem isso, ver uma pessoa para responder meus pacientes, tipo assim, para tentar vender, porque tem hora que eu tô em algum atendimento, eh, o paciente manda mensagem, eu não consigo responder, ou senão durante a própria venda da durante a própria mensagem que você conversar com o paciente.  
   
 

### 00:20:54

   
**maikon henrique:** E isso tem uma ansiedade, porque eu tô ansioso para afender pro paciente, o paciente tá querendo. Só que às vezes eu não sei se é na minha conversão também, se pode ser um erro meu também.  
**Evelyn La:** Uhum. Na hora de conduzir ali, né?  
**maikon henrique:** É porque quando chega o paciente, um cliente, você fica ansioso querendo dar o seu melhor,  
**Evelyn La:** Uhum.  
**maikon henrique:** mostrar resultados, porque hoje, tipo assim, o o tráfego pago meu, o rapaz me dá um cronograma de como que eu vou responder aos pacientes. Só que eu não respondo certinho para não ficar muito robotizado.  
**Evelyn La:** Sim.  
**maikon henrique:** Tento responder da melhor maneira para ficar algo mais próximo do paciente. Encaminho alguns casos de antes, depois. Quando eu vejo que o paciente tá com dúvidas e a primeira vez que tá fazendo,  
**Evelyn La:** Iso.  
**maikon henrique:** que quer que irá fazer algum procedimento, eu já tento marcar avaliação online para entender primeiro a queixa dele e na avaliação tirar todas as dúvidas, porque na mensagem o que eu vou dar de informação tem hora para ele vai confundir ele.  
**Evelyn La:** Isso mesmo. Exatamente. É, tem coisas que você não passa inclusive informação por WhatsApp. Por quê? Porque ele se ele vai acabar te comparando com outro profissional.  
   
 

### 00:22:11

   
**Evelyn La:** Então, a pré-venda, que é essa primeira abordagem de levar a pessoa para um comparecimento, né, agendar e comparecer. Essa condução de início, você passa algumas informações e tenta o máximo possível extrair a informação dele e minimiza e passa menos informações suas. Por quê? Porque a intenção é aquecer essa pessoa, filtrar, obviamente se ela de fato tá interessada ou se ela só tá querendo tomar seu tempo também, inclusive. E depois desse passo, aí sim ir para um comparecimento presencial. Aí, nesse presencial você vai fazer todo a sua construção da da sua venda, da oferta ali, porque aí a emoção da pessoa, inclusive, ela é maior de tá presencial com você, de ela eh estar ali e ter esse seu esse seu feedback, a sua avaliação, o seu cuidado ali com ela, tudo isso vai conectar ainda mais e aí sim a possibilidade da conversão, ela aumenta. Agora, mas se você passa muita informação no pré-venda, que a gente chama nesse pré-atendimento, ela esfria, ela tem tendência a esfriar e não a se manter aquecida para querer ir até o  
**maikon henrique:** Ah.  
**Evelyn La:** seu consultório, entendeu? Então, existe uma forma correta de conduzir ali também. Eu super entendo essa questão da ansiedade, até mesmo porque acredito que você queira eh alavancar logo o seu próprio negócio para deixar, né, os os outros os outros trabalhos ali eh menas seja menos rotatividade, ou seja, ou até mesmo deixar deles e focar só no seu próprio negócio.  
   
 

### 00:24:01

   
**Evelyn La:** Mas essa condução ela faz a diferença, porque o paciente muitas vezes o seu cliente ali que tá do outro lado, ele sente isso.  
**maikon henrique:** Sente. E tem hora que chega alguns pacientes, alguns lead que chega através do Instagram, chega WhatsApp, eu mando a mensagem eh eh para ele respondendo, me apresentando, não responde, aí passa uma semana esse mesmo número, esse mesmo número, manda de novo outra mensagem. Aí vou me apresentar, me apresento, manda uma mensagem de bem de boa vinda, de boas-vindas,  
**Evelyn La:** Угуm.  
**maikon henrique:** né? O paciente não responde, tá tendo muito isso agora. E antes não tava tendo, igual meu, no meu tráfego pago, o começou a me dar um retorno depois uns dois meses. Deu um retorno bom de cidades vizinhas e da própria cidade onde que eu atendo. Eu dividi, joguei um tráfego pago específico num em algumas cidades daqui perto, só que deu uma esfriada agora e trouxe tipo assim retorno bom.  
**Evelyn La:** E aí depois  
**maikon henrique:** É uma esfriada.  
**Evelyn La:** parou.  
**maikon henrique:** Bom, é parou.  
**Evelyn La:** Qual que tá sendo a sua média hoje de faturamento aí com o tráfego que você tá fazendo?  
   
 

### 00:25:20

   
**maikon henrique:** Ó, o meu Instagram do meu consultório total ou só do Instagram.  
**Evelyn La:** No seu consultório total. Só o seu  
**maikon henrique:** Ah, meu consultório hoje tá na média de 20\.  
**Evelyn La:** consultó,  
**maikon henrique:** Janeiro foi um dos melhores, foi 30\.  
**Evelyn La:** tá? Uma média de uns 25 cai. Então,  
**maikon henrique:** É,  
**Evelyn La:** quanto você gostaria de alavancar desses desse que você tem hoje faturado? Os próximos  
**maikon henrique:** iria 50 pro próximo mês e subindo,  
**Evelyn La:** seis  
**maikon henrique:** né? Degrau, degrau.  
**Evelyn La:** dobrar. Uhum.  
**maikon henrique:** E tipo assim, eu acho que tem hora, né? até até acabo eh às vezes não tendo aquela rotina de postar tanto porque a gente acaba ficando frustrado que às vezes não tem atendimento, não tem. Aí vem outro colega tá tendo, a gente veja que também tem um erro também meu.  
**Evelyn La:** Sim, sim. É, não se compare porque cada um tem seu momento.  
**maikon henrique:** Ja.  
**Evelyn La:** Quanto a isso, eh, às vezes a gente precisa trabalhar interno em nós, né, e faz parte. Já tive negócio também, tá? já fui empresária, tive loja por 4 anos aqui na minha cidade.  
   
 

### 00:26:26

   
**Evelyn La:** E às vezes eu me pegava caindo nesse erro também de me comparar com com o meu concorrente, de ver que ele tava trazendo mais novidade do que eu. Acontecia e é normal, né? Mas a gente não pode se deixar levar por isso todos os dias. Você não pode deixar que isso tome mais a sua atenção e a sua energia do que realmente o foco no seu próprio negócio, né? Não olhe pro lado, como diz uma uma mentora uma vez que eu tive de de essas questões mais energéticas e até da parte de empresarial, assim, ela falava: "Não olha pra grama do vizinho, não olha, olha só da sua,  
**maikon henrique:** Eh  
**Evelyn La:** cuida da sua." Sim, a gente é humano e faz parte, a gente vai se comparar em um momento ou outro, mas não dá para ser mais do seu tempo se comparando do que você fazendo realmente o seu, né? Mas aí por que que eu te perguntei, né? Você tem um objetivo, você tem claro isso para você, no mínimo dobrar o seu faturamento, tá? Você já tá no faturamento legal de início, não tá ruim, porque eu já atendi outros aqui, até inclusive outros casos onde tava o o dentista chegava a faturar no máximo ali que ele conseguia, às vezes era 10, 15.000 que ele tava fazendo suado.  
   
 

### 00:27:43

   
**Evelyn La:** Então a gente tem como pegar desses 25 que você tá hoje, dobrar a sua operação. Isso é possível, tá? Vai ser fácil, vai ser trabalhoso. Dá pra gente fazer isso. Como que a gente poderia fazer isso? Deixa eu te mostrar um pouquinho da empresa. Eu vou te apresentar um pouquinho da empresa e vou te mostrar a nossa metodologia completa. Não faz sentido, como eu te falei, a nossa metodologia completa hoje não faz sentido para você no momento atual. pela questão da sua estrutura, ainda tá começando a engatinhar aí, mas a gente consegue tirar alguns pilares principais disso para já te colocar e te trazer vendas melhores e te auxiliar nesse primeiro momento. É o programa de ativação que a gente chama. Que que seria a ativação? A ativação é justamente para você dar esse primeiro passo para depois você fazer os seus primeiros R$ 100.000. R$ 1000, tá? Então a ativação ela é um passinho anterior do face 100k, que é o aceleração para 100 para bater 100.000. A gente tem hoje casos de cirurgiões que estão batendo 100.000 por semana, por dia e por mês.  
   
 

### 00:29:03

   
**Evelyn La:** Vai muito também de como tá a estrutura evolução ali no processo. Eu não vou falar assim, Maicel, você vai sair de 25, certeza e vai bater 100.000 num primeiro mês? Não, até mesmo porque a gente tem um trabalho aí a ser executado para primeiro aumentar essa sua essas suas vendas. Hoje você ter condição de ter alguém no seu consultório que vá dar conta de atender mais demanda aí na pré-qualificação, no pré-atendimento, para depois a gente dar outros passos, certo? Então, hoje assistem, quem é assistem? Assistem digital é uma empresa especialista no nicho dos cirurgiões da face no geral. Como eu falei, nós não somos agência e não somos mentoria, a gente é um parceiro, a gente trabalha junto mesmo, né? Então hoje o Renan e o Mateus são os sócios donos da empresa. Nós já estamos há 6 anos no mercado. Eu estou trabalhando com eles há do anos, inclusive. O nosso foco é justamente trabalhar esses dois pilares, essas duas frentes aí, gerando demanda qualificada, trabalhando comercial, processo comercial para essa conversão. Aí o Renan, ele tá há 5 anos à frente de times de alta performance, já fez mais de 15 milhões em vendas aí com clínicas.  
   
 

### 00:30:20

   
**Evelyn La:** O Mateus é o nosso gestor estratégico e é um dos principais, é o nosso nerd, Mateus, é o nosso nerd aqui, é o que monta as estratégias, que superintende dessa parte de marketing, enfim, cria planilhas, dashboard, faz tudo aqui o nosso estrategista. E hoje nós temos inclusive dentro do nosso ecossistema, a possibilidade de alguns sócios, de virar sócio, né, de futuros dentistas aí. Como assim? A Débora, por exemplo, foi uma um case nosso, né, dentro do programa mais completo ali, o programa master que a gente tem. E ela começou a dar mentorias da técnica dela. E a partir disso a gente assume uma sociedade no ramo educacional com a Débora. Então a gente tem essa possibilidade também de crescimento. Enfim, esse foi um dos resultados que a gente já gerou dentro de um mês em faturamento, né, para uma clínica. E o que que a gente encontra no mercado atual? Normalmente, como eu falei, de parte de do sentido, a maioria vem falando sobre demanda desqualificada. Ah, eu tenho esse problema com lead, não consigo, captação tá ruim. Então, a maioria vem pensando muitas vezes que nós somos agência. A gente faz sim o trabalho do marketing, a gente faz a gestão, mas a gente não é a agência, porque a agência só se preocupa em gerar justamente essa demanda.  
   
 

### 00:31:50

   
**Evelyn La:** Mas a gente se preocupa inclusive em quê? Em fazer acontecer junto com comercial. Então, a solução que a gente traz paraa demanda desqualificada é o mapeamento que eu te falei, a gente fazer esse mapeamento correto, a gente entender e aí depois encaras estratégias de acordo com a tua metodologia que a gente cria, porque a partir disso a gente consegue refinar ainda mais o perfil de cliente ideal para conversar com o Michael, tá? É o que faz realmente crescer, né? riscos de fazer sozinho, muitas vezes sem conhecimento, é muito do passo que você tá hoje. Você acaba tendo até essa frustração, porque de fato você não consegue dar conta sozinho, você não consegue pensar em tudo sozinho. estratégia, estratégia comerciais, estratégia de venda, sei o quê, é muita coisa. Então, a System, ela tem esse papel em tanto ajudar eh o cirurgião a trabalhar com mais tranquilidade mental, porque a gente consegue gerar essa demanda e conseguimos também trabalhar a parte comercial ali,  
**maikon henrique:** Так.  
**Evelyn La:** tanto no processo de pré-vendas e vendas, alinhando essas duas, esses dois pilares, né? Então, claro que isso daqui futuramente eh, fazendo, cumprindo o processo certinho, ele vai aumentar inclusive a sua recorrência, que é o que eu falei, né?  
   
 

### 00:33:12

   
**Evelyn La:** Conforme você vai tendo base, a gente vai criando estratégia para revender para essa base. Então, essa é o nosso papel, tá? Como que a gente faz, né? Qual que seria a nossa metodologia hoje? Eu vou te apresentar o nosso o nossa mandala completa, que são oito pilares que a gente trabalha num programa, mas aqui hoje pro Michael, o que que seria primordial para dar um passinho, um passinho para chegar nesses 100.000, construir as suas ofertas, que é aquilo que eu te falei, trabalhar pro produto principal de entrada e saída, definir o seu funil de marketing, né, com essa oferta aqui. Protocolos de caixa rápido são estratégias para você depois que você tem base, você já ir aplicando, já ter isso na mão e definir o seu pré-venda e a sua venda. Esses pilares aqui no programa de ativação, eles já seriam um start para você começar. Como que funciona? A gente tem um acompanhamento na ativação de 3 meses, tá? O completo ele é 6 meses. É a roda toda aqui, né? Toda mandala. Alo de três meses, ele ter só a parte de estratégia de produtos e ofertas, eh direcionamento para estratégia de marketing, mas a gente não faz o seu marketing, nem o tráfego pago.  
   
 

### 00:34:50

   
**Evelyn La:** e a definição de pré-vendas e vendas, que aí é trabalhar abordagens corretas, a condução, questão da venda em si, questão de apresentação e os protocolos de caixa rápido, que são o estratégias, já a gente tem oito estratégias das quais você pode aplicar para base. Isso a gente libera esse acompanhamento de 3 meses, ele vai ser para você fazer as suas primeiras vendas com valor já mais agregado. Vai ser para aumentar.  
**maikon henrique:** Esse acompanhamento de marketing você não dá auxílio não?  
**Evelyn La:** A gente dá o direcionamento, mas a gente não faz o marketing em si para você nesse de três meses, tá? Mas a gente dá o direcionamento, sim. Eh, a gente ajuda a a linkcar uma estratégia que seja um pouco melhor. Aí seria o caso até às vezes de de trazer isso pro seu gestor hoje que tá fazendo seu tráfego pago, enfim, mas a gente pode te dar um direcionamento legal até mesmo pro seu Instagram ali. A gente consegue te direcionar isso numa sessão estratégica, tá? Com o Mateus ali. E nesse programa de três meses, você é acompanhado de forma personalizada. Então, a gente cria um grupo VIP no WhatsApp. aonde vai tá só o Maicel, a o Renan, o Mateus, a Alane e a Mari, que são as estrategistas responsáveis por estar com você nessa jornada ao longo dos três meses.  
   
 

### 00:36:16

   
**Evelyn La:** E aí você faz três calls de sessão estratégica para eh começar a aplicar já no seu negócio, construir a a tua metodologia, trabalhar a questão das vendas, trabalhar a questão das estratégias de marketing ali, né, o direcionamento com o Mateus e executar. Tá?  
**maikon henrique:** Ah.  
**Evelyn La:** E aí pelo grupo que a gente fica fazendo esse acompanhamento com você, a gente fica ali full time. Você pode mandar dúvidas, você pode mandar questionamentos, o que você precisar, a gente vai estar ali para te atender. E esse treinamento do pré-vendas e vendas, a gente tem eles gravados e aí a gente direciona você por onde você começar e como você fazer. Mas é como eu te falei, como você não tem ninguém hoje no seu time, primeiro passo teria que ser feito tudo por você mesmo para conseguir fazer gerar as primeiras vendas e aí a partir disso a gente conseguir trazer alguém pro seu time, que daí a gente tem inclusive banco de talentos que a gente indica.  
**maikon henrique:** Oi.  
**Evelyn La:** E aí você pode ter uma pessoa, por exemplo, home office para fazer essa parte, você não ter tantos encargos assim, trabalhar com um PJ para esse teu começo, sabe?  
**maikon henrique:** Mhm.  
**Evelyn La:** E aí o programa de ativação, deixa eu ver se eu tenho outro desenho dele aqui, só para você entender. Teve um casal até que entrou hoje de manhã no de ativação.  
   
 

### 00:37:52

   
**Evelyn La:** Eles são de Goiás. Deixa eu ver se eu tenho a minha fica mais intuitivo de se visualizar o ativação aqui. Deixa eu ver. Você tá conseguindo ver aqui? Esse é a estrutura do nosso programa de ativação, ou seja, são 3 meses, né, os 90 dias. aqui os primeiros 30 dias é justamente criar toda essa estrutura que eu te falei. Então você vai ter acesso às trilhas do conhecimento de pré-vendas e vendas e a parte dos protocolos também de caixa. A gente cria a esteira toda estruturada para você de produtos seus e também apresentação de vendas. A gente dá um foco aqui, principalmente na venda, tá? nesses primeiros 30 dias. Então, a gente alinha script de vendas com você, eh, e acompanha a sua primeira venda realizada. Por quê? Inclusive, o Mateus aqui entra e faz análise de perfil para você do do Instagram ali e tudo, tá?  
**maikon henrique:** Ele consegue ver,  
**Evelyn La:** Por que que o primeiro Sim,  
**maikon henrique:** ele consegue ver que consigo melhorar o meu Instagram.  
**Evelyn La:** a gente te dá o direcionamento aqui nesses primeiros 30 dias para isso, tá? Eh, o que que é o objetivo desse primeiro checkpoint? É justamente você fazer as primeiras vendas aqui, focar na venda.  
   
 

### 00:39:54

   
**Evelyn La:** Então, a gente alinha primeiro tudo esses passos contigo já numa numa primeira sessão, uma primeira reunião estratégica. E o segundo checkpoint, que é nos 60 dias ao decorrer ali, aí a gente já vai trabalhar na consistência, na recorrência de duas até quatro vendas. na recorrência eh de já tá sendo replicável o que a gente  
**maikon henrique:** Eh  
**Evelyn La:** colocar no primeiro mês. Primeiro mês já é focado para fazer venda e no segundo para fazer recorrência. E no terceiro mês, que daí já tá aos 90 dias, você já tem uma clareza aí do valor eh que você vai conseguir ter de previsibilidade da estrutura que a gente cria nos primeiros 30 dias. Evelyn, se a gente, se eu entrar no primeiro, nos primeiros 30 dias eu, eh, por exemplo, precisa precisar mudar alguma estratégia, precisar tirar dúvida, precisar rever alguma coisa relacionada a algum desses primeiros passos aqui, a gente pode fazer isso também, tá? Mas a gente foca primeira coisa, você fazer suas primeiras vendas. Dessas primeiras vendas a gente vai trabalhar o quê? Previsibilidade, recorrência, aplicação de protocolos de caixa rápida para você não precisar toda hora ter que estar investindo em tráfego para você poder vender. E terceiro mês, a recompra.  
**maikon henrique:** Pera aí rapidinho.  
   
 

### 00:41:30

   
**maikon henrique:** Deixa eu vou mudar de sala aqui. Pera aí. Pode falar.  
**Evelyn La:** Que que você achou do programa de de três meses para pro seu momento atual? Você acredita que  
**maikon henrique:** quer agora  
**Evelyn La:** Aham.  
**maikon henrique:** valores  
**Evelyn La:** Você acredita que com esse acompanhamento assim, só tirando questões de valores, só pelo acompanhamento em si, faria sentido para você?  
**maikon henrique:** sim porque nesse acompanhamento eu vou tirar poder tirar todas minhas dúvidas com vocês e se caso tiver qualquer dificuldade para estar ali para dar um suporte, né? Porque o primeiro mês eu vou tentar vender sem sem ser só pelo tráfego pago, através de clientes que vão chegar, né? e também vender mais para aqueles clientes que já é já é paciente meu.  
**Evelyn La:** Exato. O ativação. Só para você entender, o nosso programa de 3 meses de ativação é para o o cirurgião ali ele fazer dinheiro. E o programa que a gente tem, que é o master, que é o de 6 meses, é para ele fazer dinheiro com mais tempo. Aí são outras estratégias que a gente limpa. Então, no primeiro momento agora, o importante pro Michael fazer acontecer é o quê? fazer dinheiro. Então, a gente foca sempre mais na venda e na previsibilidade para depois você  
   
 

### 00:42:56

   
**maikon henrique:** Угу.  
**Evelyn La:** ir alcançando os outros patamares, né, que é o primordial, a venda é o coração da empresa, de qualquer empresa, né? Então assim, faria, eu acredito muito que faria muito sentido para você essa metodologia dos três meses, porque é onde a gente conseguiria realmente fazer acontecer aí e a partir disso você alavancar seu faturamento e poder ficar mais tranquilo até de poder sair dos outros lugares, né? Por enquanto você vai ter que ir pisando meio que nas duas plataformas aqui e ali. A hora que começou a andar com previsibilidade o seu consultório, aí sim. Mas claro, eh, vai também de você ter a essa toda a disponibilidade no sentido de ter que fazer tudo sozinho por enquanto, né?  
**maikon henrique:** Sim,  
**Evelyn La:** Que que você me diz?  
**maikon henrique:** gostei disso aí. É, nessas nesse acompanhamento pelo mês você dá todo o planejamento de tudo. Aí vai entrar no meu Instagram, o grupo Mateus, tudo para ver onde que eu posso melhorar no meu Instagram,  
**Evelyn La:** A gente vai te dar o direcionamento para  
**maikon henrique:** minha visibilidade e tipo assim em questão do meu market,  
**Evelyn La:** isso.  
**maikon henrique:** exemplo, vamos dar um suporte, ó, eu tenho esse caso aqui, como que eu posso apresentar ele para trazer cliente, trazer trazer uma cor uma um interesse  
   
 

### 00:44:34

   
**Evelyn La:** Sim, esses script, essas abordagens, como gerar essa conexão, o interesse no seu no seu lead e como ao melhorar a sua conversão nas  
**maikon henrique:** Esse  
**Evelyn La:** na hora da tua venda ali, na hora da tua apresentação, quando ele vem pessoalmente com você pro seu consultório, tudo isso a gente ajuda e te direciona. Inclusive, a gente tem os treinamentos já gravados com algumas coisas que são padrão que é importante você entender. E os scripts a gente faz junto com você se for necessário e alinha e ajusta e personaliza se for necessário.  
**maikon henrique:** Uhum. E qual valor do seu acompanhamento esses três  
**Evelyn La:** Ó, os três meses hoje eu consigo fazer ele de duas formas,  
**maikon henrique:** meses?  
**Evelyn La:** tanto à vista quanto parcelado no cartão. Dá para parcelar em até 12 vezes, se for o caso também, tá? Ele fica hoje no a vista  
**maikon henrique:** Tem  
**Evelyn La:** 16.500 ou parcelado em 12 vezes com juros. Aí com juros ele fica, ele vai dar uns 19.000 1 e pouquinho.  
**maikon henrique:** que pensar.  
**Evelyn La:** Hum, tranquilo.  
**maikon henrique:** que eu tenho interesse, eu tenho que pensar sobre  
**Evelyn La:** Uhum.  
**maikon henrique:** isso. que eu cheguei até você através de um que eu vi com um professor meu, segue a sua, segue uma segue o material lá no Instagram, agência sua, só que não por querer nenhuma referência sobre isso.  
   
 

### 00:46:24

   
**Evelyn La:** Qual que é o professor?  
**maikon henrique:** Acho que foi Patrick, uma professor meu, foi exe professor  
**Evelyn La:** O Patrick,  
**maikon henrique:** meu.  
**Evelyn La:** eu acho que ele foi nosso acelerado há um tempo atrás.  
**maikon henrique:** Ele é do do Rio de Janeiro,  
**Evelyn La:** Eu acredito que ele tenha sido nosso acelerado, sim, porque ele não é, esse nome não é estranho para mim nos grupos de acelerado que a gente tem ali. A gente tem também o Alexandre Algarve, não sei se tu já ouviu falar, é bem conhecido na área também, é nosso sentado.  
**maikon henrique:** Ó, vou pensar que eu tenho eu tenho interesse bastante.  
**Evelyn La:** Aham.  
**maikon henrique:** Agora ten que fazer conta ver se cabe dentro do meu orçamento agora, entendeu? E avista, avista não vou ter como, vou ter que você passa  
**Evelyn La:** Tem que ser parcelado. Você pensava em parcelar em 12 vezes  
**maikon henrique:** live  
**Evelyn La:** mesmo?  
**maikon henrique:** 10, 12\.  
**Evelyn La:** Ums 10, umas 10, 12 vezes.  
**maikon henrique:** É,  
**Evelyn La:** A sua, o que, o que impediria você de tomar uma decisão hoje comigo? É só essa questão financeira mesmo que você precisaria  
**maikon henrique:** a questão financeira, porque tipo assim, a primeira abordagem,  
   
 

### 00:47:56

   
**Evelyn La:** verificar.  
**maikon henrique:** né? E dar um primeiro passo, gera, como eu posso dizer falar, não é nem segurança, tipo assim, para saber mais sobre o conhecimento, né? Eu quero resultados.  
**Evelyn La:** Sim, sim.  
**maikon henrique:** Eu acho que é mais é isso, tipo assim,  
**Evelyn La:** Uhum. Entendo. Olha que que eu posso te falar referente a isso, né, Maicon? Eu posso te te falar sobre com base nos cases que a gente tem de programa de ativação hoje. Até deixa eu compartilhar meu whats aqui para você ver. Nós estamos hoje com um grupo dos ativados. Eu não gosto de prometer nada, de ficar nessa, sabe? Não, você vai fazer x valor, você vai não, porque eh cada um tem o seu o seu a sua desenvoltura, né? Então não posso não não sou bem em pé no chão, tá? com o pessoal que a gente acompanha. Ó, a Cléber e Ana entraram hoje. Eles entraram hoje, ó. Já fizeram a primeira call até estratégica. A gente tem aqui o pessoal da aceleração também. Eh, então assim, o grupo, né, o acompanhamento, a entrega toda,  
**maikon henrique:** Ah.  
**Evelyn La:** ela é 100% garantida para você.  
   
 

### 00:49:38

   
**Evelyn La:** Eu não vou te garantir 100% eh de resultado em questões financeiras, porque a gente vai é um trabalhinho junto em conjunto aí, tá? Mas seria um grande passo pra gente começar a construir realmente o seu caminho pro 100k, né? A Elane entrou ontem, só que a Elana entrou no de aceleração porque ela tem uma estrutura já, ela tem uma gerente, tem duas secretárias e assim seria um  
**maikon henrique:** Eu  
**Evelyn La:** uma grande oportunidade pra gente começar já sabe?  
**maikon henrique:** vou est vou vou estudar planejar interesse e dou uma resposta essa semana ainda.  
**Evelyn La:** Uhum. Tá,  
**maikon henrique:** Uhum.  
**Evelyn La:** deixa eu te falar. Se a gente conseguisse assim,  
**maikon henrique:** Deixa falar.  
**Evelyn La:** talvez negociar a questão de valor financeiro, você daria um passo hoje  
**maikon henrique:** Eu tenho interesse,  
**Evelyn La:** comigo?  
**maikon henrique:** só que como eu te falei, fazer algo que eu dou conta de pagar, que eu não tenho, não vou pagar só isso, tem outras contas sobre isso, né?  
**Evelyn La:** Uhum.  
**maikon henrique:** Qual o valor você conseguiria para mim?  
**Evelyn La:** Eh, então aí eu preciso entender de você, por exemplo, ah, Evelyn, eu pretenderia fazer idealmente tudo parcelado, eh, 12 vezes, seis vezes, eu teria uma entrada e parcelamento de restante.  
   
 

### 00:51:08

   
**Evelyn La:** Porque aí dependendo, a gente tá falando aqui no valor de 16.500 500 à vista, que é o caso que você falou que não teria condição. Mas o que que seria que caberia hoje no seu orçamento o valor, por exemplo, de parcela dentro desses 19.000 que seria com juros.  
**maikon henrique:** 19000  
**Evelyn La:** Por exemplo, assim, Evin, ah, eu consigo, sei lá, 5.000 de entrada e aí eu consigo mexer no quê? Consigo mexer nos juros e trabalhar uma parcela que fique bom para ti.  
**maikon henrique:** Tem que pensar que eu posso te ofertar ofertar. É o seguinte, amanhã eu dou uma posição, vou ver como é tá basicamente que eu tenho de pagar esse mês e tudo de fazer uma oferta para você me fazer uma conta proposta.  
**Evelyn La:** Uhum. Certo.  
**maikon henrique:** Certo?  
**Evelyn La:** Mas assim,  
**maikon henrique:** Mas  
**Evelyn La:** necessariamente é só a questão financeira. Você tem um,  
**maikon henrique:** necessariamente  
**Evelyn La:** você deve ter um valor de parcela aí na cabeça que você fala: "Putz, esse aqui eu assumiria".  
**maikon henrique:** ó, basicamente tem que ser pelo menos em 10, né? Menos que isso não tem como.  
   
 

### 00:52:29

   
**maikon henrique:** Embora da entrada acho que não iria pesar, tá? Dá uns três, 3000 de entrada.  
**Evelyn La:** Uhum. Uns R$ 3.000 de entrada. E aí, restante parcelado. Isso. Deixa eu simular aqui. Vamos ver quanto que eu conseguiria para ti. Mas aí eu consigo assim, ó, só para você entender. Esse essa negociação ela é válida pro pro nosso momento de fechamento mesmo de agora, tá? Por quê? Eh, por causa do meu site aqui que eu consigo liberar os cashback para um momento de call mesmo. Então, eu trabalho com a domagos já ouviu falar. Deixa eu lançar aqui se eu fosse tirar o juro em relação à parcela dos três de entrada. Vamos ver. Kom. que me dá aqui. Ó, uma parcela  
**maikon henrique:** Ó,  
**Evelyn La:** de eliminar aqui. Deixa eu tentar tirar mais um pouquinho. Pera aí. Ver se ele aceita o cash. Ele me deu uma parcela de 1653 em 10 vezes. Isso vai dar um total mais daria.  
**maikon henrique:** 19.530 com mais 3000 19.530.  
   
 

### 00:55:01

   
**Evelyn La:** Oi.  
**maikon henrique:** 530 Então,  
**Evelyn La:** Exatamente. Deixa eu tentar.  
**maikon henrique:** Ja.  
**Evelyn La:** Deixa eu tentar um outro, um cupom de cashback que eu tinha gerado antes. Ver se ele tá válido ainda. Yes. 10\. É, validou. Ó, eu conseguiria deixar ela por 17881\. Aí 10 parcelas de 1488 com três de entrada.  
**maikon henrique:** Que que eu vou fazer? Eu vou, eu gostei. Vou amadurecer a ideia. Tenho interesse. Só que eu não tenho como fechar agora  
**Evelyn La:** Certo. O que que te impediria de você fechar  
**maikon henrique:** não.  
**Evelyn La:** agora?  
**maikon henrique:** Eu tenho que conhecer mais só igual lá no Instagram, tudo gostei. Só que eu quero fechar, entendeu? Só quero conhecer mais e somar, né? somar minhas contas para m poder pagar. E que eu acabei de comprar um eh fazer fazer um curso  
**Evelyn La:** Entendi.  
**maikon henrique:** agora de BFF plastia, tô pagando por ele ainda.  
**Evelyn La:** Aham. Você fez um curso onde?  
   
 

### 00:57:00

   
**Evelyn La:** É.  
**maikon henrique:** Esses Montes claros,  
**Evelyn La:** E quantos qual foi o investimento do curso lá?  
**maikon henrique:** paguei uns 18.000, U, fora o material que eu comprei.  
**Evelyn La:** É, então,  
**maikon henrique:** Aí sumi muito. Tô com muita parcela.  
**Evelyn La:** mas é justamente esses 18.000 aí. Hoje uma bléfo, você cobra em média quanto, uma  
**maikon henrique:** Vou começar agora,  
**Evelyn La:** bléfo.  
**maikon henrique:** né? Problema que não começar inicial um cinco a seis, né? Para paciente modelo, né? Para deixar postar,  
**Evelyn La:** Sim,  
**maikon henrique:** divulgar.  
**Evelyn La:** sim. Ou seja, a gente tá falando aí de você vender, se for uns R$ 6.000, né, três bléfaro para cobrir o seu custo do curso, certo?  
**maikon henrique:** Não, isso eu entendo. que eu que vou pensar, eu te dou uma posição  
**Evelyn La:** Tá, pode não. Tranquilo, fica à vontade, Maicel. Eh,  
**maikon henrique:** certinho.  
**Evelyn La:** a única coisa que daí essa proposta que eu gerei para você, que eu validei aqui do cashback da DOM, ela só seria realmente válida para hoje, tá?  
**maikon henrique:** Não,  
**Evelyn La:** Eu não conseguiria manter as condições para ti,  
**maikon henrique:** tranquilo. Não,  
**Evelyn La:** tá? Aí, tudo bem para você?  
**maikon henrique:** tranquilo.  
**Evelyn La:** Se a gente for negociar depois eh no valor com o juros completo?  
**maikon henrique:** A gente vê que for melhor, porque agora não tem, eu não quero, eu quero assumir isso aí, só que porém eu tenho que pensar mesmo.  
**Evelyn La:** Uhum.  
**maikon henrique:** Amanhã você, amanhã você te dou uma resposta no grupo lá no WhatsApp que a moça  
**Evelyn La:** Aham.  
**maikon henrique:** meou. Quer  
**Evelyn La:** Sim. Não quer,  
**maikon henrique:** dizer,  
**Evelyn La:** não quer fazer a entrada garantir hoje e a gente startar amanhã. Depois você faz o pagamento do restante,  
**maikon henrique:** vamos fazer tudo amanhã,  
**Evelyn La:** tá?  
**maikon henrique:** vai ser melhor.  
**Evelyn La:** Mas aí amanhã eu só não vou conseguir manter a negociação.  
**maikon henrique:** Não,  
**Evelyn La:** Tranquilo para ti? Tá certo. Então, Mario,  
**maikon henrique:** tranquilo.  
**Evelyn La:** qualquer coisa você chama a gente ali no grupo amanhã.  
**maikon henrique:** V, viu. Tá bom. Prazer também com você.  
   
 

### A transcrição foi encerrada após 00:59:32

*Esta transcrição editável foi gerada por computador e pode conter erros. As pessoas também podem alterar o texto depois que ele for criado.*', '# AUDITORIA DE CALL — Elane x Dr. Maikon Henrique
**Data:** 2026-03-03 | **Duração:** 60 min | **Resultado:** Não fechamento (lead pediu prazo para pensar)

---

## 1. RESUMO EXECUTIVO

Call com estrutura básica presente mas execução superficial. Closer não seguiu protocolo de qualificação adequada, pulou etapas críticas de diagnóstico quantitativo e perguntas de consequência. Apresentou valor sem construir dor suficiente. Lead demonstrou interesse genuíno mas não foi conduzido ao fechamento por falta de isolamento de objeções e urgência. Proporção de fala excessiva da closer (≈55%). Score reflete call mediana com potencial desperdiçado - lead qualificado que poderia ter fechado com melhor execução.

---

## 2. SCORECARD

| # | Dimensão | Peso | Nota | Ponderada | Evidência |
|---|---|---|---|---|---|
| 1 | Frame e Liderança | 8% | 4,0 | 0,32 | Rapport longo (4min), frame vago, sem pactos claros |
| 2 | Qualificação Preliminar | 10% | 3,0 | 0,30 | Budget não obtido, decisor assumido, urgência não testada |
| 3 | Diagnóstico Quantitativo | 12% | 2,0 | 0,24 | Apenas faturamento (25k), ticket médio superficial, métricas-chave ausentes |
| 4 | Diagnóstico Qualitativo | 8% | 6,0 | 0,48 | Lead verbalizou frustrações, mas faltou aprofundamento SPIN |
| 5 | Perguntas de Consequência | 10% | 1,0 | 0,10 | Ausentes - não explorou custo de não mudar |
| 6 | Ensino Comercial | 5% | 7,0 | 0,35 | Boa diferenciação agência x parceiro, insights sobre lead desqualificado |
| 7 | Reframe de Identidade | 5% | 2,0 | 0,10 | Não trabalhou crenças limitantes antes do preço |
| 8 | Ancoragem de Valor | 10% | 4,0 | 0,40 | Apresentou metodologia mas sem ancoragem ROI clara |
| 9 | Isolamento de Objeção | 10% | 2,0 | 0,20 | "Só questão financeira?" não isolou adequadamente |
| 10 | Proporção de Fala | 8% | 3,0 | 0,24 | Closer ≈55%, muito monólogo na apresentação |
| 11 | Segurança de Promessas | 8% | 8,0 | 0,64 | Boa - não fez promessas infladas, baseou em cases |
| 12 | Checkpoints | 3% | 4,0 | 0,12 | Poucos checkpoints durante apresentação longa |
| 13 | Controle e Fechamento | 3% | 2,0 | 0,06 | Perdeu controle no final, aceitou "pensar" facilmente |

**SCORE FINAL: 3,6/10 — CALL FRACA**

---

## 3. ANÁLISE BLOCO A BLOCO

### 00:00–04:51 — Rapport Contextual | Fase 1
**O que aconteceu:** Conversa sobre localização (Bahia x Paraná), menção superficial a colega de Ilhéus. Rapport muito longo para call comercial.
**Frameworks aplicados:** Nenhum framework específico
**Frameworks ausentes:** Hormozi (Clarify), estrutura de tempo
**Pontos fortes:** Tom amigável, lead confortável
**Erros:** Rapport excessivo (4min+), sem direcionamento, sem pesquisa prévia do lead
**Veredicto do bloco:** 3/10

### 04:51–10:08 — Apresentação da Closer e Início de Diagnóstico | Fase 1-2
**O que aconteceu:** Closer se apresenta, nicho explicado, lead conta histórico profissional básico. Menciona curso 2019, consultório há 6 meses, ticket 2-3k.
**Frameworks aplicados:** Parcial Rackham (Situação), início Cole Gordon
**Frameworks ausentes:** Frame de três intenções, qualificação preliminar estruturada
**Pontos fortes:** Lead compartilhando informações, closer ouvindo
**Erros:** Não definiu agenda, não estabeleceu autoridade, pulou qualificação preliminar
**Veredicto do bloco:** 4/10

### 10:08–18:01 — Explicação Comercial Longa | Fase 2 (desviada)
**O que aconteceu:** Closer explica diferenciação (não agência, parceiro), metodologia de pré-venda/venda, qualificação de leads. Monólogo longo sobre sistema.
**Frameworks aplicados:** Challenger Sale (ensino comercial), diferenciação
**Frameworks ausentes:** SPIN profundo, diagnóstico quantitativo completo
**Pontos fortes:** Boa diferenciação, insights sobre leads desqualificados
**Erros:** Monólogo excessivo, não completou diagnóstico, proporção de fala alta
**Veredicto do bloco:** 5/10

### 18:01–25:20 — Exploração Superficial do Cenário | Fase 2
**O que aconteceu:** Lead explica situação atual (franquia + consultório), rotina, frustração com leads desqualificados. Closer obtém faturamento: 25k média, pico 30k.
**Frameworks aplicados:** Rackham (Problema), início NEPQ
**Frameworks ausentes:** Diagnóstico quantitativo completo, métricas de conversão
**Pontos fortes:** Lead verbalizou dor (frustração, leads desqualificados)
**Erros:** Não aprofundou métricas essenciais (taxa conversão, custo lead, etc.)
**Veredicto do bloco:** 6/10

### 25:20–33:12 — Definição de Meta e Mais Ensino | Fase 2-3
**O que aconteceu:** Lead quer dobrar para 50k+, closer compartilha experiência pessoal, apresenta company overview e casos.
**Frameworks aplicados:** Social proof, parte do Challenger Sale
**Frameworks ausentes:** Perguntas de consequência (NEPQ), amplificação da dor
**Pontos fortes:** Meta clara (50k), social proof apresentado, conexão pessoal
**Erros:** Não explorou consequência de não atingir meta, não amplificou dor
**Veredicto do bloco:** 6/10

### 33:12–41:30 — Apresentação da Metodologia | Fase 5 (prematura)
**O que aconteceu:** Closer apresenta metodologia completa, programa de ativação 3 meses vs master 6 meses, estrutura detalhada.
**Frameworks aplicados:** Ancoragem parcial, diferenciação de ofertas
**Frameworks ausentes:** Isolamento de objeções antes da apresentação
**Pontos fortes:** Metodologia estruturada, diferenciação clara
**Erros:** Apresentação prematura, sem isolamento prévio, monólogo longo
**Veredicto do bloco:** 4/10

### 41:30–46:24 — Validação e Apresentação de Preço | Fase 5
**O que aconteceu:** Lead valida interesse no acompanhamento, closer apresenta 16.5k à vista / 19k parcelado.
**Frameworks aplicados:** Validação básica, ancoragem de preço
**Frameworks ausentes:** Isolamento financeiro adequado, ROI calculado
**Pontos fortes:** Lead confirmou interesse no programa
**Erros:** Não isolou objeções, não fez ROI com números do lead, preço "jogado"
**Veredicto do bloco:** 4/10

### 46:24–59:32 — Negociação e Tentativa de Fechamento | Fase 6
**O que aconteceu:** Lead menciona referência (Patrick), pede para "pensar", closer tenta negociação (entrada + parcelas), lead mantém posição de aguardar.
**Frameworks aplicados:** Tentativa de isolamento ("só questão financeira?")
**Frameworks ausentes:** Tratamento adequado de objeções, criação de urgência
**Pontos fortes:** Closer tentou negociar, flexibilidade no pagamento
**Erros:** Aceitou "pensar" facilmente, não criou urgência, perdeu controle
**Veredicto do bloco:** 2/10

---

## 4. MAPA DE FRAMEWORKS

| Framework | Presença (0-10) | Onde aplicou | Onde faltou | Impacto |
|---|---|---|---|---|
| Hormozi (CLOSER) | 2/10 | - | Clarify agenda, Label problema, Explain away | Call sem estrutura clara |
| Miner (NEPQ) | 1/10 | - | Consequence questions críticas | Dor não amplificada |
| Belfort (Straight Line) | 3/10 | Tentativa controle final | Controle durante call toda | Lead ditou o ritmo |
| Cole Gordon | 4/10 | Frame inicial básico | Diagnóstico profundo, isolamento | Estrutura incompleta |
| Eli Wilde | 1/10 | - | Reframe de identidade completo | Sem mudança de perspectiva |
| Dan Lok | 4/10 | Postura autoridade inicial | Manutenção autoridade | Virou apresentador |
| Rackham (SPIN) | 4/10 | Situação e Problema básicos | Implicação e Necessidade | Diagnóstico superficial |
| Challenger Sale | 7/10 | Diferenciação agência/parceiro | Teaching mais profundo | Bom ensino comercial |
| Sabri Suby | 3/10 | Diferenciação de ofertas | Ancoragem valor, urgência | Oferta não irrecusável |
| Brad Lea | 2/10 | - | Antecipação objeções estruturada | Objeções não tratadas |

---

## 5. TOP 5 ACERTOS

1. **Diferenciação Clara** — 10:08 — Explicou bem diferença entre agência x parceiro, criando positioning único (Challenger Sale)
2. **Insights sobre Leads Desqualificados** — 14:40 — Ensino sobre lead desqualificado que pergunta preço primeiro, validou frustração do lead
3. **Flexibilidade na Negociação** — 51:08 — Tentou diferentes estruturas de pagamento para acomodar situação financeira
4. **Social Proof Contextualizado** — 30:20 — Mencionou cases e resultados, trouxe credibilidade para empresa
5. **Segurança de Promessas** — Durante toda call — Não fez promessas infladas, manteve expectativas realistas

---

## 6. TOP 5 ERROS (por gravidade)

1. **GRAVIDADE ALTA: Diagnóstico Quantitativo Incompleto** — 18:01-25:20 — Obteve apenas faturamento básico, não coletou métricas críticas (taxa conversão, custo por lead, show rate, etc.) que impediu ROI calculado
2. **GRAVIDADE ALTA: Ausência de Perguntas de Consequência** — 25:20+ — Não fez NEPQ, não amplificou dor, lead não sentiu urgência de mudança
3. **GRAVIDADE MÉDIA-ALTA: Isolamento de Objeções Falho** — 46:24+ — "É só questão financeira?" não isolou adequadamente, aceitou "pensar" sem resistência
4. **GRAVIDADE MÉDIA-ALTA: Proporção de Fala Excessiva** — 10:08-41:30 — Monólogos longos na apresentação, closer ≈55% vs ideal ≤40%
5. **GRAVIDADE MÉDIA: Frame e Pactos Ausentes** — 00:00-10:08 — Não estabeleceu agenda clara, três intenções, pactos de "sim ou não"

---

## 7. REESCRITA DE MOMENTOS CRÍTICOS

### Momento 1: 25:20 — Após obter meta de faturamento
**O QUE FOI DITO:** "Qual que tá sendo a sua média hoje de faturamento aí... dobrar. Uhum."
**O QUE DEVERIA TER SIDO DITO:** "Maikon, você falou que quer chegar nos 50k. Me ajuda a entender: se nos próximos 12 meses você continuar nessa média de 25k, o que isso representa pra você? E qual o custo real de não sair dessa situação?"
**POR QUÊ:** NEPQ - amplifica a dor antes de apresentar solução
**IMPACTO ESTIMADO:** Lead sentiria urgência real, não apenas desejo de crescer

### Momento 2: 46:24 — Antes de apresentar preço
**O QUE FOI DITO:** Apresentou preço direto após validação superficial
**O QUE DEVERIA TER SIDO DITO:** "Maikon, antes de falar investimento, isolando o fator financeiro: se tivesse certeza que em 90 dias você estaria faturando 40-50k consistente, você entraria em parceria comigo hoje?"
**POR QUÊ:** Cole Gordon - isolamento adequado de objeções
**IMPACTO ESTIMADO:** Objeção financeira não seria principal barreira

### Momento 3: 55:00 — Lead pedindo para "pensar"
**O QUE FOI DITO:** "Tranquilo, fica à vontade, Maicel"
**O QUE DEVERIA TER SIDO DITO:** "Maikon, me ajuda a entender o que realmente te preocupa. Quando alguém pede pra pensar, normalmente é porque alguma coisa não fez sentido. É o valor total, a parcela, ou você tem alguma dúvida se vai funcionar pro seu caso?"
**POR QUÊ:** Belfort - não aceitar "pensar", isolar objeção real
**IMPACTO ESTIMADO:** Descobriria objeção verdadeira e poderia tratá-la

### Momento 4: 10:08 — Início do diagnóstico
**O QUE FOI DITO:** Monólogo sobre pré-venda e comercial
**O QUE DEVERIA TER SIDO DITO:** "Maikon, pra eu te ajudar da melhor forma, preciso entender alguns números: dos leads que chegam pelo tráfego, quantos você consegue agendar? Dos agendados, quantos comparecem? Dos que comparecem, quantos fecham?"
**POR QUÊ:** Diagnóstico quantitativo estruturado
**IMPACTO ESTIMADO:** Base sólida para apresentar ROI calculado

### Momento 5: 04:51 — Após rapport
**O QUE FOI DITO:** Apresentação genérica
**O QUE DEVERIA TER SIDO DITO:** "Maikon, antes de começar, deixa eu alinhar 3 coisas: primeiro, quero te ouvir e entender sua situação real. Segundo, vou avaliar se faz sentido trabalharmos juntos. Terceiro, se fizer sentido, faço uma proposta. Se não fizer, te oriento pro melhor caminho. Combinado?"
**POR QUÊ:** Frame de três intenções (Hormozi)
**IMPACTO ESTIMADO:** Autoridade estabelecida, expectativa clara

---

## 8. PLANO DE AÇÃO

### Recomendação 1: Estruturar Diagnóstico Quantitativo
- **O que fazer:** Criar checklist com 8-10 métricas essenciais para coletar SEMPRE
- **Por quê:** Base para ROI calculado, não estimado
- **Como treinar:** Role play coletando métricas até ser automático
- **Prioridade:** ALTA

### Recomendação 2: Dominar Perguntas de Consequência NEPQ
- **O que fazer:** Praticar 3 perguntas de consequência padrão até sair natural
- **Por quê:** Amplifica dor, cria urgência genuína
- **Como treinar:** Gravar simulações focando só nisso
- **Prioridade:** ALTA

### Recomendação 3: Reduzir Proporção de Fala
- **O que fazer:** Cronometrar blocos, meta de closer ≤35% na apresentação
- **Por quê:** Lead precisa se convencer falando, não ouvindo
- **Como treinar:** Perguntas abertas + silêncio consciente
- **Prioridade:** ALTA

### Recomendação 4: Protocolo de Isolamento de Objeções
- **O que fazer:** Script exato pré-preço: "Isolando financeiro, você entraria?"
- **Por quê:** Trata objeções reais, não sintomas
- **Como treinar:** Simular com todas objeções possíveis
- **Prioridade:** MÉDIA-ALTA

### Recomendação 5: Gestão de "Pensar"
- **O que fazer:** Nunca aceitar "pensar" sem investigar. "O que te preocupa?"
- **Por quê:** "Pensar" sempre esconde objeção real
- **Como treinar:** Role play específico para esse momento
- **Prioridade:** MÉDIA-ALTA

### Recomendação 6: Frame Inicial Estruturado
- **O que fazer:** Três intenções obrigatórias nos primeiros 5min
- **Por quê:** Estabelece autoridade e expectativa
- **Como treinar:** Decorar e praticar até fluir natural
- **Prioridade:** MÉDIA

### Recomendação 7: Checkpoints na Apresentação
- **O que fazer:** "Até aqui faz sentido?" a cada 5min de fala
- **Por quê:** Mantém engajamento, detecta resistências
- **Como treinar:** Cronometrar apresentações simuladas
- **Prioridade:** BAIXA

---

## 9. ALERTAS DE PROMESSA

**Nenhuma promessa de risco identificada.** Closer manteve expectativas realistas e baseadas em cases. Ponto positivo da call.

---

## 10. ANÁLISE DE SENTIMENTO DO LEAD

### Sentimento Geral
- **Sentimento:** positivo/interessado
- **Score de Sentimento:** 0.6 (moderadamente positivo)
- **Nível de Engajamento:** médio-alto

### Timeline de Sentimento
| Trecho | Sentimento | Confiança (0-1) | Momento-Chave |
|--------|-----------|-----------------|---------------|
| 00:00-10:00 | neutro/positivo | 0.8 | Rapport confortável, compartilhamento aberto |
| 10:00-20:00 | positivo | 0.9 | Engajamento alto, verbalizando frustrações |
| 20:00-30:00 | muito positivo | 0.9 | Definindo metas, conectando com insights |
| 30:00-45:00 | positivo | 0.8 | Interesse na metodologia, fazendo perguntas |
| 45:00-55:00 | neutro/resistente | 0.7 | Preço apresentado, começou hesitação |
| 55:00-60:00 | positivo mas não decisivo | 0.8 | Manteve interesse mas pediu tempo |

### Objeções Detectadas
1. **Timestamp:** 46:24 | **Objeção:** "tenho que pensar sobre isso" | **Resposta do Closer:** aceitou facilmente | **Efetividade:** ruim
2. **Timestamp:** 47:56 | **Objeção:** "questão financeira" | **Resposta do Closer:** tentou negociação | **Efetividade:** média
3. **Timestamp:** 55:00 | **Objeção:** "quero conhecer mais" | **Resposta do Closer:** não investigou profundamente | **Efetividade:** ruim
4. **Timestamp:** 57:00 | **Objeção:** "tô com muita parcela" (curso 18k) | **Resposta do Closer:** tentou mostrar ROI básico | **Efetividade:** média

O lead demonstrou interesse genuíno durante toda a call, mas as objeções no final não foram adequadamente isoladas e tratadas, resultando em não fechamento de um prospect qualificado.', '🔴 AUDITORIA: Elane x Dr. Maikon Henrique
📅 2026-03-03 | ⏱ 60min
📊 Score: 3.6/10 — FRACA

✅ Top Acertos:
1. Diferenciação Clara
2. Insights sobre Leads Desqualificados
3. Flexibilidade na Negociação

❌ Top Erros:
1. GRAVIDADE ALTA: Diagnóstico Quantitativo Incompleto
2. GRAVIDADE ALTA: Ausência de Perguntas de Consequência
3. GRAVIDADE MÉDIA-ALTA: Isolamento de Objeções Falho', '[{"rank": 1, "title": "GRAVIDADE ALTA: Diagnóstico Quantitativo Incompleto", "description": "18:01-25:20 — Obteve apenas faturamento básico, não coletou métricas críticas (taxa conversão, custo por lead, show rate, etc.) que impediu ROI calculado"}, {"rank": 2, "title": "GRAVIDADE ALTA: Ausência de Perguntas de Consequência", "description": "25:20+ — Não fez NEPQ, não amplificou dor, lead não sentiu urgência de mudança"}, {"rank": 3, "title": "GRAVIDADE MÉDIA-ALTA: Isolamento de Objeções Falho", "description": "46:24+ — \"É só questão financeira?\" não isolou adequadamente, aceitou \"pensar\" sem resistência"}, {"rank": 4, "title": "GRAVIDADE MÉDIA-ALTA: Proporção de Fala Excessiva", "description": "10:08-41:30 — Monólogos longos na apresentação, closer ≈55% vs ideal ≤40%"}, {"rank": 5, "title": "GRAVIDADE MÉDIA: Frame e Pactos Ausentes", "description": "00:00-10:08 — Não estabeleceu agenda clara, três intenções, pactos de \"sim ou não\""}]'::jsonb, '[{"rank": 1, "title": "Diferenciação Clara", "description": "10:08 — Explicou bem diferença entre agência x parceiro, criando positioning único (Challenger Sale)"}, {"rank": 2, "title": "Insights sobre Leads Desqualificados", "description": "14:40 — Ensino sobre lead desqualificado que pergunta preço primeiro, validou frustração do lead"}, {"rank": 3, "title": "Flexibilidade na Negociação", "description": "51:08 — Tentou diferentes estruturas de pagamento para acomodar situação financeira"}, {"rank": 4, "title": "Social Proof Contextualizado", "description": "30:20 — Mencionou cases e resultados, trouxe credibilidade para empresa"}, {"rank": 5, "title": "Segurança de Promessas", "description": "Durante toda call — Não fez promessas infladas, manteve expectativas realistas"}]'::jsonb, '[{"rank": 1, "title": "Estruturar Diagnóstico Quantitativo", "por_que": "Base para ROI calculado, não estimado", "prioridade": "ALTA", "o_que_fazer": "Criar checklist com 8-10 métricas essenciais para coletar SEMPRE", "como_treinar": "Role play coletando métricas até ser automático"}, {"rank": 2, "title": "Dominar Perguntas de Consequência NEPQ", "por_que": "Amplifica dor, cria urgência genuína", "prioridade": "ALTA", "o_que_fazer": "Praticar 3 perguntas de consequência padrão até sair natural", "como_treinar": "Gravar simulações focando só nisso"}, {"rank": 3, "title": "Reduzir Proporção de Fala", "por_que": "Lead precisa se convencer falando, não ouvindo", "prioridade": "ALTA", "o_que_fazer": "Cronometrar blocos, meta de closer ≤35% na apresentação", "como_treinar": "Perguntas abertas + silêncio consciente"}, {"rank": 4, "title": "Protocolo de Isolamento de Objeções", "por_que": "Trata objeções reais, não sintomas", "prioridade": "MÉDIA-ALTA", "o_que_fazer": "Script exato pré-preço: \"Isolando financeiro, você entraria?\"", "como_treinar": "Simular com todas objeções possíveis"}, {"rank": 5, "title": "Gestão de \"Pensar\"", "por_que": "\"Pensar\" sempre esconde objeção real", "prioridade": "MÉDIA-ALTA", "o_que_fazer": "Nunca aceitar \"pensar\" sem investigar. \"O que te preocupa?\"", "como_treinar": "Role play específico para esse momento"}, {"rank": 6, "title": "Frame Inicial Estruturado", "por_que": "Estabelece autoridade e expectativa", "prioridade": "MÉDIA", "o_que_fazer": "Três intenções obrigatórias nos primeiros 5min", "como_treinar": "Decorar e praticar até fluir natural"}, {"rank": 7, "title": "Checkpoints na Apresentação", "por_que": "Mantém engajamento, detecta resistências", "prioridade": "BAIXA", "o_que_fazer": "\"Até aqui faz sentido?\" a cada 5min de fala", "como_treinar": "Cronometrar apresentações simuladas"}]'::jsonb, '[]'::jsonb, '[{"impact": "Lead sentiria urgência real, não apenas desejo de crescer", "reason": "NEPQ - amplifica a dor antes de apresentar solução", "original": "Qual que tá sendo a sua média hoje de faturamento aí... dobrar. Uhum.", "rewritten": "Maikon, você falou que quer chegar nos 50k. Me ajuda a entender: se nos próximos 12 meses você continuar nessa média de 25k, o que isso representa pra você? E qual o custo real de não sair dessa situação?", "description": "25:20 — Após obter meta de faturamento"}, {"impact": "Objeção financeira não seria principal barreira", "reason": "Cole Gordon - isolamento adequado de objeções", "original": "Apresentou preço direto após validação superficial", "rewritten": "Maikon, antes de falar investimento, isolando o fator financeiro: se tivesse certeza que em 90 dias você estaria faturando 40-50k consistente, você entraria em parceria comigo hoje?", "description": "46:24 — Antes de apresentar preço"}, {"impact": "Descobriria objeção verdadeira e poderia tratá-la", "reason": "Belfort - não aceitar \"pensar\", isolar objeção real", "original": "Tranquilo, fica à vontade, Maicel", "rewritten": "Maikon, me ajuda a entender o que realmente te preocupa. Quando alguém pede pra pensar, normalmente é porque alguma coisa não fez sentido. É o valor total, a parcela, ou você tem alguma dúvida se vai funcionar pro seu caso?", "description": "55:00 — Lead pedindo para \"pensar\""}, {"impact": "Base sólida para apresentar ROI calculado", "reason": "Diagnóstico quantitativo estruturado", "original": "Monólogo sobre pré-venda e comercial", "rewritten": "Maikon, pra eu te ajudar da melhor forma, preciso entender alguns números: dos leads que chegam pelo tráfego, quantos você consegue agendar? Dos agendados, quantos comparecem? Dos que comparecem, quantos fecham?", "description": "10:08 — Início do diagnóstico"}, {"impact": "Autoridade estabelecida, expectativa clara", "reason": "Frame de três intenções (Hormozi)", "original": "Apresentação genérica", "rewritten": "Maikon, antes de começar, deixa eu alinhar 3 coisas: primeiro, quero te ouvir e entender sua situação real. Segundo, vou avaliar se faz sentido trabalharmos juntos. Terceiro, se fizer sentido, faço uma proposta. Se não fizer, te oriento pro melhor caminho. Combinado?", "description": "04:51 — Após rapport"}]'::jsonb, '{"Dan Lok": {"score": 4.0, "impact": "Virou apresentador", "where_applied": "Postura autoridade inicial", "where_missing": "Manutenção autoridade"}, "Brad Lea": {"score": 2.0, "impact": "Objeções não tratadas", "where_applied": "-", "where_missing": "Antecipação objeções estruturada"}, "Eli Wilde": {"score": 1.0, "impact": "Sem mudança de perspectiva", "where_applied": "-", "where_missing": "Reframe de identidade completo"}, "Sabri Suby": {"score": 3.0, "impact": "Oferta não irrecusável", "where_applied": "Diferenciação de ofertas", "where_missing": "Ancoragem valor, urgência"}, "Cole Gordon": {"score": 4.0, "impact": "Estrutura incompleta", "where_applied": "Frame inicial básico", "where_missing": "Diagnóstico profundo, isolamento"}, "Miner (NEPQ)": {"score": 1.0, "impact": "Dor não amplificada", "where_applied": "-", "where_missing": "Consequence questions críticas"}, "Rackham (SPIN)": {"score": 4.0, "impact": "Diagnóstico superficial", "where_applied": "Situação e Problema básicos", "where_missing": "Implicação e Necessidade"}, "Challenger Sale": {"score": 7.0, "impact": "Bom ensino comercial", "where_applied": "Diferenciação agência/parceiro", "where_missing": "Teaching mais profundo"}, "Hormozi (CLOSER)": {"score": 2.0, "impact": "Call sem estrutura clara", "where_applied": "-", "where_missing": "Clarify agenda, Label problema, Explain away"}, "Belfort (Straight Line)": {"score": 3.0, "impact": "Lead ditou o ritmo", "where_applied": "Tentativa controle final", "where_missing": "Controle durante call toda"}}'::jsonb, '[{"name": "00–04:51 — Rapport Contextual | Fase 1", "phase": 0, "observations": "**O que aconteceu:** Conversa sobre localização (Bahia x Paraná), menção superficial a colega de Ilhéus. Rapport muito longo para call comercial.\n**Frameworks aplicados:** Nenhum framework específico\n**Frameworks ausentes:** Hormozi (Clarify), estrutura de tempo\n**Pontos fortes:** Tom amigável, lead confortável\n**Erros:** Rapport excessivo (4min+), sem direcionamento, sem pesquisa prévia do lead\n**Veredicto do bloco:** 3/10"}, {"name": "51–10:08 — Apresentação da Closer e Início de Diagnóstico | Fase 1-2", "phase": 4, "observations": "**O que aconteceu:** Closer se apresenta, nicho explicado, lead conta histórico profissional básico. Menciona curso 2019, consultório há 6 meses, ticket 2-3k.\n**Frameworks aplicados:** Parcial Rackham (Situação), início Cole Gordon\n**Frameworks ausentes:** Frame de três intenções, qualificação preliminar estruturada\n**Pontos fortes:** Lead compartilhando informações, closer ouvindo\n**Erros:** Não definiu agenda, não estabeleceu autoridade, pulou qualificação preliminar\n**Veredicto do bloco:** 4/10"}, {"name": "08–18:01 — Explicação Comercial Longa | Fase 2 (desviada)", "phase": 10, "observations": "**O que aconteceu:** Closer explica diferenciação (não agência, parceiro), metodologia de pré-venda/venda, qualificação de leads. Monólogo longo sobre sistema.\n**Frameworks aplicados:** Challenger Sale (ensino comercial), diferenciação\n**Frameworks ausentes:** SPIN profundo, diagnóstico quantitativo completo\n**Pontos fortes:** Boa diferenciação, insights sobre leads desqualificados\n**Erros:** Monólogo excessivo, não completou diagnóstico, proporção de fala alta\n**Veredicto do bloco:** 5/10"}, {"name": "01–25:20 — Exploração Superficial do Cenário | Fase 2", "phase": 18, "observations": "**O que aconteceu:** Lead explica situação atual (franquia + consultório), rotina, frustração com leads desqualificados. Closer obtém faturamento: 25k média, pico 30k.\n**Frameworks aplicados:** Rackham (Problema), início NEPQ\n**Frameworks ausentes:** Diagnóstico quantitativo completo, métricas de conversão\n**Pontos fortes:** Lead verbalizou dor (frustração, leads desqualificados)\n**Erros:** Não aprofundou métricas essenciais (taxa conversão, custo lead, etc.)\n**Veredicto do bloco:** 6/10"}, {"name": "20–33:12 — Definição de Meta e Mais Ensino | Fase 2-3", "phase": 25, "observations": "**O que aconteceu:** Lead quer dobrar para 50k+, closer compartilha experiência pessoal, apresenta company overview e casos.\n**Frameworks aplicados:** Social proof, parte do Challenger Sale\n**Frameworks ausentes:** Perguntas de consequência (NEPQ), amplificação da dor\n**Pontos fortes:** Meta clara (50k), social proof apresentado, conexão pessoal\n**Erros:** Não explorou consequência de não atingir meta, não amplificou dor\n**Veredicto do bloco:** 6/10"}, {"name": "12–41:30 — Apresentação da Metodologia | Fase 5 (prematura)", "phase": 33, "observations": "**O que aconteceu:** Closer apresenta metodologia completa, programa de ativação 3 meses vs master 6 meses, estrutura detalhada.\n**Frameworks aplicados:** Ancoragem parcial, diferenciação de ofertas\n**Frameworks ausentes:** Isolamento de objeções antes da apresentação\n**Pontos fortes:** Metodologia estruturada, diferenciação clara\n**Erros:** Apresentação prematura, sem isolamento prévio, monólogo longo\n**Veredicto do bloco:** 4/10"}, {"name": "30–46:24 — Validação e Apresentação de Preço | Fase 5", "phase": 41, "observations": "**O que aconteceu:** Lead valida interesse no acompanhamento, closer apresenta 16.5k à vista / 19k parcelado.\n**Frameworks aplicados:** Validação básica, ancoragem de preço\n**Frameworks ausentes:** Isolamento financeiro adequado, ROI calculado\n**Pontos fortes:** Lead confirmou interesse no programa\n**Erros:** Não isolou objeções, não fez ROI com números do lead, preço \"jogado\"\n**Veredicto do bloco:** 4/10"}, {"name": "24–59:32 — Negociação e Tentativa de Fechamento | Fase 6", "phase": 46, "observations": "**O que aconteceu:** Lead menciona referência (Patrick), pede para \"pensar\", closer tenta negociação (entrada + parcelas), lead mantém posição de aguardar.\n**Frameworks aplicados:** Tentativa de isolamento (\"só questão financeira?\")\n**Frameworks ausentes:** Tratamento adequado de objeções, criação de urgência\n**Pontos fortes:** Closer tentou negociar, flexibilidade no pagamento\n**Erros:** Aceitou \"pensar\" facilmente, não criou urgência, perdeu controle\n**Veredicto do bloco:** 2/10\n\n---"}]'::jsonb, 'test://dr.-maikon-henrique-2026-03-03.ogg', NULL, NULL, NULL, NULL, 'gemini-notes', 'claude-sonnet-4-20250514', 24197, 5447, 0.1543, '2026-03-25T04:24:45.267312+00:00', NULL, '2026-03-25T04:26:38.424933+00:00', '2026-03-25T04:34:49.572596+00:00', '2026-03-25T04:34:49.572596+00:00', '2026-03-25T04:24:45.267312+00:00', '2026-03-25T04:36:53.396222+00:00', 'positive', '[{"sentiment": "positive", "confidence": 0.9, "key_moment": "Engajamento alto, verbalizando frustrações", "timestamp_range": "10:00-20:00"}, {"sentiment": "positive", "confidence": 0.8, "key_moment": "Interesse na metodologia, fazendo perguntas", "timestamp_range": "30:00-45:00"}]'::jsonb, 0.6, 'medium', '[{"objection": "tenho que pensar sobre isso", "timestamp": "46:24", "effectiveness": "poor", "closer_response": "aceitou facilmente"}, {"objection": "quero conhecer mais", "timestamp": "55:00", "effectiveness": "poor", "closer_response": "não investigou profundamente"}]'::jsonb, '1.0', 'ef14dc3f24f429b4', 'e9a06962-8693-4977-b0aa-69d6df9552ed/auditoria_2026-03-03_dr-maikon-henrique.md');

INSERT INTO call_audits (id, organization_id, closer_id, lead_name, call_date, duration_minutes, resultado, valor_fechamento, status, error_message, score_final, classificacao, d01_frame, d02_qualificacao, d03_diag_quantitativo, d04_diag_qualitativo, d05_consequencia, d06_ensino, d07_identidade, d08_ancoragem, d09_isolamento, d10_proporcao_fala, d11_promessas, d12_checkpoints, d13_fechamento, transcricao, relatorio_completo, resumo_whatsapp, top_erros, top_acertos, plano_acao, frases_proibidas, reescrita_falas, mapa_frameworks, fases_analise, audio_path, audio_duration_seconds, drive_file_id, drive_url, drive_report_url, modelo_transcricao, modelo_analise, tokens_input, tokens_output, custo_estimado, uploaded_at, transcribed_at, analyzed_at, notified_at, completed_at, created_at, updated_at, sentiment_overall, sentiment_timeline, sentiment_score, engagement_level, objections_detected, prompt_version, report_hash, storage_report_path) VALUES
('bef46d54-8c64-4403-9f59-d0eda47e0065', '4ecd8f2d-d0c5-419c-a5bc-b2e94dca0465', '171a0543-1dde-4ba4-99f8-d396c6832b60', 'Cliente Teste', '2026-03-02', 60, NULL, NULL, 'completed', NULL, 3.9, 'FRACA', 7.0, 3.0, 2.5, 6.0, 0.0, 4.0, 2.0, 5.0, 8.0, 3.0, 1.0, 2.0, 8.0, '2 de mar. de 2026

## Auditoria Comercial \- Elane  \- Transcrição

### 00:00:00

   
**Elane Lima:** Olá. Olá. Não se assusta não.  
**Evelyn La:** Não me tô sentada, não me assustei.  
**Elane Lima:** Não te assusto. Parece que levei dois socos. Eu fiz um lift.  
**Evelyn La:** Ah, legal. Que  
**Elane Lima:** Para te dizer a verdade,  
**Evelyn La:** bom.  
**Elane Lima:** eu tô aqui já quase 10 dias. Eu primeiro fiz uma mentoria. Aí no final da mentoria, uma mentoria de lift, justamente para me levar mais excelência paraa minha cidade, fiz, eu sou do norte, né? Sou de Santar no Pará e eu estou no momento em Florianópolis,  
**Evelyn La:** Hum. Que  
**Elane Lima:** em Araranguá,  
**Evelyn La:** legal.  
**Elane Lima:** numa num Dr. Raulino que ele é referência nessa parte de lift. Aí como eu confio,  
**Evelyn La:** Aham.  
**Elane Lima:** não é não é à toa que eu tô aqui, né? vi aprender aí no final do curso eu já vou embora na quarta de manhã no final do curso eu fiz o meu lift  
**Evelyn La:** Já aproveitou a a saída. Maravilha.  
**Elane Lima:** é  
**Evelyn La:** Bem bem pragmática, né? Já fui, já fui organizada, já fiz o inclusive.  
**Elane Lima:** se eu tiver que fazer eu sou assim  
   
 

### 00:01:25

   
**Evelyn La:** Vamos lá. Maravilha.  
**Elane Lima:** mesma  
**Evelyn La:** Muito bom, El. Eu ia te, eu ia até inclusive comentar, você é do Pará ali, né? Atende  
**Elane Lima:** É Santareém no Pará.  
**Evelyn La:** Santarém.  
**Elane Lima:** E assim, isso é bom, é bom pelo pela quantidade de profissionais,  
**Evelyn La:** Aham.  
**Elane Lima:** entendeu?  
**Evelyn La:** Você consegue mais oportunidades, eu acredito, né,  
**Elane Lima:** É só como é seu nome mesmo?  
**Evelyn La:** Evely?  
**Elane Lima:** É. Ah, tá bom. Desculpa tava falando só com Gustavo.  
**Evelyn La:** Isso.  
**Elane Lima:** Gustavo.  
**Evelyn La:** Sim, sim. O Gustavo é o nosso SDR e eu sou a especialista aqui do  
**Elane Lima:** Uhum.  
**Evelyn La:** time que faz os diagnósticos,  
**Elane Lima:** Угуm.  
**Evelyn La:** né? Então são ele até me passou seu briefing já previamente ali, inclusive. E aí eu tava dando uma olhadinha no seu Insta. Muito bom, muito bem posicionada já. Maravilhoso. Isso é eh o primeiro impacto, né? O primeiro é a é a nossa porta de entrada ali, né? O nosso antigo catálogo, vamos dizer assim, né?  
**Elane Lima:** É, é, é isso que eu tenho que te dizer,  
   
 

### 00:02:31

   
**Evelyn La:** Agora,  
**Elane Lima:** Evil, assim, justamente porque eu tenho hoje uma pessoa que faz ele para mim, entendeu?  
**Evelyn La:** que bom, que bom.  
**Elane Lima:** Só que ele é muito bom naquilo ali.  
**Evelyn La:** Sol.  
**Elane Lima:** Eh, ele é muito bom de filmar assim,  
**Evelyn La:** Uhum.  
**Elane Lima:** ele tem algum, mas ele me deixa inseguro na agenda, nos processos. Eu, na verdade, eu não sei se é isso também que, por isso que a gente tá também alinhando aqui. É, é isso que eu preciso hoje. Eu já tenho uma carreira sólida na minha cidade,  
**Evelyn La:** Aha.  
**Elane Lima:** tudo, mas sempre foi uma luta assim, sabe, de agenda, de correr atrás, de ter me preocupar com o que os outros estão fazendo. Não, eu quero fazer, eu quero ter agenda, nem me preocupa, eu quero ir trabalhar.  
**Evelyn La:** Só se preocupar com o procedimento em si,  
**Elane Lima:** É,  
**Evelyn La:** né?  
**Elane Lima:** e o pós isso, mas sabe, sem aquela ansiedade, será que eu vou,  
**Evelyn La:** Sim,  
**Elane Lima:** porque assim, quem é profissional liberal fechou o mês, tá de novo, né?  
**Evelyn La:** começa a luta. Eu já tive loja, entendo, super entendo. É bem isso.  
**Elane Lima:** É  
   
 

### 00:03:45

   
**Evelyn La:** Eh, é ali, é você fazer,  
**Elane Lima:** isso.  
**Evelyn La:** você não vender, se não colocar agenda, você não não faz,  
**Elane Lima:** É,  
**Evelyn La:** né?  
**Elane Lima:** não sai.  
**Evelyn La:** E aí, exato.  
**Elane Lima:** Isso.  
**Evelyn La:** Faz tempo que tu tá já então em Santa Areném atuando, Elane. Como que é a tua carreira?  
**Elane Lima:** Eu nasci lá.  
**Evelyn La:** Legal. Ah, bacana.  
**Elane Lima:** Eu fui para fora para estudar porque na época eh não tinha na minha cidade porque é interior do Pará, né? É,  
**Evelyn La:** Aham.  
**Elane Lima:** na época não tinha faculdade lá. Eu sou formada já há 20 anos, mais um pouquinho mais de 20 anos. Não vamos falar muito nesse  
**Evelyn La:** Não vamos entrar nesse quesito detalhes.  
**Elane Lima:** então, eh, assim, aí eu fui embora para fiz federal em Belém, que é a capital, e voltei só para estudar. Aí assim,  
**Evelyn La:** Aham.  
**Elane Lima:** tenho ido embora, fui embora do Brasil já para fazer curso, eu vivo, indo embora, mas sempre ali é meu porto seguro,  
**Evelyn La:** Muito bom.  
**Elane Lima:** a minha  
**Evelyn La:** Sim, sim.  
**Elane Lima:** cidade.  
**Evelyn La:** Aham. E aí, desde então, você atua sempre na sua cidade.  
   
 

### 00:04:46

   
**Elane Lima:** É, sempre,  
**Evelyn La:** Uhum. Muito legal. Muito bom.  
**Elane Lima:** primeiramente com a odontologia normal, tradicional, que era da época, né? Aí eu fui evoluindo, evoluindo até agora cirurgias da face. Eu faço tanto a parte de harmonização como cirurgias da face faço, mas o o meu foco hoje é fazer só cirurgias da face,  
**Evelyn La:** Uhum. Um lift em rino, né? Eu vi que você tem  
**Elane Lima:** na verdade. Eh,  
**Evelyn La:** bastante.  
**Elane Lima:** eu é porque o resto tinha um probleminha com o conselho, entendeu?  
**Evelyn La:** Sim,  
**Elane Lima:** Eh, só que agora o conselho vai liberar.  
**Evelyn La:** sim.  
**Elane Lima:** Eu sou buco maxilo, ainda não coloquei lá como buco porque ainda tá em trâmite no conselho. Aí eu não posso, tem todo um negócio, né? Enquanto realmente, por mais que eu tenha o título e não tenha o registro, eu não posso colocar no Instagram. Então, ainda eu não coloquei ainda, eu tenho só o título de especialista em harmonização facial.  
**Evelyn La:** Sim, sim.  
**Elane Lima:** Aí assim, mas agora inclusive o o meu mentor que eu vim fazer o curso, ele é da comissão que tá vai ter todo toda vai ser tudo liberado.  
   
 

### 00:05:48

   
**Elane Lima:** Então eu faço tudo, desde a Rina, o Bléfaro, eh a o LFT, castanhares, toda a parte de cirurgias da face, entendeu?  
**Evelyn La:** Uhum. Muito bom. Sim, sim.  
**Elane Lima:** Tudo  
**Evelyn La:** Muito bom. É, agora logo logo vai se resolver essa questão aí,  
**Elane Lima:** não tem como segurar,  
**Evelyn La:** tá? É. E o bom de profissionais assim como você que tem essa visão,  
**Elane Lima:** né?  
**Evelyn La:** já buscar se especializar, já vem atuando, já querendo ou não criou a sua credibilidade ali. Então vai, eu falo assim, quem tá aí por primeiro bebe água limpa sempre, né? Agora,  
**Elane Lima:** É.  
**Evelyn La:** aqueles que estão ainda postergando por um por algum motivo,  
**Elane Lima:** É,  
**Evelyn La:** quem já tá vai engolir no  
**Elane Lima:** pega primeiro. É, foi igual na na harmonização,  
**Evelyn La:** mercado. Exatamente.  
**Elane Lima:** né?  
**Evelyn La:** A mesma coisa que foi na harmonização tempo atrás. Então, mas é isso. Que bom, né? Parabéns pela pela visão aí, por toda a trajetória e mais uma vez, né, como eu falei, você tá muito bem posicionada realmente no seu perfil ali em que relação a trazer case e conteúdo e essa mescla que eu falo, né, as nuances entre trazer também quem é Elane pessoa, né, porque isso é importante pra conexão.  
   
 

### 00:07:07

   
**Evelyn La:** Tá ali mãe, mãezona, né,  
**Elane Lima:** É sim.  
**Evelyn La:** três filhos lindos e e isso é muito bom. Eu sou mãe também. O meu é pequenininho. O meu tem sete.  
**Elane Lima:** É, não, não tem  
**Evelyn La:** Eu v ali que você já tem os uns filhos ali bem uma família bem bonita.  
**Elane Lima:** nenhuma.  
**Evelyn La:** Então é legal ter isso. A gente sempre, né, quase a gente pega algum Insta que tá meio assim, a gente fala, viu, trai, mostra também, não mostra só o profissional, porque as pessoas vão se conectar justamente com isso, né? Quem vende? A Elan. A Elane vende,  
**Elane Lima:** Você viu?  
**Evelyn La:** tá?  
**Elane Lima:** Eu fiz, troquei a prótese,  
**Evelyn La:** Eu vi toda chique.  
**Elane Lima:** não sei se você lá, aí eu coloquei,  
**Evelyn La:** Eu falei, mas olha só mulher, gente.  
**Elane Lima:** é porque as pacientes elas adoram ver isso, sabe? Isso aí eu já eu e é meu mesmo.  
**Evelyn La:** Aham.  
**Elane Lima:** Eu gosto de de passar isso, não só só a parte eh profissional em si, mas quem é, porque é uma coisa tá tudo interligado,  
**Evelyn La:** interligada a outra e a pessoa ela vai,  
**Elane Lima:** né?  
   
 

### 00:08:03

   
**Evelyn La:** o paciente ele vai se conectar muito mais com a Elane pessoa, depois ele vai olhar o profissional, mas se ele gostou aqui, ele vai confiar com muito mais certeza em ir, né, em busca de algum procedimento. Então, quanto a isso, tá muito bom. Mas vamos lá. Eh, vamos começar nosso diagnóstico aqui. Vou me apresentar rapidinho, né?  
**Elane Lima:** Vamosar  
**Evelyn La:** Eu sou a Evelyn, sou especialista aqui em estruturas comerciais, braço direito do Renan e do Mateus, que são os donos da System. Hoje nós estamos há 6 anos no mercado. E eu sempre deixo três intenções bem claras antes de iniciar qualquer diagnóstico. Por quê? Primeira coisa, eu tô aqui para ajudar você, tá? Tô aqui justamente para te ouvir, entender um pouquinho mais do seu negócio, de como que tá o seu cenário hoje, como que é a empresa, para de fato eu poder analisar e entender se, opa, a gente realmente consegue ajudar a Elan, a gente consegue com a nossa metodologia implementar e levar ela para um próximo nível, ou seja, tirar você aí do faturamento X, te levar para um próximo faturamento, te trazer mais previsibilidade, te trazer mais tranquilidade mental. tal, né? Questão de uma empresa que se que anda sozinha, que isso é muito do nosso objetivo também com metodologias.  
   
 

### 00:09:25

   
**Evelyn La:** E depois, óbvio, se eu entender que faz sentido analisando o cenário da Ilan, como, né, e quais são os objetivos da Ilan hoje, se eu entender que faz sentido a nossa metodologia e é aplicável para você, aí sim eu te apresento como que a gente faz isso,  
**Elane Lima:** Угу.  
**Evelyn La:** te apresento como que são as nossas estratégias e a que passo que a gente começa, por onde que a gente vai, para você poder entender aí se realmente também vai fazer sentido para você o nosso ecossistema, a nossa nossa metodologia, certo? E claro, se eu entendo que faça sentido, sim, com certeza vou te trazer uma proposta, né? E aí a gente vai eh conversando como que fica confortável para ambos os lados,  
**Elane Lima:** Угу.  
**Evelyn La:** caso venha de fato eu entender que bom, a gente consegue sim ajudar a Elane. Até você falou do Pará e me remeteu muito a uma parceira que nós temos de Paraapebas. Débora, até o o Gustavo te mandou um depoimento dela ali no grupo que a gente marcou, né, as a nossa a nossa reunião. E aí quando eu olhei do Pará, eu falei: "Ó, outra do Pará aqui, ó, outra com super potencial também do Pará". E ela, a Débora, muito semelhante assim em relação a questões de níveis de faturamento, quando ela chegou com a gente, sabe?  
   
 

### 00:10:47

   
**Evelyn La:** Algumas questões ali. Eu falei: "Opa, essa daqui tem potencial também. Hein? E muito fácil de escala, né? Claro, olhando pelo briefing que o Gustavo me passou. Mas vamos lá, Elane, para começar,  
**Elane Lima:** Entendi.  
**Evelyn La:** para entender um pouquinho mais a fundo agora do seu comercial, realmente, como que é esse seu cenário e fala um pouquinho sobre a sua empresa em si, sobre a clínica ali.  
**Elane Lima:** Tá. Hoje a clínica, hoje eu trabalho no que é meu. Eu eu, graças a Deus, eu consegui por esse tempo todo, eu construí um um um espaço, entendeu? Então, a clínica é minha, o espaço é meu, ou seja, eu não pago aluguel, né? É uma estrutura grande, bonita. Se você olhar, acho que tem algum momento lá teve uma reforma. Eh, porque assim, eu eu sou separada. Na verdade, a clínica são dois pisos. Eu fiquei com a parte de baixo, mas ela tá separada as entradas hoje, entendeu? O meu ex-marido, ele ficou com a clínica dele no segundo piso.  
**Evelyn La:** Aha.  
**Elane Lima:** Ô, é no primeiro piso, perdão, no segundo andar, né?  
**Evelyn La:** Aha.  
   
 

### 00:11:56

   
**Elane Lima:** E o meu é o térrio. É, o meu é o térrio, dele é o segundo andar, mas com entradas diferentes. Hoje,  
**Evelyn La:** S  
**Elane Lima:** hoje a gente já conseguiu separar, ele tem a clínica dele e eu tenho a minha. Então é uma clínica grande com energia solar, garagem subterrânea assim para então assim tem uma boa estrutura, mas para mim hoje são oito salas comerciais, oito salas, uma recepção bonita, salas com duas salas dentro. Eu tenho sala desalugada, eu tenho sala parada. Hoje para mim ela tá quase um elefante branco, tu tá entendendo? Eu carrego toda essa estrutura sozinha. Tem uma pessoa comigo, uma farmacêutica que ela tem um faturamento mês bom, mês não tão bom, mas ela tá tem mês que assim, por exemplo, hoje ela parece que eu não tava lá, minha gerente disse que ela fez foi um bom mês, ela conseguiu 70.000, mas ela tem, eu tenho eu tenho equipamentos de 150.000, 180.000, entendeu? Então assim,  
**Evelyn La:** Угуm.  
**Elane Lima:** ou seja, eu eu tenho muita coisa investida lá. É, é um prédio bonito tudo isso e e salas desalugadas que eu poderia ter abranger mais esse espaço.  
   
 

### 00:13:12

   
**Elane Lima:** E eu tenho uma secretária que é a minha,  
**Evelyn La:** Угу.  
**Elane Lima:** ela tem a secretária dela que é a entende? E eu tenho uma secretária, uma gerente. A gerente fica no geral mesmo, né, que é quem olha tudo. E a minha secretária, ela é responsável por telefone, agenda, tudo.  
**Evelyn La:** Certo.  
**Elane Lima:** E eu tenho uma pessoa, um rapaz que faz o marketing  
**Evelyn La:** Fixo com você. Certo.  
**Elane Lima:** fixo.  
**Evelyn La:** Marketing quando você diz e ele faz o teu visual do Instagram. E a estratégia de tráfego pago,  
**Elane Lima:** É.  
**Evelyn La:** tá? Uhum. E a tua secretária, então, ela cuida todo o agendamento e ela faz a venda também ou a venda vai com você?  
**Elane Lima:** Não, a assim, a venda ela faz o agendamento e marca a consulta,  
**Evelyn La:** Aham. E a pessoa vem na consulta e você que vende paraa pessoa,  
**Elane Lima:** né?  
**Evelyn La:** digamos, você que apresenta a transformação ali toda.  
**Elane Lima:** É, é sim.  
**Evelyn La:** E a negociação é contigo na consulta ou você volta a bola para ela?  
**Elane Lima:** é comigo ainda na consulta.  
**Evelyn La:** Uhum.  
**Elane Lima:** Ela é muito boa. Ela tá comigo há quase mais de 10 anos.  
   
 

### 00:14:37

   
**Elane Lima:** Ela só que ela tem umas um pouco de limitação, sabe?  
**Evelyn La:** Aha.  
**Elane Lima:** Assim, algumas coisas me irritam, não sei. Eu queria. E o e o rapaz do marketing,  
**Evelyn La:** Угу.  
**Elane Lima:** ele é a mesma coisa, ele me deixa trabalhando na emergência. Tudo que eu planejo, se eu não cobrar, eu tenho que táar cobrando, eu tenho que táar dizendo: "Olha, dia da mulher, bora fazer 15 dias antes o marketing, não sei o quê". Se eu não falar nada, passa o tempo, quando vê tá lá em cima, ele vai e faz alguma coisinha e o e todo mês eu pago fixo para ele.  
**Evelyn La:** Certo. Você tá pagando?  
**Elane Lima:** Ele não é ruim. É,  
**Evelyn La:** Uhum.  
**Elane Lima:** eu pago, eu pago um valor para ele X para ele filmar e fazer isso. O tráfego pago, eu pago a parte.  
**Evelyn La:** Mas ele que faz a  
**Elane Lima:** Ele só faz a gestão. Eu tenho,  
**Evelyn La:** gestão.  
**Elane Lima:** eu dei para ele hoje uma e eu acho que não sei, não sei como é que vocês trabalham, como é que assim uma média de R$ 3.000 de tráfego pago ao que eu pago  
   
 

### 00:15:39

   
**Evelyn La:** Uhum.  
**Elane Lima:** hoje.  
**Evelyn La:** Que você investe paraas suas campanhas rodarem lá e pegar a captação,  
**Elane Lima:** Mas é isso,  
**Evelyn La:** certo?  
**Elane Lima:** mas tudo é uma questão de faturamento, né? Se eu quero mais, eu posso investir mais.  
**Evelyn La:** Sim.  
**Elane Lima:** Se se tenho um retorno. Então é só é isso. Eh, e ele diz por vári vou ser bem sincera, Evil, por várias vezes eu quis largar ele,  
**Evelyn La:** Uhm.  
**Elane Lima:** só que ele sempre diz, a senhora vai dar com os burros na água porque pessoal de fora do sul não sabe a realidade aqui do Pará. As coisas aqui funcionam diferente, não sei o quê.  
**Evelyn La:** Uhum.  
**Elane Lima:** Você entendeu?  
**Evelyn La:** Uhum.  
**Elane Lima:** ele faz um pouco esse joguinho aí comigo e eu conheço a minha realidade,  
**Evelyn La:** Sei,  
**Elane Lima:** só que assim, ao mesmo tempo que eu digo assim, eu eu quero ir trabalhar hoje com ticket médio mais alto, né?  
**Evelyn La:** claro.  
**Elane Lima:** Mas eu digo assim, eh, por que que os cirurgiões plásticos da minha cidade estão lotados? Então, é porque tem cirur demanda,  
**Evelyn La:** Existe.  
**Elane Lima:** existe cirurgias de 80, 100.000 Aí aos montes a gente vai ver, não é só um, dois, não tem muitos, mas digamos que tem cinco e cinco tão cheio.  
   
 

### 00:16:52

   
**Elane Lima:** Uma cidade de 300.000 habitantes é muito, né? Mas de cirurgias da face, nenhum deles é especialista, nenhum deles tem assim eh eh tem um nome em cirurgias. Então é o momento que eu entro porque não tem um dentista também assim que faça muito, entendeu?  
**Evelyn La:** Perfeito.  
**Elane Lima:** Então eu tenho uma demanda muito grande aí que aí eu digo onde é que não  
**Evelyn La:** Exato.  
**Elane Lima:** tá chegando que às vezes assim o lead eh bom,  
**Evelyn La:** Uhum.  
**Elane Lima:** né?  
**Evelyn La:** Eu ia te fazer justamente entrar nesse quesito. Você falou que tá numa média aí de 3.000 por investimento de tráfego pago. O você sabe dizer o quanto que tem chego de leads por mês? Assim, por exemplo, chega aí uma média, sei lá, 100, 200\.  
**Elane Lima:** Ó, ele me pede 3.000 pro tráfico. É 3.000. Eu não pago para ele. Tem um cartão virtual onde ele usa, ele tem acesso ao meu Instagram também, né? Assim. E ele ele pega eh ele paga R$ 500 todo mês pro Google. Não sei o que é no Google.  
   
 

### 00:17:55

   
**Evelyn La:** Tá.  
**Elane Lima:** E o Google eu mando para ele, mas ele nunca presta conta de nada. Não tenho noção de quanto é o leíd. Eu não sei nada, nada, nada, nada, nada, nada. Ele não me dá nenhum feedback nesse sentido. Olha, Lan, hoje cada teu tá saindo por tanto. Bora fazer is assim. Isso do Google, se ele põe lá ou não, eu também não sei. Não sei, não sei ver.  
**Evelyn La:** Угуm.  
**Elane Lima:** É uma pessoa que tá comigo há algum tempo, eu confio. Não tô dizendo que eu não confio. E ele é bom de filmagem. Mas eu não sei se ele tá sendo bom a nessa outra parte. Eu vou te dizer a minha ideia. A minha ideia era realmente conseguir uma equipe manter ele, nem que eu reduza, pelo menos para fazer os vídeos,  
**Evelyn La:** Sim,  
**Elane Lima:** para manter que ele é bom.  
**Evelyn La:** exatamente.  
**Elane Lima:** Então, não sei. É disso que a gente  
**Evelyn La:** Deixa ele no que ele é bom e o que tá meio nebuloso,  
**Elane Lima:** tá  
**Evelyn La:** aí você pega e faz de outra maneira, né? Porque realmente é que você tá assim,  
   
 

### 00:18:56

   
**Elane Lima:** nisso.  
**Evelyn La:** pela média que você tá investindo em tráfego pago, vou te falar com base no que nós temos de estratégia validada do que a gente já faz. Para você ter uma ideia, a Débora, ela investiu R$ 5.000 nesse mês passado e ela chegou a R50.000 1000 de faturamento com cinco de tráfego no Pará,  
**Elane Lima:** Nossa, isso aqui no Pará.  
**Evelyn La:** ali em Paraapeba.  
**Elane Lima:** E ela faz o quê?  
**Evelyn La:** A fase lifting,  
**Elane Lima:** Ela faz a cirurgia também.  
**Evelyn La:** lifting e bléfaro.  
**Elane Lima:** Hum.  
**Evelyn La:** O de Então,  
**Elane Lima:** Faço tudo.  
**Evelyn La:** pelo que você tá falando aí de do que você tá investindo,  
**Elane Lima:** Nossa.  
**Evelyn La:** no mínimo você teria que tá recebendo, né, por se fossem qualificados aí esse valor de tráfego pago já poderia estar te gerando aí pelo menos o dobro. Chutaria inclusive chutaria sim. É porque é claro, né? A gente fala de estratégia personalizada depois, mas te diria que até três vezes mais do que você já fatura, você poderia estar atingindo, tá? com demanda qualificada,  
**Elane Lima:** Pois é.  
**Evelyn La:** óbvio, mas provavelmente o seu gargalo ele tá tanto na sua gestão de tráfego pago, por ele pode estar fazendo um bom trabalho, como você falou, te posicionando, mas ele não tá sabendo montar a sua estratégia para conversar com as pessoas certas, qualificadas paraa tua secretária depois conseguir esses agendamentos, sabe Porque hoje, qual que é a média ali que você faz de cirurgia por mês?  
   
 

### 00:20:44

   
**Elane Lima:** Então ainda tá eh muito, por exemplo, eu queria poder fazer muito mais, mas assim, agora eu não tenho esse dado até isso tô te falando,  
**Evelyn La:** Sim.  
**Elane Lima:** mas assim, eh, tá muito misturado com a harmonização facial, entendeu? E isso, eu vou te dizer até uma falha minha,  
**Evelyn La:** Uhum.  
**Elane Lima:** eu não sei te dizer quantas cirurgias eu faço por mês, mas eu sei te dizer quantas eu quero fazer.  
**Evelyn La:** Uhum. que é 20 ali em média, né,  
**Elane Lima:** Eu quero é é uma porque hoje  
**Evelyn La:** que eu vi que você passou no briefing ali. Uhum.  
**Elane Lima:** eu cobro R$ 20.000 no lift,  
**Evelyn La:** Aham.  
**Elane Lima:** mas assim é R.000, mas sempre tem o choro, né? Sempre tem aquele negó,  
**Evelyn La:** A negociação ali e tal.  
**Elane Lima:** aquela, né? É,  
**Evelyn La:** Uhum.  
**Elane Lima:** sem tem a negociação. Então assim, se eu conseguir com esse valor, assim, por exemplo, aqui onde eu tô, ele faz três, quatro assim, tranquilo, mas ele tem uma estrutura muito maior, muito tempo, mas que eu faça um por dia, dá para me fazer um lift, dá para me fazer um nariz.  
   
 

### 00:21:44

   
**Elane Lima:** Se eu faço um por dia e no nariz, dá para fazer dois por dia, tranquilo, sabe isso? Tranquilo.  
**Evelyn La:** Aham.  
**Elane Lima:** Nossa, meu faturamento ia lá para cima,  
**Evelyn La:** E ó, exatamente. Você já  
**Elane Lima:** porque eu tenho um custo, eh, eu tenho um custo alto hoje.  
**Evelyn La:** batia.  
**Elane Lima:** Eu tenho para manter a clínica, eu gasto quase 100.000, entendeu? Então, assim, para ganhar 150, 100, eu tô ficando com o quê? Eu tô quase trocando dinheiro.  
**Evelyn La:** Sim. Tá pagando quase para trabalhar, né, Elane? Uhum. Exatamente. E hoje a tua ali falando sobre questões de faturamento, que nem você falou, né? Eh, você para escalar, ajustando pontos aí, né, no seu comercial, alinhando uma boa estratégia, porque pelo que você me passou dele, acredito que ele não sabe trabalhar estratégia de marketing. Ele pode ser muito bom no visual, pode ser muito bom. até teria que verificar essa questão do Google, porque assim, o Google hoje em dia não vai te trazer tanta demanda assim. Os R$ 500 que ele, né, está colocando no Google, você pode reverter pro tráfego pago que vai te dar muito mais retorno,  
   
 

### 00:22:55

   
**Elane Lima:** Pois é,  
**Evelyn La:** tá?  
**Elane Lima:** eu não entendo porque R$ 500 pro Google só para pesquisa,  
**Evelyn La:** É,  
**Elane Lima:** eu acho muito caro.  
**Evelyn La:** sim. E nem não converte,  
**Elane Lima:** Eu acho que ele nem põe tudo isso.  
**Evelyn La:** tá? Isso daí não converte.  
**Elane Lima:** Eu acho que ele nem é, eu acho que ele nem põe tudo isso, sabe assim? Mas eu eu peço para ele me dá um comprovante, ele não dá nada, ele não faz nada,  
**Evelyn La:** Uhum.  
**Elane Lima:** não sei se tem, entendeu?  
**Evelyn La:** Por isso que ele tá te falando que o pessoal do Sul aí não vai te ajudar, porque ele não quer que você ele não quer  
**Elane Lima:** É, é, eu digo assim, não tem, não tem assim,  
**Evelyn La:** Sì.  
**Elane Lima:** não é porque a o que ele diz, é porque, ah, porque o pessoal daqui é diferente, diferente entre aspas, quando a pessoa quer, não tem essa. Pode ter uma renda menor um pouco, pode, mas assim,  
**Evelyn La:** Ela  
**Elane Lima:** um lift bem feito nesse valor é muito mais ainda tá bem mais em conta do que para cá. Não sei quanto lá a a moça cobra em Paraapeba, você sabe?  
**Evelyn La:** tem essa média também de 18 a 20\. Uhum.  
   
 

### 00:23:51

   
**Elane Lima:** É porque depende muito.  
**Evelyn La:** Aí essa sim,  
**Elane Lima:** Tem o lift maior, tem o lift menor, tem assim, tem as nuances,  
**Evelyn La:** tem as nuances e aí os outros procedimentos que às vezes encaixa também.  
**Elane Lima:** né?  
**Evelyn La:** Aí fecha uma venda maior ali, fecha uma de às vezes de, por exemplo, ah, eu eh eh não é só o lifting que a pessoa vai e aproveita para fazer aquele dia e aí ela já fecha ali 30,  
**Elane Lima:** É.  
**Evelyn La:** 35, ticket de 40, vai varia muito, né? Que é a construção da oferta mesmo que a gente diz. Então, eh, demanda com certeza tem, né? É só, é só realmente saber trabalhar, principalmente o quê? a sua comunicação de como vai chegar para essas pessoas, né? Isso é uma grande detalhe por trás da estratégia de marketing.  
**Elane Lima:** É  
**Evelyn La:** Por isso que a gente consegue gerar tanta demanda qualificada, não não necessariamente colocando tanto dinheiro no tráfego pago, tá? Então,  
**Elane Lima:** E e tem eh e tem só uma um porém que também é não é só a minha cidade Santarém, é região,  
**Evelyn La:** Uhum.  
**Elane Lima:** porque tem todo um um uma municípios ao redor menores. Se você observar, tem Santarém, tem Oximiná, eh, Óbos, todas essas pessoas, Rurópolis, elas vêm para mim.  
   
 

### 00:25:16

   
**Elane Lima:** Entendeu? Itituba.  
**Evelyn La:** Aha.  
**Elane Lima:** Depois era bom você olhar as cidades mais ou menos ali são todos t pacientes e potencial para cá para vir para cá. E eles tipo assim pega uma lancha porque aqui lá é diferente, é lancha, não é rio, né? Não é muito estrada.  
**Evelyn La:** Sì.  
**Elane Lima:** Mas você pega uma lancha no mesmo dia você tá aqui. No mesmo dia ele tá, ela tá lá, sai de 7 horas, quando tá meio-dia tá na minha cidade.  
**Evelyn La:** Exatamente. E é um procedimento aqui  
**Elane Lima:** Então eu eu sempre pergunto para ele,  
**Evelyn La:** no raio  
**Elane Lima:** é, eu sempre pergunto para ele, você tá colocando aí como é que tá n cidadezinhas esse trato  
**Evelyn La:** de alcân. Uhum. Sim, sim. Mas, mas é isso, Elane,  
**Elane Lima:** Yes.  
**Evelyn La:** a pelo que você tá me passando, e a sua gerente em si, ela te ajuda mais no quê? questões comercial também ou ela ou ela fica mais na parte financeira, algo no sentido de gestão ali.  
**Elane Lima:** Não. É, a minha gerente, ela é comum, faz tudo, na verdade, quando eu digo, ela tanto me ajuda na parte,  
**Evelyn La:** Aham.  
**Elane Lima:** ela que faz os pagamentos, ela que faz a, ela não faz a contabilidade porque eu tenho uma contadora,  
   
 

### 00:26:25

   
**Evelyn La:** Tá.  
**Elane Lima:** mas aí ela quem organiza documentações, ela que resolve os problemas com os funcionários, ela que faz pagamento, ela que faz compras, entendeu?  
**Evelyn La:** Aham.  
**Elane Lima:** Nessa parte ela me ajuda bastante assim, ela e ela é bem de confiança também.  
**Evelyn La:** Maravilha. Muito bom. Tranquilo. Bom, pelo que você me passou, Elane, por toda a estrutura que você tem, né? estrutura de time, inclusive, porque isso é uma das coisas que a gente avalia muito, porque a nossa metodologia, se você fosse uma pessoa sozinha hoje, por exemplo, na sua clínica, eu nem daria sequência com você, por a gente precisa que o cirurgião ele fique focado só na cirurgia, né? E a outra parte operacional da qual a gente entra com a nossa metodologia para ser executada, a gente precisa que ele tenha esse time, né? que nem no seu caso você tem aí, tem a sua secretária, tem a sua gerente, tem até mesmo o rapaz no marketing, mas principalmente uma secretária, porque a parte operacional, executar, enfim, fica com a quem tá no comercial, porque o nosso foco com a metodologia é justamente eh depois eu vou te explicar com mais calma aqui, porque entendo que faça sentido para você, é justamente essa construção de oferta com valor agregado.  
   
 

### 00:27:52

   
**Evelyn La:** né? Construção de um método, uma metodologia para você, inclusive. Então, você entender quais são seus produtos, por exemplo, da sua esteira hoje, que você considera um produto principal, um produto de saída, um produto de entrada. Isso faz a diferença na hora da gente linkar suas campanhas. É uma boa estratégia de marketing e, claro, processo comercial. Por que que é importante o processo comercial? Porque hoje, se você de qualquer, por um motivo ou outro, essa secretária, ela saia da sua operação, você não fica refém do que e como ela fazia. E você tendo um processo, você vai simplesmente precisei trocar alguma pessoa no time, a pessoa vai sentar na cadeira e você vai só tá aqui, ó. Esse é o processo. Você segue exatamente como tá aqui. Ponto. Isso que vai te trazer a tranquilidade de você não precisar necessariamente toda hora de você no operacional, tá? Mas claro, entendendo um pouquinho do seu cenário, eu vou te apresentar agora como que é a metodologia da System, como que a gente trabalha isso, como que isso é executado para que sim você possa, né, ao longo da apresentação, fica à vontade para tirar dúvidas, mas você entender como funciona o nosso ecossistema, se ver se você realmente vê sentido, né, no nosso ecossistema e você fazer parte, aí eu sempre faço um combinado também que é o quê?  
   
 

### 00:29:24

   
**Evelyn La:** No final da minha apresentação, eu vou te pedir, Elane, hoje é sim ou é não? Por que que eu sempre falo, né, o sim ou não? Para nós não existe talvez. O talvez também é um não para hoje, certo? Ou um sim, Evelyn, faz sentido. Podemos dar sequência, vamos começar a acelerar ou não, Evelyn? Hoje é não e o prazer é o mesmo. E o objetivo da sessão aqui contigo é justamente eu entender, entender seu cenário que foi que a gente fez agora. O próximo passo vai ser eu te apresentar a metodologia para você entender como funciona e ver se vai fazer sentido. Se de fato que eu te apresentar, você entender que poxa, isso aí vai me resolver. Ótimo, maravilha. Agora se você falar, Evelyn, tem uma coisa aqui. Olha, o quê? Não vem muito sentido. O prazer foi o mesmo, Elane, porque o nosso papel aqui é justamente isso, ajudar, não atrapalhar e te mostrar que existe um caminho sim, que você pode fazer isso de forma mais tranquila, organizada, eh eficiente, inclusive, que vai ser como? Deixa eu te apresentar aqui um pouquinho da System agora. Posso contar com o seu sim, com o seu não hoje? Vamos lá, então.  
   
 

### 00:30:42

   
**Elane Lima:** Sim.  
**Evelyn La:** Hoje nós temos uma metodologia que se chama face sem car assistem digital a empresa. Nós temos essa metodologia que foi responsável até hoje por ajudar muitos cirurgiões, principalmente alavancarem seus resultados, mas mais do que isso, organizar processo, né? Implementar processos. Então, hoje o Renan e o Mateus, que são os donos da Sistem, já estamos há dois, há 6 anos no mercado, estou há do anos com eles, inclusive. A nossa especialidade é gerar a demanda qualificada e implementar os processos comerciais. Porque o que que a gente entendeu ao longo desse trajeto aí? Há um tempo atrás, lá na pandemia, você só fazer tráfego pago resolvia até uma parte. Ah, eu colocava ali, né, uma um tanto de valor em tráfego pago, sem muita estratégia, muitas vezes, sem me preocupar tanto com posicionamento. E isso me gerava até uma demanda legal, bacana, OK? Muita gente cresceu, aproveitou aquela aquele tempo ali, só que muita gente também deu errado, porque o que que as agências na maioria se preocupam em fazer? Só gerar volume, né? é muito profissional do do tráfego pago, muito gestor, que surgiu, né, pipocou gestor de tráfego pago naquela época, porque era só gerar demanda.  
   
 

### 00:32:12

   
**Evelyn La:** Ah, toma aí, tô te entregando 600, 500, 400 L por mês, toma aí meu trabalho, eu tô fazendo. Que que é o grande problema? O que que é o grande gargalo que a gente enxerga, né? Enxergou, viu e falou: "Não, pera aí. É porque só gerar demanda não quer dizer que eu vou vender, não quer dizer que o lead que tá vindo realmente ele é qualificado, ou seja, ele tá de fato dispostos a pagar, a investir, a entender, a buscar, a marcar um agendamento ou comparecer. E aí nós hoje trabalhamos com as duas, os dois pilares principais, vamos dizer assim, para uma clínica realmente rodar, que é a demanda qualificada e o processo comercial. A demanda qualificada, ela vai vir de algumas estratégias ali, depois eu te explico melhor, que vem que antecede o tráfego pago. E o processo comercial, ele é o pós do tráfego pago. Por quê? Não adianta também eu ter um lead qualificado, disposto a pagar e chegar no seu comercial e a pessoa ela não cumpriu o processo, não gerou a necessidade, não vendeu o agendamento, não vendeu a consulta com a Ilan e aí o lead se desinteressa e aí às vezes a gente acaba perdendo pessoas qualificadas também.  
   
 

### 00:33:31

   
**Evelyn La:** Então, a gente dominou essas duas frentes ao longo desses 6 anos e hoje nós trabalhamos como parceiro. A gente não é uma agência de tráfego pago. Nós não somos uma mentoria também que, ah, vou falar paraa Elane, ó, você tem que fazer isso, isso, aquilo e agora faz você. Então, nós somos um parceiro, ou seja, nós trabalhamos junto com o cirurgião na clínica para ajudá-lo a implementar e treinar o time dele. Então, é como se a gente entrasse como parceiro mesmo nesse sentido, um braço direito é de cirurgião para ajudar nesse quesito. Por quê? Porque a gente vai fazer a parte mais operacional junto, né? Então a gente entendeu que isso faz mudar o jogo. Então o Renan, ele já tá há 5 anos gerindo times de alta performance,  
**Elane Lima:** А  
**Evelyn La:** já fez mais de 15 milhões em vendas com clínicas. O Mateus é o nosso gestor estratégico. Então o Mateus, a gente chama ele do nosso, o nosso nerd aqui dos funis, porque o Mateus é que entende muito bem essa parte de marketing, estratégia de marketing, construção de perfil ideal, que é a matriz que a gente fala que você precisa ter isso mapeado para aí você rodar campanha, senão vai acontecer aquilo lá de gerar um monte de lead e ninguém compra nada, sabe?  
   
 

### 00:34:50

   
**Evelyn La:** Então,  
**Elane Lima:** Muitos.  
**Evelyn La:** Mateus cuida exatamente dessa parte para você ter ideia.  
**Elane Lima:** A minha, desculpa te interromper, a minha secretária é o que mais ela reclama.  
**Evelyn La:** Imaginação.  
**Elane Lima:** Doutora, chega muito todo dia, mas eu eu vou, eu dou o preço, ninguém ninguém evolui um ou outro. Ela ela reclama muito disso.  
**Evelyn La:** Uhum. E aí tem um detalhe também, essa forma como a sua secretária está conduzindo essa pessoa até o seu agendamento, até o seu comparecimento com você. Isso muda muito, eh, no sentido assim, o quanto você, ela, ela precisa entender que ela vai tá fazendo ali uma pré-venda. Então ela vai precisar entender alguns pontos chaves, inclusive essa coisa de passar preço, como fazer isso, como não fazer também, porque às vezes a gente acaba perdendo pela comparação que o paciente acaba fazendo da Ilan com o outro porque só passou o preço. Então existem algumas etapas também nessa nesse ponto do qual a gente treina e e traz todas as estratégias ali, mas o Mateus é o que fica responsável por desenhar primeiro, fazer esse mapeamento para depois linkcar a campanha. Para você ter ideia, a gente tem hoje parceiros que fazem aí investimento de 1000, 100 em tráfego pago, gera uma boa demanda qualificada que responsável aí por 150, 200 K de faturamento.  
   
 

### 00:36:17

   
**Evelyn La:** Então assim, eh, claro, quanto mais você querer atingir, mais a gente vai investir, mas de forma mais estratégica e não simplesmente soltar e queimar dinheiro, porque literalmente você tá, você dá tiro no escuro sem fazer o mapeamento antes. Então, Mateus responsável por isso. Essa aqui é a Débora que eu te comentei que é de Paraapebas. A Débora, ela entrou com a gente faz 5 meses.  
**Elane Lima:** Угу.  
**Evelyn La:** Ela entrou faturando cerca na média ali de 150.000 e hoje ela tá fazendo 500, 550k a mês. Nós estamos com o projeto para ela bater 1 milhão mês agora pros próximos seis meses aí que estiver à frente, que ela vai fazer renovação com a gente. E a Débora, ela virou nossa embaixadora e sócia embaixadora. pelo fato do case realmente que ela virou e sócia porque ela tá abrindo um braço educacional na empresa. Então, ela tá agora numa frente de criar mentorias também presenciais paraas pessoas que querem aprender a técnica dela. E aí a gente tá em sociedade com ela nesse ponto que é uma,  
**Elane Lima:** Nossa, é muito parecido. Eu também fiz também assim,  
**Evelyn La:** Olha aí.  
**Elane Lima:** tenho muito curso de cirurgia,  
   
 

### 00:37:26

   
**Evelyn La:** Uhum.  
**Elane Lima:** tenho eh 2003,  
**Evelyn La:** Olha aí,  
**Elane Lima:** eu me formei em 2003  
**Evelyn La:** ó. Não, a hora que a que o Gustavo falou de ti,  
**Elane Lima:** também.  
**Evelyn La:** eu na hora eu linquei, já falei: "Nossa, muito parecido mesmo com a Débora". Então, por isso que assim, potencial você tem muito, com certeza. É ajustar uns parafusos na dentro da sua operação comercial e tráfego pago. Tenho certeza. sabe pelo que você me trouxe ali, porque você já tem um nome, credibilidade, tempo de mercado aí que é o mais difícil de construir no início. Então isso daí você já fez posicionamento, você tem são ajustes mesmo, ajustes assim, detalhes na operação e processo, claro, né? Esse foi um dos resultados que a gente já conseguiu gerar aí dentro de um mês. E claro, a gente sempre diz assim: "O que que é o cenário atual do mercado? A 90% das clínicas que fizeram parte do nossos dos nossos da nossa metodologia, eh, daquelas que estão com a gente hoje, a grande frustração do dono da clínica era essa, falta de previsibilidade das em decorrência do quê? de falta de processo. Eh, muitas vezes a estratégia de marketing equivocada, né, ou tinha uma agência para marketing que só gerava volume.  
   
 

### 00:38:48

   
**Evelyn La:** Então, é muito parecido isso, eh, a questão de dores em relação ao mercado. E o que que a gente entendeu mapeando tudo isso? A gente entendeu que a solução é trazer o quê? trabalhar as dois pilares, essas duas frentes, gerar demanda qualificada, obviamente com uma estratégia correta para marketing e o processo comercial para converter essa demanda qualificada. É um conversando com o outro, tá? Então isso faz realmente você mudar o jogo. O que que acontece? os riscos de você fazer sozinho, sem conhecimento, muitas vezes, porque chega num ponto onde, por exemplo, o ponto que a Elane tá, a clínica não anda,  
**Elane Lima:** Eh,  
**Evelyn La:** se não tiver você lá, você não dá conta de fazer  
**Elane Lima:** e eu já tô batendo esse fatura.  
**Evelyn La:** sopinha.  
**Elane Lima:** Eh, eh, e assim, eh, esse faturamento eu tô não tô conseguindo escalar, já tem um tempo nesse faturamento, ou seja, a inflação cai, o tempo passa e eu tô assim,  
**Evelyn La:** Tá ali.  
**Elane Lima:** sabe?  
**Evelyn La:** Estagnou.  
**Elane Lima:** Eu não tô conseguindo.  
**Evelyn La:** Estnou.  
**Elane Lima:** É,  
**Evelyn La:** Exatamente.  
**Elane Lima:** cheguei no  
**Evelyn La:** Exatamente. Porque assim, vamos lá.  
   
 

### 00:39:58

   
**Evelyn La:** A Eline,  
**Elane Lima:** teto.  
**Evelyn La:** a Elane hoje é ótima profissional e cirurgia da face, né? E aí o que que o risco de fazer sozinho? Essa, principalmente a parte comercial. O comercial, a gente diz assim, o coração da empresa é através do comercial que vai vir a escala da Ilan, é através do comercial que vem a escala da clínica.  
**Elane Lima:** Ja.  
**Evelyn La:** Então o coração da empresa, ele precisa tá bom, é o que vai bombear para todos os outros pilares. Se você tá com um bombeamento fraco, de fato, você vai estnar. E aí a especialidade de quem tá muitas vezes na técnica não dá conta de de fazer isso sozinho. Isso é normal, é 95% dos casos, não tem como, né? Então o que que é o papel da System? É justamente por nós termos a metodologia validada, o conhecimento, ajudar esse cirurgião ao quê? não ficar refém e dependente, principalmente processos de funcionário, ter um processo padrão dentro da clínica que o funcionário que eh se molda ao padrão da clínica e não a clínica que fica refém do que o funcionário vem fazendo. Isso vai te trazer o quê? A tal clínica que anda sozinha. Por quê? Porque ele vai ter um padrão, ele vai ter ali, ó, no dia, ele tem a rotina, ele sabe o que fazer.  
   
 

### 00:41:30

   
**Evelyn La:** Depois dessa fase, para onde eu vou? Vou para cá. OK, eu já sei o que eu tenho que fazer. O máximo que a Elane vai tem que fazer é o quê? É cobrar pelas etapas que sejam feitas, entregar um relatório no final do dia, no final do mês, que seja, conforme você implementar. Mas o dia a dia, a sequência, isso aí, um processo padrão, ele existe para te trazer a empresa que anda sozinha, para você não se precisar se preocupar, para você trabalhar com tempo, tranquilidade, tranquilidade mental, sabendo que assim, pô, eu tenho agenda X, Y, Z e é isso. E tá andando, né? Cada um tem que saber o seu papel. Então, eh, trazendo essa tranquilidade o processo, inclusive algumas estratégias que vão trazer previsibilidade e venda é o aumento do seu LTV. que é o LTV dentro da empresa hoje, que é o que a Sistem promove, ajuda, ajuda nisso. Conforme a gente constrói a sua metodologia, a gente vai te trazer oportunidades novas para você revender pros seus próprios pacientes. Isso aumenta o seu LTV, que a gente diz, que é o tempo que o seu paciente passa investindo com você. Então ele faz uma cirurgia hoje, mas ele vai precisar um retoque.  
   
 

### 00:42:51

   
**Evelyn La:** Ele vai querer talvez uma outra cirurgia daqui um tempo.  
**Elane Lima:** Uhum.  
**Evelyn La:** Então a gente vai trabalhando que isso vai te trazer  
**Elane Lima:** A venda recorrente, né? Aquela  
**Evelyn La:** tranquilidade e previsibilidade.  
**Elane Lima:** venda.  
**Evelyn La:** Você não vai depender só de tráfego pago para você poder gerar venda, pro seu comercial poder fazer acontecer. É a base também, cuidar de quem você já conquistou. Então a gente a Sistem, ela vem muito com isso, porque aí eu sempre pergunto, né, quanto valeria hoje paraa Elane ter uma clínica que anda sozinha, ter um tráfego pago de qualidade, que você sabe que vai ter entrada, que tem processo, que você vai conseguir trabalhar sossegada e, óbvio que você vai fazer revenda inclusive paraa sua base, que é o que a gente chama de protocolo de caixa, aonde você não precisa investir toda hora no tráfego pago e você consegue mesmo assim manter faturamento, que é o que a Débora faz muito hoje. Então, ela consegue ter previsibilidade. Por quê? Porque a secretária faz o followup e revende. E só nessa revenda às vezes ela bate R$ 170.000 só na revenda. Ou seja, quanto valeria paraa Elane hoje saber que, putz, eu faturei 200k, mas mês que vem eu tenho uma previsibilidade já de 150, por exemplo, só da recorrência da minha base, que eu já tô plantando aqui, que a minha secretária tá fazendo os followups ali necessário.  
   
 

### 00:44:28

   
**Evelyn La:** Então isso já vai te trazer mais segurança, vai te tirar aquela ansiedade do de que o querendo ou não, todo dono de negócio tem, né, aquele a correr o risco, mas no sentido assim pode ser mais previs, não precisa putz, agora a corrida dos ratos todo mês. Agora de novo, paga conta e vamos lá.  
**Elane Lima:** Essa essa corrida dos ratos que me mata, que tá,  
**Evelyn La:** Então,  
**Elane Lima:** eu já não aguento mais.  
**Evelyn La:** quanto valeria hoje, Lani? processos que tirem você desse sufoco.  
**Elane Lima:** É, eu não sei mensurar isso de tipo assim,  
**Evelyn La:** Assim, valeria que eu digo assim,  
**Elane Lima:** realmente  
**Evelyn La:** não financeiro, até financeiro, porque vai te trazer economicidade, mas eu digo, quanto valeria hoje para você profissional trabalhar mais relaxada,  
**Elane Lima:** é  
**Evelyn La:** não tanto no alerta, sabe?  
**Elane Lima:** é isso, isso aí realmente valeria bastante. Só se assim eh eh isso se ser concreto,  
**Evelyn La:** Claro,  
**Elane Lima:** você tá me entendendo? É porque claro, a gente sempre tem um medo, será que para mim vai dar certo?  
**Evelyn La:** claro.  
**Elane Lima:** Será que que vai se ajustar? Será que eu consigo ajustar isso? Será que meu time vai? É, é, é isso.  
   
 

### 00:45:42

   
**Elane Lima:** Mas realmente é o meu, é o meu foco. Eu sei que a gente, eu eu sou muito positiva, entendeu? Eh, mas a gente também tem que ser pé no chão em tudo,  
**Evelyn La:** Claro, claro.  
**Elane Lima:** né?  
**Evelyn La:** Concordo plenamente. Concordo. É por isso mesmo que aqui a gente fala assim, esse novo mercado que a gente ajuda a construir na clínica, eu sou muito realista também com com quem vem na nas sessões aqui. Eu falo assim, ó, eu não prometo resultado, não faço promessas aqui, não. Por quê? Aqui a gente vai te mostrar uma metodologia que precisa de fato ser executada e a consequência é o resultado financeiro. Mas o financeiro ele é só uma consequência do passinho que a gente ajuda a implementar, que vem antes. Então o seu resultado implementando, ele vai vir de um jeito ou de outro. pode ser muito positivo no sentido assim, nossa, um primeiro mês eu fazer três, quatro vezes mais o faturamento, pode ser positivo ao ponto de fiz ali 20, 30% a mais e vou canando e vamos ajustando.  
**Elane Lima:** e estamos ajustando, né?  
**Evelyn La:** Exatamente. Então, muito na realidade,  
**Elane Lima:** Também sou muito realista nisso.  
**Evelyn La:** muito no pé no chão, né?  
   
 

### 00:47:00

   
**Evelyn La:** Tanto que eu falo assim, nossa metodologia hoje é o quê, Lane? Essa mandala que você tá vendo, nós temos oito pilares. Hoje na clínica da Ilan, se nós fôssemos começar a executar e trabalhar, como que seria o passo a passo paraa execução desses pilares? Todos eles são importantes. Parece muita coisa, eu sei que parece, mas na prática é bem mais simples. Mas para você poder entender metodologia, eu preciso falar dos oito. O que que é o funil de marketing comercial, por exemplo? É aqui que a gente define a primeira etapa, é a primeira reunião estratégica para você poder entender a sua metodologia. Como assim a metodologia, Evelyn? A gente pega todos os seus produtos que você tem hoje, as suas ofertas e dentro disso nós organizamos para você o que cabe dentro de um produto principal, que é o que você mais vai ter um ticket, o que cabe com um produto de saída, que é aquele produto de menor ticket, mas que você pode vender bem e depois esse mesmo paciente ir pro ticket maior E o produto de entrada, que é um produto de entrada? Um produto que ele fica no meio termo, que você pode tanto puxar essa pessoa para um ticket maior, quanto você fazer outras revendas de saída também. Então, essa primeira sessão estratégica, esse primeiro, essa primeira reunião dentro do funil de marketing, ele vai te trazer essa clareza, porque a gente estrutura isso tudo certinho com você.  
   
 

### 00:48:47

   
**Evelyn La:** como que você pode construir a sua oferta. Por que que eu preciso ter a clareza primeiro disso? Porque a partir disso que a gente vai mapear a melhor estratégia de tráfego pago, que é daí que vem a demanda qualificada. Então, o pilar do funil de marketing é isso, funil de RH e pré-vendas. Funil de RH e pré-vendas. O RH aqui é só um auxílio que nós proporcionamos pro cirurgião. Quando, por exemplo, ele ele tem um na equipe, ele quer contratar mais um, eh, e ele não tem muita referência e essa pessoa pode ser home office. Aí nós temos um banco de talentos que a gente indica, porque o trabalho que a secretária faz, o trabalho que o alguém no Instagram vai fazer, pode ser home office, dependendo qual a função. Então, nós temos isso para ajudar quando precisa. E o funil pré-vendas é quando a gente entra na parte operacional para mostrar todas as etapas que a secretária precisa cumprir para aumentar o quê? Agendamento, comparecimento. E ela já entender de contornos de objeções, de como levar essa pessoa para o comparecimento no do agendamento. E aí tem várias nuances entre mensagens que ela precisa seguir certinho o nosso script. Porque uma coisa, ela precisa levar essa essa pessoa num grau aonde ela vende a Elane, ela vende a transformação que a Elane causa na vida da pessoa.  
   
 

### 00:50:22

   
**Evelyn La:** Porque quando a gente mapeia, por exemplo, o perfil para criar o tráfego pago, que que a gente mapeia junto com você? Que que a gente entende? A maioria das pessoas que buscam hoje um procedimento estético são mulheres. Por quê? Porque a grande maioria tem um problema com o quê? A própria autoestima. Ela quer resolver isso no final da dor dela. E aí a gente ensina no pré-vendas, que é o funil de pré-vendas, que é o trabalho com a secretária, ela entender o por trás do porque a pessoa precisa, do que é o procedimento para ela saber conduzir e levar essa pessoa de uma forma mais assertiva. Porque se a gente entra só com preço, se a gente entra só com isso ou aquilo, o que acontece? Ele vai te comparar com o mais barato e ele não vai enxergar o valor que há por trás de tudo que a Elane entrega, né? Então, a gente trabalha isso, trabalha o funil de vendas, que aí é a venda em si, ou seja, tem uma etapa especial para isso, tem um porquê, tem uma apresentação de vendas também para você entender como que faz isso. Construção das suas ofertas, protocolo de caixa rápido, que é o para aplicar na sua base e fazer aquela revenda ali para quem já é paciente.  
   
 

### 00:51:40

   
**Evelyn La:** Gestão do processo comercial, que aí aqui entender algumas métricas. tá? Do, por exemplo, quanto tá entrando de leads, isso a sua secretária que vai alimentar um software que a gente disponibiliza. Mas ao final do mês é bom você ter esse número. Você acessa essa essa planilha, você vai ter, ela é bem intuitiva. Você tem lá, por exemplo, entrou 100 pessoas no funil, foi convertido 40, entrou tanto de caixa nisso, entrou tanto desse daqui, entrou converteu o X. Você tem essa clareza. e o pilar do tráfego pago que entra como um auxílio, né? A gente nem coloca tanta eh pressão assim em relação a tráfego pago, porque aquilo que a gente fala, a roda toda ali girando é o que vai fazer acontecer, não é? Eh, isoladamente uma coisa ou outra, a gente vai trabalhando todos os pilares. Então, no funil de marketing, que foi o que eu te falei primeiro, a gente tem uma estrutura. Não se preocupe em querer entender essa estrutura aqui, mas é só para você entender que nós temos essa organização. A gente vai ter essa estrutura para definir as suas portas de entrada, ou seja, por onde vão vir os seus pacientes, pelo tráfego, pela indicação, por parcerias, por trabalho no Instagram, tá?  
   
 

### 00:53:02

   
**Evelyn La:** Então, a gente tem definido todas essas portas de entrada e todas as etapas para cada porta dessa. No pré-vendas, é o que eu te falei, trabalho com a secretária, mentalidade, parte de contorno de objeções, parte dela entender que ela vende, ela já está vendendo, ela já está criando um relacionamento, uma conexão com esse paciente. Ela não tá simplesmente ali para atender, ver um horário, agendar e ficar por isso mesmo. Não existem etapas. Inclusive essas etapas a gente dá o nome de followup, que é o quê? O followup são os retornos que ela vai fazendo com esse paciente para manter ele aquecido. Às vezes o agendamento é para daqui 15 dias, ela não vai ficar 15 dias sem falar com ele. Vão ter etapas, óbvio que não vai ser todo dia também, mas vão ter etapas que ela segue. Isso tudo para ela seguir e não se perder tem dentro de um funil de CRM que a gente fala. CRM é uma plataforma aonde ela vai ter o nome de todas as pessoas que entraram em contato e ela tem as etapas ali que ela vai só movendo o nome de um pro outro, que é o quê? Etapa de primeiro contato, segundo contato, terceiro. Agendou, compareceu. Sabe só um minutinho que o meu telefone tocou rapidinho.  
   
 

### 00:54:34

   
**Evelyn La:** No.  
**Elane Lima:** M.  
**Evelyn La:** Chegou meu pequeno. Mas aí o CRM ele é importante para isso. Eh, hoje não sei se tu tem CRM lá. Tu tu tem  
**Elane Lima:** Ev. Evely, Evely, deixa te explizer.  
**Evelyn La:** o  
**Elane Lima:** Eu não tenho nenhum processo,  
**Evelyn La:** Nenhum.  
**Elane Lima:** nenhum assim, fora o marketing que ele faz lá a venda, a o funil, não sei que ele usa. A minha secretária, ela tem um pouco de orientação, tem, mas juro para ti, ela chega comigo e diz assim: "Doutora, eu falei: "Ana, tá chegando tudo isso, tu a falo, mas quando o paciente quer, ele agenda logo e não tem problema e faz logo." Mas quando não quer, como se ela não soubesse. Você tá entendendo? Inclusive, eu já tô pensando em trocar. Ela é muito boa para pós-venda, porque ela é uma pessoa dedicada, cuidadosa.  
**Evelyn La:** M.  
**Elane Lima:** Isso eu já percebi. Então, ela tem o cuidado com o cliente para saber se tá tudo bem, para não ter intercorrência.  
**Evelyn La:** Ah, bom,  
**Elane Lima:** Mas a venda,  
**Evelyn La:** bom.  
**Elane Lima:** juro para ti, se eu não fosse muito quem eu sou, assim, a pessoa quer muito, tem que querer, entendeu?  
   
 

### 00:56:20

   
**Evelyn La:** Nem vendia.  
**Elane Lima:** Nem vendia. Muita gente me vê no Instagram se gosta de mim, uma grande maioria vem disso e e assim mesmo tem gente que chega: "Doutor, eu fui eu fui em Manaus fazer isso.  
**Evelyn La:** Você  
**Elane Lima:** Eu nem sabia que a senhora fazia, porque até lipt eu faço,  
**Evelyn La:** deve tá deixando na mesa aí uns 200 K por  
**Elane Lima:** entendeu? É, é assim, juro, não tem processo nenhum, nenhum assim,  
**Evelyn La:** mês.  
**Elane Lima:** tem, já tentei muito, mas é aquela coisa, eu não consigo porque eu não tô lá. A minha gerente, ela é boa tudo, mas é muito difícil o o o humano na minha região. Você tá entendendo?  
**Evelyn La:** Sim.  
**Elane Lima:** A proatividade? Eu sou proativa no que eu faço. Eu sei o que eu faço, mas não sei se sou eu que não sei contratar. Não sei. Essa moça que a secretária,  
**Evelyn La:** Uhum.  
**Elane Lima:** como te disse, ela é muito boa no pós, ela é de confiança com dinheiro, entendeu? uma pessoa que eu de olho fechado,  
**Evelyn La:** Sim, sim.  
**Elane Lima:** mas ela não tem ela não tem jogo de cintura com as pessoas quase.  
   
 

### 00:57:25

   
**Elane Lima:** Alguns gostam muito dela, outros não gostam, mas assim, eu não sei o tanto que eu tô perdendo nisso. Eu não sei esse funil que tu tá falando, isso daqui nada, nada, nada, nada tem isso no consultor, nada. Ela mal dá conta da agenda de responder do jeito dela. Ela ainda diz assim: "Ai, doutora, a gente vai". Eu falei: "Mas tu tu fala do produto, mostra". Eu digo, ah, às vezes eu vou falar, o pesso o o paciente já vem dizer quanto é. Ah, tu enrola muito, me diz logo quanto é. Aí eu digo: "Ai, meu Deus, tem alguma coisa errada, mas sabe quanto tu tem que tá lá trabalhando?"  
**Evelyn La:** Sim, sim. você tem que tá executando, você tem que tá 100% atenção plena na no seu procedimento. Mas vou te falar,  
**Elane Lima:** É isso.  
**Evelyn La:** no seu caso, Elane, eh para contratar a gente tem, como eu te falei, a questão do do funil do do RH ali. Inclusive, se você quer contratar alguém presencial, a gente consegue te ajudar nesse nesse feeling e nesse levantamento de um perfil comportamental melhor que se adeque para  
**Elane Lima:** eh proativo, entendeu?  
   
 

### 00:58:30

   
**Evelyn La:** esse  
**Elane Lima:** uma pessoa que seja, olha, já me disseram assim: "Ai, tu não dá porcentagem pra tua secretária". Eu digo, eu pago alguma coisa mais para ela assim, mas eu não vejo para isso,  
**Evelyn La:** exato. Exato. A pessoa pra venda,  
**Elane Lima:** entendeu?  
**Evelyn La:** pro pré-venda, ela ela tem um perfil específico. Isso aí a gente passa, inclusive, tá ali, a gente dá esse direcionamento, porque ela precisa entender que o quanto melhor ela performar, mais ela vai ganhar. Mas para ela ganhar, ela vai ter que entregar resultado. Então é nessa nessa mentalidade que a gente trabalha. E aí quando a gente treina eles, a gente treina inclusive essa mentalidade. Mas óbvio, a pessoa ela precisa ter essa proatividade meio que nela já, ela já entenda que o comercial vai ser isso, sabe?  
**Elane Lima:** Isso tem coisas que você não consegue, você adequa, mas é nato.  
**Evelyn La:** É nato. Isso. E aí você vai melhorando. Então, se você já notou que ela é melhor para um pós, às vezes você tirar ela realmente dessa função e colocar no pós, ela vai render muito mais. e você ter alguém que seja perfil para venda, aí você vai ter mais resultado no sentido até de confiar, entregar mais processos, porque vai ser executado, né?  
   
 

### 00:59:59

   
**Evelyn La:** Mas é referente à questão de você como contratar,  
**Elane Lima:** Sim.  
**Evelyn La:** como eu saber qual que é melhor, o que que não é, isso tudo a gente tem como orientação, tá? Então o funil de CRM ele ajuda nessa, principalmente nessa organização para quem vai assumir a função, né, de desses primeiros contatos e tudo mais. E aí nós trabalhamos dois modelos comerciais. O primeiro modelo, que é essa estrutura toda aqui, a gente já tem tudo isso pronto, validado, é só a pessoa executar de fato. Você não vai precisar e nossa, Evely, tô vendo tanta fase aqui, eu vou ter que pensar. Não, cada fase dessa a gente já foi pensado e já tá tudo pronto. Só para você entender, o modelo comercial um, essa estrutura toda é para trabalhar o quê? novas vendas, novos pacientes, pacientes novos que vão normalmente vir por ou indicação ou tráfego pago. E o modelo comercial dois, toda essa estrutura para execução, ele vai ser realizado em pacientes pronto seu de base, ou seja, aquele que já fez uma harmonização, aquele que já fez uma cirurgia, aquele que já fez alguma outra coisa e até mesmo aquele que agendou e não veio. Ele não veio por algum motivo.  
**Elane Lima:** Угуm.  
**Evelyn La:** E aí a gente reativa ele por quê?  
   
 

### 01:01:16

   
**Evelyn La:** Por mais que ele tenha feito às vezes um procedimento em outro lugar, a Elane não tem só lipo, a Elane não tem só lifting, a Elane tem várias outras ofertas dentro da esteira de produtos e aí a gente reativa  
**Elane Lima:** Угуm.  
**Evelyn La:** ele e às vezes faltou só alguma comunicação nisso e aí a gente consegue trazer ele de volta. Então, a gente trabalha com isso e é o que vai te trazer o setor de alta performance,  
**Elane Lima:** Угу.  
**Evelyn La:** né, que a gente diz que que é o alta performance. É o fazer acontecer, né? Eu fazer acontecer. Então, todos os scripts a gente tem pronto e dentro da construção das suas ofertas, que é aquilo que eu falei, é a reunião estratégica que a gente vai definir os seus produtos principal, produto de entrada, produto de saída. Tudo isso vai ter a construção das suas ofertas, porque um produto principal ele pode englobar o quê? Há uma estrutura de olhar ali, toda a parte de estrutura de olhar mais o lifting. E aí o pós-venda, que que você pode colocar no seu pós-venda dentro desse produto principal que vai reter esse cliente com você? Então, a gente estrutura isso para você, para você ter essa clareza. Porque quando você vai para vender um lifting, por exemplo, você não vai só vender um lift, você não vai só vender uma rin no seu produto principal, você vai ter o a mais ali que agrega no seu valor, que é o que daí que a gente vai tirando depois produtos, eh, pessoas para trabalhar sua base, ticket maior que você pode chegar.  
   
 

### 01:02:55

   
**Evelyn La:** Então a gente vai fazendo essa construção. Então é nessa etapa do comercial e os protocolos de caixa rápido, eles vão ser as estratégias, são oito que nós temos para você executar dentro da clínica com os pacientes que você já tem e com a base que muitas vezes tá fria, que é aquele paciente que entrou em contato, não compareceu ou que fez um procedimento e nunca mais apareceu ou sabe, a gente reativa isso. E aí nós temos oito protocolos que podem ser trabalhados também. A gestão do processo comercial aqui entra muito essa questão de da organização do processo no sentido de você entender as tuas métricas. Como assim, vamos supor, nós temos um aqui que eu te falei que a gente tem a ferramenta pronta, que é só você colocar, é só a a funcionária colocar o número lá mesmo. Por exemplo, essa semana entrou 15 pessoas, entrou 50 pessoas. entrou 30 pessoas em contato, ela só vai colocar 30, 50, só isso. O próprios, o próprio própria ferramenta, ela é intuitiva, ela calcula tudo, ela já depois vai mostrar o resultado final, que é o interessante pra Elane ver tudo.  
**Elane Lima:** Evely, eh, essa e essa isso tudo você já tem. Vocês dão, ó, diz assim, tá aqui, ó. vai fazer aqui, trabalhar aqui e assim vocês t como ver assim: "Opa, aqui não tá indo bem, tem como ajustar, bora ver como é que tá, por que não tá indo, o que que tá acontecendo, onde tá o gargalo.  
   
 

### 01:04:29

   
**Evelyn La:** Tem, exatamente. A gente tem a ferramenta pronta pra gente poder depois, por exemplo, o primeiro mês rodou campanha, rodou protocolo de caixa para trabalhar base, a funcionária sua lá foi e preencheu a planilha. No final do mês, a gente vai, você vai olhar você vai olhar a sua, a sua, a sua média ali, você vai entender os números, vai ver, poxa, entrou 200 lead, 150 entraram em contato, 50 eh vieram para consulta, 35 foi venda. Ah, legal. Então, eu sei que eu fiz X, valor de faturamento. A maioria dessas pessoas veio pelo quê? tráfego pago, indicação. Isso tudo a gente tem na planilha para paraa secretária preencher mesmo, porque aí você vai entender aonde que tá sendo melhor conversão sua, se é do seu tráfego pago ou se é da indicação ou se é do trabalho de base. Porque é através desses números que a gente vai melhorando aonde tem um gargalo ainda, por exemplo. Pô, não tá funcionando muito bem a indicação. Ou vamos entender então por quê? Porque a gente, a indicação, ela é uma estratégia que a gente fala e passa pra secretária para ela executar, para ela pedir de fato a indicação mesmo.  
   
 

### 01:05:52

   
**Evelyn La:** Só que não é assim, ô, me indica mais um aí para Não, tem uma uma estratégia, tem uma abordagem correta de como ela vai fazer esse pedido de indicação, porque é um paciente que vem sem você precisar investir. Então, é bom para ela, é bom para você. Bom para ela por quê? Porque na hora que você for trabalhar, por exemplo, uma porcentagem de comissão, se é um indicado, ela pode ganhar um pouquinho mais.  
**Elane Lima:** essa parte de de eh de como fazer esse vocês também  
**Evelyn La:** Sim,  
**Elane Lima:** orientam como fazer essa essa Como é que  
**Evelyn La:** tudo abordagem.  
**Elane Lima:** essa eh não eh essa no caso da porcentagem,  
**Evelyn La:** Ah, sim.  
**Elane Lima:** esse estímulo para pra secretária de uma forma que porque hoje o que eu faço,  
**Evelyn La:** Uhum.  
**Elane Lima:** vou te dizer, foi um grande erro. Eu e a minha secretária tem um salário e ela tem um valor fixo a mais ela vendendo ou não  
**Evelyn La:** Ah,  
**Elane Lima:** vendendo.  
**Evelyn La:** sim.  
**Elane Lima:** E eu já pensei em mudar isso,  
**Evelyn La:** Uhum.  
**Elane Lima:** entendeu?  
**Evelyn La:** Exatamente. Por quê?  
**Elane Lima:** Ou se caso ela ficar só no pós, eu mantenho aquele  
**Evelyn La:** Isso. E aí quando você for trazer uma pessoa pro vendas,  
   
 

### 01:07:01

   
**Elane Lima:** porque isso  
**Evelyn La:** quando você trouxer, você já traz com essas eh eh com essa definição de, ó, o seu salário é esse e a comissão vai ser de acordo com X, Y, Z. Esse valor de como eu fazer a comissão, como direcionar, a gente te ajuda também, a gente te dá direcionamento para isso, porque tem diferença entre você comissionar um PJ, por exemplo, de um CLT, né? Porque o CLT ele vai te ter mais encargos, então o comissionamento dele é menor,  
**Elane Lima:** Så  
**Evelyn La:** mas ele tem uma meta também, aonde você pode ir trabalhando com ele ali.  
**Elane Lima:** Угуm.  
**Evelyn La:** O PJ ele pode ter um comcionamento um pouco maior, porém ele não tem os encargos. Então te gera economicidade e ele vai trabalhar obviamente mais para cumprir as metas, porque ele vai, quanto mais ele fizer, mais comissão vai entrar.  
**Elane Lima:** É,  
**Evelyn La:** Então,  
**Elane Lima:** é,  
**Evelyn La:** nessa nessa direção aí disso,  
**Elane Lima:** entendi.  
**Evelyn La:** a gente a gente te ajuda  
**Elane Lima:** Eh, porque assim,  
**Evelyn La:** sim.  
**Elane Lima:** o que eu eu eu tenho isso é muito claro na minha cabeça que se paga.  
**Evelyn La:** Se paga fácil.  
**Elane Lima:** É isso que é isso que que eu quero te entender. Às vezes eu reclamo para eles lá de eu digo: "Gente, porque muita despesa porque tá entrando, tá entendendo? Então assim,  
   
 

### 01:08:26

   
**Elane Lima:** eu tô vendo que eu tô de certa forma patinando.  
**Evelyn La:** Exatamente.  
**Elane Lima:** Eu não preciso ser uma contadora, uma grande, tá entendendo? Então assim, ah, eu eu não acho ruim pagar mais ou a agência ou ou o que for, mas com que isso seja compatível com o que tá  
**Evelyn La:** Exatamente.  
**Elane Lima:** entrando.  
**Evelyn La:** Tem que fechar a conta,  
**Elane Lima:** Então, se eu quero,  
**Evelyn La:** né? No final do mês tem que fechar a  
**Elane Lima:** se eu isso justamente,  
**Evelyn La:** conta.  
**Elane Lima:** se eu tô, se eu tô aqui querendo algo a mais, é porque eu quero um faturamento a mais. E se eu tenho um faturamento, a, o que é esse X diante desse montante X aqui?  
**Evelyn La:** e vou te  
**Elane Lima:** Então isso eu sou muito consciente,  
**Evelyn La:** falar.  
**Elane Lima:** entendeu Evely? Por isso que eu acho que tem que, se todo mundo trabalhar direito e se a gente conseguir, eu fazendo a minha parte, você se der certo, quem sabe vocês não vão ter um segundo  
**Evelyn La:** O segundo que esse do Pará ainda, hein?  
**Elane Lima:** cas.  
**Evelyn La:** Porque eu vou te falar pelo que você me passou de estrutura sem sem estrutura, que eu tô falando física sua de clínica, funcionário e tudo mais, portfólio que você já faz, que você já atua aí com os procedimentos que você atua, com o que você me trouxe, eh, de tá vendendo sem você ter nada disso aqui.  
   
 

### 01:09:46

   
**Evelyn La:** Posso, olha, posso estar equivocada? Posso, mas eu te confio que você no mínimo tá deixando os 200k a mais de faturamento só por não ter o processo, só pela secretária não tá sabendo conduzir e a tua demanda muitas vezes pode ser também que ela esteja chegando muito desqualificada e aí ela tá encontrando essa dificuldade em conduzir realmente. Mas pelo que você tem de estrutura física  
**Elane Lima:** Eh, não quer dizer que eu não tenho nada,  
**Evelyn La:** hoje,  
**Elane Lima:** eu não tenho processos organizados assim, se eu te disser que eu sei como é que ela venda, o que que ela faz, eu não sei. Você tá me entendendo?  
**Evelyn La:** sim, sim.  
**Elane Lima:** É disso assim, ela não tem um, ela ela até preenche algumas coisas para saber quanto entra, quanto sai. Hoje eu tenho um livro caixa, algumas coisas assim mais ou menos. Mas, por exemplo, eu vou te dizer, eu realmente não sei quantas cirurgias eu faço por mês.  
**Evelyn La:** E isso a gente eh eh é importante você começar a ter esse olhar mais cirúrgico, vamos dizer assim, literalmente paraa sua operação, porque é desse olhar que você vai entender que, opa, é necessário 50 leads qualificados para eu vender 25\. E desses 25 eu tenho uma previsibilidade de faturamento de X valor.  
   
 

### 01:11:12

   
**Evelyn La:** Desse faturamento,  
**Elane Lima:** Eh  
**Evelyn La:** eu sei que eu consigo reinvestir pro meu crescimento 10, 20, 15%. E é aonde você traz o planejamento de escala. sem você ter, sem essa mensuração, dificilmente você vai conseguir ter um número claro, porque ele fica muito confuso, que de fato eu não sei quanto eu preciso chegar,  
**Elane Lima:** É,  
**Evelyn La:** para quanto eu atingi, pro quanto que eu tô de média de ticket.  
**Elane Lima:** É, se eu não sei onde eu quero chegar,  
**Evelyn La:** Se  
**Elane Lima:** eu fiz eu fiz um planejamento estratégico com a minha gerente, mas eu acho que até ela não sei direito, sabe? A gente fez um planejamento, tipo assim, eu vi que eu faturei no mesmo mês, ano passado,  
**Evelyn La:** Aham.  
**Elane Lima:** e coloquei 10% em cima.  
**Evelyn La:** Mas o caminho do como chegar a ele.  
**Elane Lima:** É, aí esse caminho a gente fez mais ou menos algumas coisas, viu datas do ano, o que que vai ter, coisas que a gente fazia, por exemplo, eu tenho duas eh semanas eh que eu faço promoção, que é semana da beleza, mas são coisas que eu já queria mudar porque é muito harmonização e eu realmente já tô  
**Evelyn La:** Sem, sem.  
**Elane Lima:** de saco cheio da história.  
   
 

### 01:12:26

   
**Elane Lima:** Quero, eu trabalho, eu gosto da pele de alguma, algumas coisas, mas não daquele 10 botox num dia para ter 10 retorno.  
**Evelyn La:** Sim,  
**Elane Lima:** Você tá entendendo isso?  
**Evelyn La:** exato. É trabalhar de forma mais estratégica,  
**Elane Lima:** Isso aí é um saco.  
**Evelyn La:** fazendo mais caixa e menos operacional,  
**Elane Lima:** É,  
**Evelyn La:** menos ali, sabe, juntando para ganhar no volume.  
**Elane Lima:** é, por exemplo, é isso.  
**Evelyn La:** Não.  
**Elane Lima:** Eu não quero não. Vou hoje, por exemplo, aonde eu tô aqui, ele faz cirurgia.  
**Evelyn La:** Uhum.  
**Elane Lima:** É sério, ele faz no mínimo aí uns 50.000 E o dia com que ele faz ali pode, tem dias que é mais, tem dia que é menos, mas quando dá 3 horas da tarde, ele tá indo embora paraa casa dele,  
**Evelyn La:** Exatamente, porque trabalha estratégico.  
**Elane Lima:** ele fica direto. Eu não, às vezes eu tenho quando à 7 horas da noite ainda tô lá morrendo assim até a sabe a a minha secretária, ela não tem um manejo. Às vezes quando eu vejo, eu tô com buraco na agenda, tô esperando alguém chegar, aí eu vou falar assim, é, tem muita coisinha que tem  
**Evelyn La:** colocar a detalhes na operação, parafusos que a gente fala, né, que você vai apertando, você vai apertando, vai ajustando, vai apertando, vai ajustando.  
   
 

### 01:13:34

   
**Evelyn La:** E esses detalhes é que vão fazer a diferença do retorno, por é um agendamento eficiente que ela faça, é um retorno eficiente que ela faça. Para quê? Para que também pompe de você tempo, para também que você trabalhe de forma mais estratégica no sentido do quê?  
**Elane Lima:** Justamente. Eu  
**Evelyn La:** A construção de oferta, construção e definição de produto vai te ajudar justamente a trabalhar de forma estratégica.  
**Elane Lima:** não tenho eu não sei qual é o meu produto de entrada. Eu eu sei que eu gosto de rino, tanto que tá lá, tá referência rino, eu tenho, mas mas eu tenho outras coisas hoje.  
**Evelyn La:** Sim.  
**Elane Lima:** Eu quero, eu eu até tava pensando quando eu voltar em pegar alguns pacientes chaves para eu fazer eh eh porque tem ainda eu ainda esbarro muito em pacientes que não deixam postar pela legalidade,  
**Evelyn La:** Aham. Sim, sim, sim, sim.  
**Elane Lima:** porque é uma cidade de pequena,  
**Evelyn La:** Tem gente que não  
**Elane Lima:** eles não querem mostrar que não permite.  
**Evelyn La:** Uhum.  
**Elane Lima:** Então eu ainda esbarro nisso, mas aí eu digo, não, vou fazer, vou pegar umas duas ou três mulheres com casos bem legais, fazer dois lifts assim, paciente modelo, sabe,  
**Evelyn La:** Aham.  
**Elane Lima:** para que a gente consiga bater bem, para eu ter casos para jogar, entendeu?  
   
 

### 01:14:48

   
**Evelyn La:** Sim,  
**Elane Lima:** Então tudo isso eu já tô até vendo agora. Casos de rina, eu já tenho até bastante.  
**Evelyn La:** legal.  
**Elane Lima:** Eh, quando o conselho for liberando, eu vou eu tenho muito caso de blefer, eu tenho outros casos legais que eu não posto, mas eu não posso não posso postar, mas eu posso vender no consultório.  
**Evelyn La:** Isso,  
**Elane Lima:** É assim que eu  
**Evelyn La:** exatamente. E é nesse ponto que a gente chega junto para te ajudar a construir uma apresentação de  
**Elane Lima:** faço.  
**Evelyn La:** vendas, porque na apresentação você vai trazer esses cases. Depois quando o conselho se, né, tiver tudo resolvido, aí você abre mais publicamente,  
**Elane Lima:** É isso.  
**Evelyn La:** mais no seu consultório você pode mostrar, entendeu? E aí na apresentação de venas a gente te ajuda a entender e a montar isso. Nós temos um design inclusive que entrega a apresentação.  
**Elane Lima:** Угуm.  
**Evelyn La:** Você só precisa disponibilizar o material que é a foto, as fotos ali, né? Por quê? Porque é justamente aí é onde você vai mostrar a sua transformação, onde você vai de fato fazer a venda acontecer, tá? Então, Elane, esse é o nosso ecossistema. E aí eu queria entender de você aqui agora dúvidas sobre algum pilar em específico?  
   
 

### 01:15:59

   
**Evelyn La:** Eh, ficou claro para você a nossa metodologia de trabalho? Você acredita que essa metodologia faz sentido para você hoje, paraa sua clínica?  
**Elane Lima:** Ev, posso no banheiro?  
**Evelyn La:** Claro,  
**Elane Lima:** Rapidinho,  
**Evelyn La:** claro, com certeza.  
**Elane Lima:** um minutinho.  
**Evelyn La:** Imagina. Acabou.  
**Elane Lima:** M. Voltei.  
**Evelyn La:** Então,  
**Elane Lima:** E então,  
**Evelyn La:** Elane, que que você me diz aí?  
**Elane Lima:** Ev. V.  
**Evelyn La:** Agora que eu te ouvir.  
**Elane Lima:** É assim, é isso, é isso que eu quero. Vou te dizer, na verdade, eu olhei vocês no Instagram, assim, foi uma coisa meio que atirei onde vi e talvez acertei no que não vi, entendeu? Eu sei, você me manda até o, eu devo ter seguir, mas eu até queria de novo o Instagram de vocês,  
**Evelyn La:** Sim, sim,  
**Elane Lima:** entendeu? tá assim,  
**Evelyn La:** claro.  
**Elane Lima:** eh, porque na verdade é isso que eu quero. Eu eu vim com uma sensação quando eu tava vindo lá do curso muito boa. A gente sempre tem essa intuição, né,  
**Evelyn La:** E mulheresa intuição ainda mais forte.  
**Elane Lima:** um pouquinho eh forte.  
   
 

### 01:17:40

   
**Evelyn La:** Diga-se de passagem, né,  
**Elane Lima:** É,  
**Evelyn La:** El?  
**Elane Lima:** é, é, eu, eu esbarro um pouco em algumas coisas, por exemplo, porque esse rapaz do marketing comigo tá comigo há muito tempo. Ele tá comigo,  
**Evelyn La:** Certo.  
**Elane Lima:** ele era jovem aprendiz quando eu chamei assim, sabe, lá na antes da pandemia,  
**Evelyn La:** Uhum.  
**Elane Lima:** quando eu comecei a crescer, ainda fazia parte de odontologia, ele aprendeu comigo, ele errou e ele vem errando e eu venho aceitando os erros dele,  
**Evelyn La:** Certo.  
**Elane Lima:** ele vem. Você tá entendendo? Eu já tenho no meu coração há muito tempo que eu preciso dar um basta nisso, que ele tá atravancando, que ele é muito legal como pessoa, mas como profissional ele deu até aqui que eu que eu preciso  
**Evelyn La:** Isso aí.  
**Elane Lima:** de alguém que me ajude de outra forma no marketing com processos  
**Evelyn La:** Exatamente.  
**Elane Lima:** bem a para inclusive, olha, por exemplo, a minha gerente, ela é muito boa, mas também precisa de um direcionamento.  
**Evelyn La:** S.  
**Elane Lima:** Ela pode ajudar muitos vocês. A minha secretária, inclusive, eu eu sei que ela eu já tenho, já sei que ela é não é da da venda, ela é do pós e eu inclusive eu vou até começar a ver a possibilidade de de outra  
   
 

### 01:18:55

   
**Evelyn La:** Sim,  
**Elane Lima:** pessoa, mas para eu aumentar, mas ao mesmo tempo eu não sei ainda como funciona o o o financeiro de vocês,  
**Evelyn La:** sim.  
**Elane Lima:** né? Mas para eu aumentar isso, eu tenho que aumentar aqui. Eu tenho um suporte, claro que eu posso aguentar, mas eu preciso que a clínica renda mais do que ela faz hoje para segurar isso  
**Evelyn La:** Com certeza.  
**Elane Lima:** aqui. Digamos que eu segure o primeiro, o segundo mês,  
**Evelyn La:** Sim,  
**Elane Lima:** você tá entendendo?  
**Evelyn La:** mas já tem que tá faturando o mínimo dobro no segundo mês.  
**Elane Lima:** Para depois se manter.  
**Evelyn La:** Sim, com certeza.  
**Elane Lima:** É isso, é disso que eu tô te falando, entendeu?  
**Evelyn La:** Sim.  
**Elane Lima:** sendo que as duas partes, as duas partes, e, e eu tô consciente que a gente tem que ter uma meta. Eu sou consciente de que no primeiro mês tem muita coisa a ajustar, que talvez a gente não chega naquele naquele naquela meta,  
**Evelyn La:** Sim,  
**Elane Lima:** mas é uma coisa ajustável que pode ser alcançado depois. Eu sou bem consciente de tudo isso,  
**Evelyn La:** isso,  
**Elane Lima:** mas claro, isso tem que evoluir, não regredir.  
**Evelyn La:** exatamente, exatamente. E aí, por isso que eu te pergunto, com tudo o que você viu até agora de metodologia, né, o como a gente vai aplicar, eu vou te dar, né, a dou sequência com você.  
   
 

### 01:20:07

   
**Evelyn La:** Eh, posterior é o que realmente assim você vê de valor no sentido da nossa metodologia. Poxa, Evelyn, tudo que você me trouxe agora, né, em relação à metodologia do quê? da gente cuidar do seu tráfego, da gente cuidar das suas estratégias de marketing, treinar a sua secretária, eh até mesmo se for o caso de você precisar fazer uma outra contratação, a gente também cuida desse treinamento. Com tudo que eu te trouxe sobre a nossa metodologia de como a gente ajuda e implementa. Você vê vê sentido em ter isso pra sua clínica, pra sua realidade hoje? Você ter hoje em pré-vendas, protocolo de caixa rápido para trabalhar aí faturamento já de base, sabe? Você vê sentido nisso do que eu te falei hoje?  
**Elane Lima:** Sim, com  
**Evelyn La:** Se eu falasse assim, Elane,  
**Elane Lima:** certeza.  
**Evelyn La:** isolando o fator financeiro, fosse só pela metodologia, hoje você estaria em parceria com a gente?  
**Elane Lima:** Sim.  
**Evelyn La:** Maravilha. Então é isso, que bom que você viu o sentido na nossa metodologia aqui da na nesses oito pilares, né, que a gente trabalha, que eu te apresentei, porque de fato pela estrutura que você tem, eu arrisco a dizer mais uma vez, você tá deixando os 200k na mesa e para fazer isso acontecer, como que a gente executa?  
   
 

### 01:21:39

   
**Evelyn La:** Então vamos lá. Então os anúncios pagos, que é o tráfego pago, que eu já te falei, né? A gente define aqui, a gente cuida do seu marketing também nesse sentido. Hoje você tem um menino lá, seria interessante, eh, né? Claro, isso a decisão é sua, mas ele realmente ficar só mais nessa parte de videomaker, de produção do seu conteúdo, porque ele já faz muito bem feito, que é o pelo seu Instagram ali, dá para ver que é muito bem feito mesmo. Mas a estratégia em si e até mesmo o valor de você eh colocar ali em tráfego pago, tudo é uma coisa que a gente cuidaria para você. Ou seja, a gente, primeira coisa, ia fazer esse mapeamento do perfil de cliente ideal para você. Depois a gente já construir, definir os produtos que eu te falei principal de entrada, de saída. Com todo esse mapeamento, aí sim a gente tem a clareza da melhor definição de estratégia para linkcar no seu tráfego pago, porque aqui é um tiro certeiro. Você não vai ficar nem e eu arrisco a te dizer que num primeiro mês com esses 3.000, se você colocasse os 3.000, a gente já conseguiria alavancar em muito a parte de qualificação de leads, tá? Mas a a em relação à questão do quanto também investir tudo isso, o Mateus te dá um direcionamento bem mais redondinho, porque antes da gente te falar, ah, investe 1000, investe 1.00, investe X valor, a gente vai definir estratégia primeiro para ti,  
   
 

### 01:23:16

   
**Evelyn La:** tá? Então, a gente faz como hoje a gente tem o programa de aceleração, ele tem a duração de 6 meses, então são se meses que você caminha com a gente, tá? E a gente implementa ao longo desses 6 meses estratégias, tanto dentro daqueles oito pilares ali, quanto se precisar reavaliar, eh, recalcular a rota, a gente faz. Mas num logo no primeiro mês, a gente já entra em execução com todos os oito pilares ali. E aí a gente vai organizando de que maneira? A Elane entrou, a gente vai ter o plano start. Primeira reunião, a gente já marca plano start, que é o resumo realmente de toda sua jornada. Quem faz esse plano start é a Mari, uma das nossas estrategistas. Ela vai te explicar o passo a passo, ela vai tirar dúvidas específicas com você dentro desse plano start e ela já vai marcar a segunda reunião estratégica de plano de ação, que vai ser com a Alane. A Alane vai trazer com você a construção das ofertas de produto, vai definir a sua metodologia, produto principal de entrada, de saída, vai definir com a Elane e vai definir questões para apresentação de vendas, porque a gente já manda material pro nosso design para ele já ir eh agilizando essa parte. Terceira. E aí a Alane já, a Alane já marca a terceira reunião estratégica que é com o Mateus e o Pedro, que o Pedro é o gestor de tráfego pago e o Mateus é o estrategista.  
   
 

### 01:25:01

   
**Evelyn La:** Porque quando o Mateus entrar numa call estratégica com a Elane, ele já vai ter o mapeamento da Mari e da Alan, que é a parte de eh a sua apresentação de vendas, os seus produtos, a sua esteira de produtos. E é a partir disso, desse mapeamento, ele vai junto com você te dar o direcionamento, te mostrar e te passar como serão as estratégias específicas para o seu perfil para fazer a captação depois do tráfego pago. Então, nós temos três reuniões estratégicas e depois, ao longo desse período, você tem direito a mais seis reuniões estratégicas que aí você pode solicitar a partir do momento que você queira. ao longo da jornada, primeira coisa que a gente disponibiliza já no mês, os protocolos de aceleração. Por quê? Principalmente para você que tem base, você não tá começando hoje a clínica, você já tá um um bom tempo, a gente já libera essas estratégias para ir sendo aplicadas no primeiro mês, porque daqui já pode acontecer de sair caixa, ou seja, faturar. A gente tem cases de pessoas que numa semana aplicando o protocolo de caixa rápida, chegou o faturamento de 70.000. A gente já chegou cases nesse sentido. Tem outros que vão, assim, tô te falando o melhor cenário que a gente já teve de case de protocolo de aceleração em uma semana.  
   
 

### 01:26:30

   
**Evelyn La:** Todo mundo já chegou a isso? Não. Mas é uma possibilidade para quem tem base de cliente já de tempo. Porque o que que impacta? duas coisas aqui para o protocolo funcionar bem ou não. Uma, se a base for muito ruim, ruim que eu digo assim, muito paciente desqualificado, muita gente que veio de um tráfego pago, que é muito ruim, realmente ele não vai ter uma performance boa ou ele não tem base, é alguém que tá começando mais recente, não tem tanta base, não tem tanto número de paciente de base. Então, essas são as duas coisas, só que impacta. Mas se a base é considerável ali boa e tem um número legal, conseguimos converter uma parte dessa ainda. Como que é o processo de acompanhamento ao longo dos seis meses? A gente cria um grupo VIP. Nesse grupo VIP fica a dona do negócio, os estrategistas da nossa equipe que vai ser responsável por cuidar junto com a dona do negócio das partes estratégica. E caso você queira colocar mais alguém, você pode colocar, por exemplo, ah, Evelyn, gostaria de pôr a minha gerente também. A gente coloca gerente também para ela acompanhar. E no outro grupo a gente inclui a sua secretária, porque deu um grupo exclusivo só para secretárias para tirar dúvidas específicas só dessa parte e a gente não mistura as coisas daí, tá?  
   
 

### 01:28:00

   
**Evelyn La:** Como que funciona a secretária? Ela vai participar das tutorias, porque nós temos tutorias ao vivo. Essas tutorias elas vão servir para quê? Justamente para tirar dúvidas, para ajudar, para auxiliar, para trazer sobre o conteúdo. Que que é esse conteúdo? O conteúdo ele tá dentro das trilhas de conteúdo específica. Isso aqui são conteúdos gravados que lá na primeira reunião estratégica a Mari já diz: "Ó, seu secretária tem que assistir X, Y, Z de aula para ela começar a entender. Ou ah, fulano tem que, então a gente a gente direciona isso, tá? Esses conteúdos gravados eles servem para quê? Justamente paraa secretária se ambientar. E as tutorias ao vivo é para ela tirar dúvidas. Dúvidas o quê? A gente vai entregar uma documentação pronta. Os Sweep File é só um nome bonito que dão para documento. A gente tem tudo documentado, né? Tanto que a gente fala assim, se for contabilizar em valor de mercado, tudo que a gente entrega, ele chega a esse valor aí aproximado. Claro que a gente não cobra por isso, tá? Isso é parte do que a gente entrega junto, mas a gente entrega todas as suas callas de planejamento, vai ficar gravado para você para sempre.  
   
 

### 01:29:18

   
**Evelyn La:** Todos os treinamentos que são gravados vai ficar com você. Protocolo de caixa rápida, as estratégias a gente vai eh disponibilizar para você para sempre. A gente não fica, ah, eu vou eu te disponibilizo uma esse mês, mês que vem em outra. Não, tudo que a gente tem aqui, que a gente vai te entregar, vai ficar disponível para você por tempo limitado depois, né? modelo de apresentação de vendas, design, tudo isso. E aí os treinamentos então para vendas, pro pré-vendas e pro social seller, que é a parte do Instagram ali, que quando você tem um perfil bem posicionado, que é o seu caso, a gente trabalha também com essa estratégia para gerar interação e puxar pessoas do seu Instagram para fazer agendamento para você, tá? Esses aqui que são gravados, você fica com acesso a eles para sempre. E aí você po a as meninas direcionam quando a sua secretária, por exemplo, for assistir, a gente diz: "Ó, aula tal você assiste para você se ambientar". Depois ela vai assistindo, vai tirando dúvidas e vai executando ao mesmo tempo. Essas aulas é só para uma questão dela se ambientar com conteúdo, mas script, processo, tudo isso a gente vai passar para ela, para ela ir executando na rotina, para ela ir entendendo, ah, qual abordagem eu faço primeiro com o paciente, qual estilo de abordagem, isso tudo a gente ajuda ela para ela entender que que a gente dá de bônus.  
   
 

### 01:30:55

   
**Evelyn La:** A implementação do CRM. Esse CRM aqui, ele tem uma mensalidade para quem é nosso acelerado, a gente consegue um desconto. Ele fica R$ 137 por mês, tá? para quem quer utilizar dele. E para implementar a gente eh ajuda na implementação e aí o pessoal não cobra e só fica com a mensalidade. O CRM é o responsável pela organização de tudo. Inclusive você consegue ter métricas aqui, ó, de quanto que entrou de faturamento, como que tá as vendas. E essa implementação a gente ajuda a fazer e a gente ajuda também a pessoa a entender como é que ela vai lançar tudo certinho ali, como que a secretária  
**Elane Lima:** Eh,  
**Evelyn La:** lançar.  
**Elane Lima:** no, eh, por exemplo, eu tenho um sistema que roda no não é a mesma coisa.  
**Evelyn La:** A gente teria que ver qual que é esse sistema no sentido assim,  
**Elane Lima:** A não  
**Evelyn La:** eh, se ele poderia ser usado como um CRM. Se ele pode ser usado como CRM,  
**Elane Lima:** quer  
**Evelyn La:** ok, não é obrigatório você ter esse CRM aqui, mas se você quiser, a gente por ter parceria, né, com o pessoal lá, eles disponibilizam esse desconto na mensalidade, a gente ajuda na implementação.  
**Elane Lima:** pronto. Mas aí é uma casa, uma coisa que de se ajuste,  
   
 

### 01:32:14

   
**Evelyn La:** Exatamente.  
**Elane Lima:** né?  
**Evelyn La:** É uma coisa de ajuste. Se o que você tem dá para usar,  
**Elane Lima:** Por é porque essa essas métricas são  
**Evelyn La:** maravilha.  
**Elane Lima:** fundamentais,  
**Evelyn La:** fundamental para você tomar decisões mais baseada realmente no dado, dados, né?  
**Elane Lima:** é de direcionado,  
**Evelyn La:** Você direcionado.  
**Elane Lima:** né?  
**Evelyn La:** Um dos dos bônus também já tá incluso o nosso gestor de tráfego pago, ou seja, eh o bom é que o Mateus é o estrategista e o Pedro é o que vai fazer a gestão. Então, ambos ficam no mesmo grupo ali contigo depois. tudo que precisa ser resolvido, tudo que precisar ser direcionado, enfim, estratégia, é dúvida, que os dois já estão a par do assunto, né? Vamos dizer assim. E aí você não precisa também, por exemplo, ah, eu preciso contratar um gestor às vezes por fora, não. É como a gente falou, né? mantém, quem sabe esse rapaz que você tá só para uma determinada função. E as outras funções as quais você tá aí colocando dinheiro que não tá tendo retorno, você já você já gera uma economicidade para você. Outro bônus que eu te falei, esse painel aqui, ó, que ela vai, a secretária, ela vai colocar, ah, no dia 1 de março, por exemplo, quantas pessoas chamaram no Instagram?  
   
 

### 01:33:34

   
**Evelyn La:** Quantas que responderam, quantas que não, isso tudo ela vai colocar no sistema e depois ela vai só colocando aqui, ela só vai preench a planilha ela é intuitiva, ou seja, no final você vai você vai olhar só aqui em cima o resumo do quanto que realmente converteu de todo o que foi eh tanto implementado quanto foi captado de paciente. Ela é bem simples, tá? Quando a gente a gente roda ela depois e disponibiliza, ela é bem simples, porque é só o preenchimento, é só o cuidado realmente de alimentar ela, só isso. E toda a documentação, como eu falei, a gente disponibiliza, fica disponível para vocês depois. Até aqui, alguma dúvida, Elan? Como executa a metodologia?  
**Elane Lima:** Não é assim ainda, tá, né? Mas dúvida, dúvida não tem coisas que só colocando em vendo,  
**Evelyn La:** vendo acontecer.  
**Elane Lima:** colocando em prática que a gente vai tendo mais dúvidas,  
**Evelyn La:** Sim, sim. Uhum. Eh,  
**Elane Lima:** né?  
**Evelyn La:** até deixa eu te mostrar aqui. A gente tem os grupos só para você entender esse acompanhamento, né, personalizado. Como que seria? Deixa eu compartilhar aqui  
**Elane Lima:** Ah.  
**Evelyn La:** contigo. Deixa eu só ver aqui achar a da a da Carla até aqui.  
   
 

### 01:35:09

   
**Evelyn La:** Deixa eu ver se eu tenho lucro. E por exemplo aqui, ó. Só para você entender o grupo quando a gente cria, tá dando para ver bem aí, né? A gente cria o o grupo,  
**Elane Lima:** Tá. Por que que não  
**Evelyn La:** por exemplo, aqui, ó, aceleração Carla.  
**Elane Lima:** celular?  
**Evelyn La:** Então, aqui fica ficou o jurídico dela que ela que ela quis colocar, as nossas estrategistas, né, as gerente dela, que ela tem uma gerente também. E aí, por exemplo, a gente vai fazendo todo o acompanhamento aqui com ela. É que aqui não carregou todas as as mensagens. Eh, que eu abri meu WhatsApp hoje porque hoje porque o outro desconfigurou, mas aqui, ó, a entrada dela. Aí a gente faz o quê? Aqui a gente marca as reuniões. Aqui a gente marca com ela toda a parte que precisa de documentação. A gente vai conversando sobre aí. Aqui a gente vai conversando, ó. Amanhã apenas o horário para poder agendar, para poder fazer o quê? As reuniões principais, né? Então a gente vai linkando, já colocamos a já coloca a pauta de reunião, as meninas vão cuidando tudo certinho aqui, ó. Primeira reunião dela estratégica, ó, o Mateus da esteira de produtos.  
   
 

### 01:36:46

   
**Evelyn La:** Trabalhamos os três pilares, né? E organizamos a estrutura de apresentação, criamos a previsibilidade de vendas.  
**Elane Lima:** Trabalhamos.  
**Evelyn La:** Aqui tutoria, a gente manda também no grupo para participar. Então tudo isso a gente, a nossa comunicação basicamente ela vai sendo pelo grupo ali, pelo acompanhamento assim, full time, tá? Então a ó, próximos passos aí aqui a Alane já direcionou a secretária dela lá, ó. Próximos passos, assista a aula de vendas e apresentação de vendas na plataforma e preenche o formulário para nós. Beleza? Próximo passo aqui foi a construção da metodologia dela. Então, a estrela de produtos elaborados. Ótimo. Depois reunião feita para definir estratégia de marketing e formulário preenchido. Então, a gente vai trazendo todo o direcionamento e as reuniões estratégicas marcadas previamente, com certeza, né? E aqui a gente vai acompanhando. Então, por exemplo, ah, tive alguma dúvida, alguma coisa, marca ali quem é o estrategista do qual você quer conversar, né? Marca ali no grupo, manda, pede, chama o Mateus, chama o Renan, eu, né, que eu fico acompanhando também os os que dos quais eu faço parte, porque assim, é uma é bem próximo mesmo, né?  
   
 

### 01:38:12

   
**Evelyn La:** E assim, a qualquer momento, qualquer dúvida, às vezes o pessoal manda à noite ali dúvidas, né? Se o Mateus tá disponível, ele responde. Se a gente precisar de alguma coisa ali,  
**Elane Lima:** F.  
**Evelyn La:** a gente, né, falar: "Ó, amanhã cedo eu te envio, se for o caso." Mas assim, é uma coisa bem de perto, tá? A partir do momento em que você decide estar com a Sistem, a Sister vai estar com você até o final, executando o passo a passo ali junto, ajudando no que for preciso para realmente evoluir essa questão com o seu time comercial. Eu tô tô abrindo aqui de novo a minha tela, conversando antes, porque esse é o nosso papel. Nosso papel é o quê? ajudar você realmente a chegar no seu objetivo maior aí, né? E a nossa metodologia, ela é uma metodologia validada. Deixa eu só que que deu no meu negócio aqui agora não quer aparecer. Então, Elane, não precisa assim ninguém do seu time ou você, né? Ah, eu preciso pensar em como que eu vou fazer tal coisa. Não, a gente já entrega tudo pronto para vocês, essa parte de script, essa parte que que a gente vai precisar,  
**Elane Lima:** aqui.  
**Evelyn La:** principalmente para um início, as três reuniões estratégicas para definir com você esteira de produtos, sua metodologia, as suas estratégias de tráfego pago, de marketing ali, né?  
   
 

### 01:39:42

   
**Evelyn La:** fazer esse mapeamento e dar o direcionamento eh necessário para tanto paraa sua secretária para ela seguir ali nas trilhas de conhecimento. Depois ela vim ela vai sendo acompanhada com a gente também pelo grupo. Depois disso é a execução, é a execução da parte do seu time comercial e seu junto conosco ali para você entender também como que vai ser essa execução, até mesmo porque você vai uma hora ou outra cobrar, né, a sua secretária, se tá sendo feito, se tá sendo preenchido, formulário e tudo mais, pra gente poder depois discutir essas métricas e você ter essa clareza maior do seu negócio, inclusive dessa eh dessa parte no sentido de você tomar tomar suas decisões baseadas mais nos dados. Ah, opa, eu sei que eu consigo expandir para mais 20% de crescimento, tá?  
**Elane Lima:** Entendi.  
**Evelyn La:** Então, o nosso papel aqui é justamente ajudar vocês nessa nessa construção. Eu abri o ADS ali só para você ver como que é os grupos que a gente faz, forma, né, e e ajuda nesse sentido, nesse acompanhamento full time ali. E as reões, as reuniões estratégicas são aquelas que a gente vai paraa definição mesmo, né, definir seu produto e é muito rápido. Por exemplo, eh, a primeira reunião a gente já tenta marcar no máximo estourada ali 48 horas após a definição de parceria, no máximo assim.  
   
 

### 01:41:14

   
**Evelyn La:** Normalmente são antes, é de um dia pro outro essa primeira reunião já, porque aí a gente já começa ali já no no é para ontem isso no mão na massa,  
**Elane Lima:** É para  
**Evelyn La:** entendeu?  
**Elane Lima:** ontem.  
**Evelyn La:** para ontem já pr para fazer acontecer mesmo, né? E a nossa entrega de fato, ela é muito boa nesse sentido. As meninas ali são 10 assim para pra execução, para ajudar, para tirar dúvidas ali full time. A nossa entrega realmente ela é muito boa. Então, referente a produto aqui no sentido assim de como executa a nossa metodologia, ficou claro para ti? Tudo certo, Elane?  
**Elane Lima:** Tudo certo.  
**Evelyn La:** Maravilha. Vamos falar um pouquinho então agora sobre questão de investimentos, né? Vamos para a parte eh do investimento. Eu sempre digo assim, se a gente pensa com o bolso que a gente tem hoje, a gente quase não faz nada, né? A gente quase não faz nada. Mas óbvio que eu quero que fique bom paraa Elane e bom pra empresa, né? Eu não quero também que assim, poxa, Evelyn, faz sentido e tudo, mas vamos entender aí como que fica bom para ambas as partes, porque tem que ser uma coisa que realmente ele te deu um retorno, que nem você falou, o primeiro mês, segundo mês até vai, mas eu preciso de um retorno aí já a partir do segundo mês, pelo menos.  
   
 

### 01:42:46

   
**Evelyn La:** Quanto vale e quanto você paga para ter acesso? É diferente. Por que, Evely? Bom, vamos lá. Sei lá, o imóvel hoje mais num bairro de luxo da da de Santarém hoje tá o quê? Sei lá, um 2 milhões, 1 milhão por  
**Elane Lima:** Lá é muito a parte móvel é muito fatur superfaturada. É por  
**Evelyn La:** aí. Se você passa na frente do imóvel desse,  
**Elane Lima:** aí.  
**Evelyn La:** que é, você sabe que custa 2 milhões e tá lá uma placa vende-se, promoção, R$ 500.000, R$ 1.000, você vai falar que tá barato pelo valor que em relação ao que ele vale. Vale 2 milhões, mas o dono resolveu torrar e colocou lá 500.000, 1000, por exemplo. Então, a percepção de pelo quanto vale, pelo quanto você paga é justamente essa. O valor do nosso programa, se fosse colocar em cash, né, a estrutura que a gente disponibiliza de treinamentos, tutorias, toda a parte de gestor de tráfego inclusa. Já se a gente coloca isso no cash, ele fica perto de um valor de 268.000.  
   
 

### 01:43:52

   
**Elane Lima:** Meu  
**Evelyn La:** Mas claro que o preço não é esse,  
**Elane Lima:** Deus.  
**Evelyn La:** mas ele tem esse valor. Aí eu te pergunto, sabendo do valor todo que a gente entrega, se eu falar, Elane, você vai ter 75% de desconto hoje, você entraria no programa? Falando só de valores aqui por enquanto, tá, Elane? Eu não tô te passando o preço ainda não. Só para você entender que o nosso trabalho,  
**Elane Lima:** 67.000  
**Evelyn La:** isso referente ao quanto vale  
**Elane Lima:** Viu?  
**Evelyn La:** mesmo. Você acredita que o programa teria esse valor?  
**Elane Lima:** Tem que se isso  
**Evelyn La:** O valor de 67?  
**Elane Lima:** mensal.  
**Evelyn La:** Não, um todo, todo que eu tinha, todo, todo o processo que eu te mostrei,  
**Elane Lima:** Ah,  
**Evelyn La:** todas as etapas, todos os pilares, você acredita que o valor todo do programa ele seria R$ 67? R$ 67 não, R$ 67.000 viu?  
**Elane Lima:** não sei. Vale,  
**Evelyn La:** Por toda a entrega,  
**Elane Lima:** né? Como é?  
**Evelyn La:** assim como você exato.  
**Elane Lima:** E se entregar com isso vale  
**Evelyn La:** 100 100% da entrega a gente tem garantido da nossa parte, né?  
   
 

### 01:45:08

   
**Evelyn La:** Assim como você vê que tem esse valor, a gente tem os nossos cases que também viram o valor nessa entrega toda. A Débora é um deles que em 5 dias ela fez R$ 103.000 depois de entrar no programa. A gente tem a Dafne que fez 125\. A gente tem o Maxwell que saiu num faturamento baixíssimo, que ele girava no máximo ali, fazia 10, 15.000 por mês, a gente conseguiu alavancar ele pro faturamento de 50\. Tem vários outros cases que eu falo assim, são vários eh eh depoimentos que a gente conseguiu ao longo desse desse tempo, né, trabalhando as estratégias, mas todo mundo viu valor realmente no que a gente entregava e foi firme na execução. Agora eu vou falar preço para você, Elane. Hoje o preço para você está com a gente no programa. você falar para mim, Evelyn, eu preciso pensar por algum motivo, o preço tabelado do nosso programa é esse, ele é 51.000 e as parcelas de 8 7 140, né? Ou parcelado. No parcelado ele gera um juro ali. Se você for depois analisar com calma, se eu falar para mim, Evelyn, hoje faz sentido, né?  
   
 

### 01:46:30

   
**Evelyn La:** Mas eu, por algum motivo, a minha resposta para você hoje é não, né? Lembra que eu te pedi sim ou não para hoje? Se por algum motivo a sua resposta for não, esse valor tabelado ele fica congelado para você no sentido de que assim, a partir de qualquer momento que você queira entrar, sem não sendo hoje, é esse valor tabelado. Se eu falar para mim assim, Evelyn, faz sentido? E a minha resposta para você hoje é um sim. dentro desse valor, eu consigo trabalhar uma condição mais especial. Por que que tem essa diferença, Evelyn? A gente também tem custos. A gente tem o nosso custo de aquisição que a gente fala por formulário, que é o CAF.  
**Elane Lima:** E  
**Evelyn La:** Quando você toma de fato essa decisão, entra com a gente, você também me gera economicidade. Essa economicidade da empresa a gente passa como uma bonificação, porque nada mais justo de dar essa bonificação para quem decide em call, para quem decide dar esse passo, né? E o preço de tabela fica disponível para quem por algum motivo decide não dar esse passo em call. Então, a gente tem muito eh claro isso estabelecido na empresa, né? Uma regra da empresa. A gente honra muito com isso,  
**Elane Lima:** pergunta.  
**Evelyn La:** até mesmo porque é uma forma de incentivo a mais para quem decide dar esse passo e sair dessa inércia e começar com a gente.  
   
 

### 01:48:00

   
**Evelyn La:** Aí eu te pergunto, Elane, qual a sua disponibilidade hoje para dar espaço com a gente?  
**Elane Lima:** É, eu quero muito dar esse passo,  
**Evelyn La:** Vamos lá.  
**Elane Lima:** mas eu achei 8000 mês ainda pesado para mim, assim, achei pesado. Porque assim, a gente,  
**Evelyn La:** Ah.  
**Elane Lima:** eu já vi outras outras outras empresas, outra outra, inclusive a menina que que que eu te falei, a farmacêutica que trabalha comigo, ela já tinha olhado algumas empresas, então eu eu tinha uma média de valor na minha cabeça,  
**Evelyn La:** Uhum.  
**Elane Lima:** entendeu?  
**Evelyn La:** Que que média que seria esse valor que você tinha?  
**Elane Lima:** Então eu não sei, mas assim, é metade do que do que me tu me ofereceu, entendeu?  
**Evelyn La:** Uhum.  
**Elane Lima:** que era é a mensal,  
**Evelyn La:** Ah,  
**Elane Lima:** né?  
**Evelyn La:** isso que eu te perguntar.  
**Elane Lima:** Mas  
**Evelyn La:** Mensal, você tinha aí o quê?  
**Elane Lima:** assim,  
**Evelyn La:** Uma parcela entre 5 a 4,5.  
**Elane Lima:** eh, na verdade, entre na o que eu tinha, vou Clara, não tô desvalorizando o trabalho de vocês,  
**Evelyn La:** Claro, claro.  
**Elane Lima:** tá bom?  
**Evelyn La:** A  
**Elane Lima:** sem te valorizar,  
   
 

### 01:49:05

   
**Evelyn La:** gente  
**Elane Lima:** mas eu digo assim, média do que eu já eu tinha uma média de 3,5 a 4 no  
**Evelyn La:** no máximo.  
**Elane Lima:** máximo,  
**Evelyn La:** Uhum.  
**Elane Lima:** assim, era a minha, né, assim, era o que eu tinha,  
**Evelyn La:** Tá.  
**Elane Lima:** entendeu? assim, não nego para ti, eu tô tudo é uma construção, quero muito, mas eu também não posso dar o passo maior do que do que assim, porque ainda é, vamos lá, se a gente conseguir,  
**Evelyn La:** Sim. Não, eu entendo você.  
**Elane Lima:** né?  
**Evelyn La:** Deixa eu te perguntar. Como eu te falei, se você decide dar esse passo comigo em call aqui, o que que eu consigo fazer dentro desse valor aqui? Eh,  
**Elane Lima:** F.  
**Evelyn La:** eu vou jogar ele aqui na minha na minha calculadora aqui da da DOM, que é a Dom Pagamentos que a gente utiliza para isso, e vou retirar o juro dele em si, tá? E aí, o que que eu consigo ver para você? Que parcela que ele me autoriza a passar. Deixa eu até abrir já minha tela aqui, porque assim, se eu conseguir encaixar para você uma parcela até dentro desse valor que você me passou.  
**Elane Lima:** Porque aí eu ainda tenho tráfego, né?  
   
 

### 01:50:20

   
**Evelyn La:** Uhum.  
**Elane Lima:** Eu tenho que pensar como um todo, como toda a minha folha de pagamento, com eu eu tô pensando num num contexto,  
**Evelyn La:** Sim.  
**Elane Lima:** eu não eu não tô pensando aqui isolada, entendeu? Não adianta querer dar um passo e depois ele dizer: "Poxa,  
**Evelyn La:** B demais.  
**Elane Lima:** mas assim, eu sei que não, a intenção é sempre paraa frente, mas eu tô pensando no meu contexto hoje. Hoje,  
**Evelyn La:** Uhum.  
**Elane Lima:** porque eu tô vendo todo o custo que eu tenho aqui por trás, né? Inclusive aqui eu tô quase um tempo fora. Eu não nego que eu vou chegar lá tendo que mandar mandar vá assim.  
**Evelyn La:** Sim, já milhão.  
**Elane Lima:** Eu não sei, eu pergunto como tá a agenda lá. Ela diz: "Ah, tá indo, tá indo". Essa incerteza, entendeu?  
**Evelyn La:** Uhum.  
**Elane Lima:** Eu não sei até que ponto como tá a agenda,  
**Evelyn La:** Sim, sim.  
**Elane Lima:** mas eu preciso chegar lá e faturar logo meus 80, 100.000. Preciso isso,  
**Evelyn La:** Sim,  
**Elane Lima:** realmente,  
**Evelyn La:** sim.  
**Elane Lima:** entende? Então tem toda essa incerteza assim ainda no contexto  
   
 

### 01:51:15

   
**Evelyn La:** Uhum.  
**Elane Lima:** atual.  
**Evelyn La:** E para você sair dessa incerteza, você entende que você precisa desses passos aí? Sem sem o sem esse esse você  
**Elane Lima:** Entendo. Esses passos eu não vou conseguir, realmente.  
**Evelyn La:** vai continuar onde você tá.  
**Elane Lima:** Entendo,  
**Evelyn La:** Então assim, Elane, pra gente eh realmente aqui, ó,  
**Elane Lima:** entendo.  
**Evelyn La:** se eu conseguir encaixar uma parcela que vá acabou hoje. A gente tá fechada.  
**Elane Lima:** Sim.  
**Evelyn La:** Deixa eu abrir minha minha tela aqui para eu calcular na Dom quanto que ele me disponibilizaria de abatimento de juros.  
**Elane Lima:** Nossa, Ev faz, pensa com muito carinho, vê aí que eu quero muito fechar, por mais que esses são os primeiros seis meses, a gente não sabe os outros seis meses,  
**Evelyn La:** Exato. É só o começo.  
**Elane Lima:** aí é uma outra conversa, entendeu?  
**Evelyn La:** Só o começo,  
**Elane Lima:** Aí eu vou estar muito mais segura, muito mais certa.  
**Evelyn La:** com certeza. Deixa eu ver aqui. Vamos lá. Só fazer a minha. Deixa eu ver assim. Sì. aqui 51 100\. Vamos ver quanto que me vem. Ó, Elane, ele me liberou.  
   
 

### 01:53:35

   
**Evelyn La:** Eu coloquei um, coloquei até o cuponzinho de de cash que eu tinha válido ali ainda. Que bom. Ele dá 12 parcelas se for parcelar em 12 vezes. Tá. Parcelas não quer em  
**Elane Lima:** Não, não quero 12 não,  
**Evelyn La:** 12\.  
**Elane Lima:** porque eu eu penso em em seis para poder renovar, mas daqui se meses, não é? Nós somos seis meses de contrato.  
**Evelyn La:** Aham. Preferem seis  
**Elane Lima:** Então eu também nisso. Não,  
**Evelyn La:** vezes,  
**Elane Lima:** eu quero seis vezes para que acabou os seis vezes a gente termine de pagar para que a gente possa renovar, se Deus quiser.  
**Evelyn La:** certo?  
**Elane Lima:** Aí com uma nova perspectiva.  
**Evelyn La:** Aham.  
**Elane Lima:** Aí me recalcula aí com carinho.  
**Evelyn La:** Tá. Que em 12,  
**Elane Lima:** Para fazer isso.  
**Evelyn La:** em 12 eu consigo mais. Ele fica aí uma parcela menor.  
**Elane Lima:** É porque você você entendeu?  
**Evelyn La:** Uhum.  
**Elane Lima:** Porque 12 não adianta, porque quando chegar a seis vai acabar o contrato, eu ainda vou ter seis parcelas para pagar para você,  
**Evelyn La:** Aham. Se você não quer  
**Elane Lima:** entende?  
   
 

### 01:54:35

   
**Elane Lima:** E eu vou querer continuar, provavelmente. Então assim, não faz realmente sentido para mim de 12 não faz.  
**Evelyn La:** entendo.  
**Elane Lima:** Por mais que você diga: "Ah, fica uma parcela". Não tô pensando na parcela, eu tô pensando comercialmente em 6 meses, porque é 6 meses que a gente implementa e refaz o  
**Evelyn La:** Aham. Sim. Deixa eu recalcular ele aqui.  
**Elane Lima:** contrato.  
**Evelyn La:** Então, vamos ver o que que ele me diz.  
**Elane Lima:** Recalcula. Só pegar um negócio aqui.  
**Evelyn La:** Claro, claro. Eh, ele vai, ele ficaria, se for o valor total em seis, ele fica a partir de 7440, tirando o juro, tirando o máx um bom, deixa eu ver se eu consigo tirar um pouco mais do ver se se eu jogar é que o cashback eu joguei pros dois. Deixa eu ver se ele tá,  
**Elane Lima:** Nossa, como é alta. Ai, meu  
**Evelyn La:** ó. Fica de 51 ele vai ficar 44\.  
**Elane Lima:** Deus.  
**Evelyn La:** 51.000 ele fica 44\. Já dá fica c 5.000 e pouco ali que eu consigo tirar pensando pelo quanto que você deve ter de caixa  
   
 

### 01:56:36

   
**Elane Lima:** Porque eh é assim, por exemplo,  
**Evelyn La:** parado.  
**Elane Lima:** seriam, digamos, sete, né? Mas mais o tráfego pago, mas eu sei que eu vou precisar de uma outra secretária e eu já  
**Evelyn La:** Uhum. Hum. Mas  
**Elane Lima:** tenho eu um custo com o maker, né, o  
**Evelyn La:** Aham. Mas pensa,  
**Elane Lima:** videomaker.  
**Evelyn La:** mas Elane, vamos lá. Sem toda a estrutura hoje você já tá batendo 120,  
**Elane Lima:** Não, eu bato mais, você sabe. Eu bato mais.  
**Evelyn La:** você consegue mais?  
**Elane Lima:** Só que é assim, eu não tenho tranquilidade,  
**Evelyn La:** Sim.  
**Elane Lima:** ainda não tenho previsibilidade,  
**Evelyn La:** Não é previsibilidade. É.  
**Elane Lima:** mas eu bato mais. Já cheguei a bater 300,  
**Evelyn La:** Sim, sim. Então,  
**Elane Lima:** entendeu?  
**Evelyn La:** a possibilidade você tem muita, né,  
**Elane Lima:** Eu já cheguei a bater 300,  
**Evelyn La:** potencial.  
**Elane Lima:** 300 e pouco, dependendo da da do mês,  
**Evelyn La:** Sim,  
**Elane Lima:** do do,  
**Evelyn La:** do  
**Elane Lima:** por exemplo, eh,  
**Evelyn La:** fluxo.  
**Elane Lima:** eu tenho uma semana promocional em maio que eu que a gente faz geralmente uma média de 120 numa semana.  
   
 

### 01:57:41

   
**Elane Lima:** ou mais. Já cheguei a fazer mais antes. Só só que só com a parte de harmonização.  
**Evelyn La:** Aham. Ai,  
**Elane Lima:** Ai,  
**Evelyn La:** demanda você tem.  
**Elane Lima:** como como eu queria como eu queria pagar  
**Evelyn La:** Deixa eu te falar,  
**Elane Lima:** 4.000.  
**Evelyn La:** mulher. Mas, ó, a gente tá falando aqui, você você tem o o hoje hoje a sua hoje a sua a sua a sua  
**Elane Lima:** Ai hã,  
**Evelyn La:** cirurgia de lifting que você falou é 20.000 que você cobra  
**Elane Lima:** mas aí é que tá.  
**Evelyn La:** na  
**Elane Lima:** É esse que é o negócio. O lift hoje e eu tô fazendo sério, sério, sem brincadeira. Se eu não faço um por semana,  
**Evelyn La:** Mas é isso que eu tô. Isso é esse pensamento que eu quero te ajudar.  
**Elane Lima:** às vezes é isso que chega  
**Evelyn La:** Ó, a gente tá falando de um a mais para você pagar o custo fixo que a gente  
**Elane Lima:** ser  
**Evelyn La:** vai tô falando de custo mesmo agora aqui contigo, sabe? É um a mais.  
**Elane Lima:** Uhum.  
**Evelyn La:** Você não tá fazendo um por semana. A gente tá falando aqui linkando, linkando a estratégia correta para você.  
   
 

### 01:58:33

   
**Elane Lima:** Não.  
**Evelyn La:** Com a demanda que você tem, com o nome que você já tem, é impossível você não bater uns 10 lift por mês.  
**Elane Lima:** É, se eu conseguisse fazer dois por semana e com o nariz que eu já faço,  
**Evelyn La:** É impossível você não fazer,  
**Elane Lima:** Nossa.  
**Evelyn La:** não ter 10 lifting por mês com o nome que você já tem, com a carreira que você já consolidou, com todo o posicionamento. Por que que eu te falo com tanta segurança isso? Porque eu já peguei casos aqui de outras cirurgiões que nem tinham posicionamento e nem tinham tempo integral para consultório porque atendia em hospital e a gente conseguiu fazer mais de 10 bléfaro, 10 bléfo, mais de 10 cirurgias de lifting de papada para ele no mês, entendeu? Então eu tô te falando um potencial que eu vejo em você de você bater muito fácil 10\. Tô falando 10 para ser bem realista, não colocar expectativas na sua cabeça assim de, ah, meu Deus, né? Mas que um mínimo de 10 a gente consegue colocar para você hoje.  
**Elane Lima:** É, mas eu te pergunto,  
**Evelyn La:** Vamos lá.  
**Elane Lima:** se a gente fechar no quanto é que você falou?  
**Evelyn La:** Ele vai ficar 44.000 no total de 51\. Fica 7 4450 em seis  
   
 

### 01:59:56

   
**Elane Lima:** 40 26 vezes.  
**Evelyn La:** vezes.  
**Elane Lima:** Eh, mas isso em contrato,  
**Evelyn La:** Claro,  
**Elane Lima:** né?  
**Evelyn La:** com certeza.  
**Elane Lima:** Claro. Eh, e a possibilidade da gente,  
**Evelyn La:** Contráo.  
**Elane Lima:** se caso em dois meses eu não consegui isso da gente rever isso, ter alguma quebra ou alguma coisa,  
**Evelyn La:** Sim, sim.  
**Elane Lima:** é isso que eu porque assim, tem que ter as duas partes, né? Então eu digo assim,  
**Evelyn La:** Sì.  
**Elane Lima:** se se der dois meses, eu tiver essa despesa, tô ajeitando tudo aqui, tudo e eu não consegui pelo menos os 10 lift assim que eu eu sei que dá, ou então pelo menos perto, né, do aumentar o faturamento realmente para isso valer a pena, que eu possa dizer: "Olha, bora rever aqui o que que tá acontecendo,  
**Evelyn La:** com certeza tem toda a liberdade para isso,  
**Elane Lima:** esse valor ou a gente entendeu?  
**Evelyn La:** tá? A gente deixa isso muito bem claro. Eh, porque assim, o nosso trabalho é como eu te falei, nós somos muito transparente. Potencial a gente enxerga muito em você. Eu, o Gustavo, viu? Potência, já tinha me passado seu briefing, né?  
   
 

### 02:01:09

   
**Evelyn La:** Mas assim, Evelyn, vamos rever. Preciso rever isso aqui, preciso reanalisar. Vamos ver se questão desse valor por conta de X, Y, Z. Quanto a isso, o Renan é muito aberto a isso, ele é muito tranquilo. Ele inclusive fica no grupo também porque ele faz esse acompanhamento junto, né? Então assim, você não vai ter problema nenhum em relação a, por exemplo, não conseguir contato depois com alguém para querer rever sobre isso, tá? A gente tem o jurídico nosso específico que vai que elabora esse contrato e a gente tem o Renan que fica acompanhando ali, que é o dono da empresa mesmo. Então ele mesmo fala: "A nossa garantia da nossa entrega 100% você vai ter, vai ser só o fato realmente de você executar e a gente colocar a demanda qualificada para você e fazer acontecer". né? O que eu enxergo hoje realmente de gargalo para você foi o que eu te falei. Eu acho impossível a gente não ter 10 cirurgias aí mesmo para colocar na sua mão. Acho impossível isso. Is é um caso muito muito parecido.  
**Elane Lima:** Nossa, me dá me dá até um frio na barriga. Você tá entendendo,  
**Evelyn La:** O caso muito parecido com a Débora,  
**Elane Lima:** Evely?  
   
 

### 02:02:17

   
**Evelyn La:** de verdade. Muito parecido com a Débora.  
**Elane Lima:** Juro para ti, porque eu sou muito honesta na minus compromissos,  
**Evelyn La:** Sim,  
**Elane Lima:** sabe?  
**Evelyn La:** com certeza.  
**Elane Lima:** Eu vou, eu vou me descabelar,  
**Evelyn La:** Você precisa  
**Elane Lima:** mas eu vou eu vou honrar. Mas assim, é sério, eu na altura do campeonato, eu quero paz,  
**Evelyn La:** de resultado.  
**Elane Lima:** eu quero paz.  
**Evelyn La:** precisar de  
**Elane Lima:** E eu sei, ainda mais agora. Olha, eu tô aqui, não é fácil a gente tá longe. Eu fiz esse o lifet porque ele é meu professor,  
**Evelyn La:** resultado.  
**Elane Lima:** ele praticamente me deu. Mas assim, é caro tá aqui, sabe? são quase 10 dias fora do consultório. Eh, é um, é um curso caro, então eu invisto, eu tô eh tem toda uma um um eh eu tenho dois filhos em faculdades particulares de medicina, porque não é só isso.  
**Evelyn La:** Sim. É a sua vida.  
**Elane Lima:** A gente quando a gente olha, é, a gente tem que olhar como um todo, né, como um geral. Eu sou separada, então eu não tenho alguém que eu possa dizer: "Ei, papai, vem aqui".  
   
 

### 02:03:10

   
**Elane Lima:** Então é, é isso aqui mesmo.  
**Evelyn La:** Te entendo perfeitamente.  
**Elane Lima:** Essa é minha essa essa é minha vida, né? Então eu eu eu quero muito fechar e sinceramente pelo que eu tô colocando em em de confiança em você, eu vou fechar. Eu só quero que você saiba que eu quero ter essa liberdade de de você ter também esse comprometimento de dizer: "Realmente, Elane, alguma coisa tá aqui". De eu poder dizer: "Olha, não aguento, não consigo até aqui, eu preciso realmente alavancar". Eu acho que você me entendeu,  
**Evelyn La:** Claro.  
**Elane Lima:** né?  
**Evelyn La:** Você tem total eh a liberdade de qualquer momento você falar comigo, inclusive, tá? De qualquer coisa.  
**Elane Lima:** Porque o medo, porque o contrato ele te amarra,  
**Evelyn La:** Sim.  
**Elane Lima:** dependendo do contrato,  
**Evelyn La:** Sim.  
**Elane Lima:** ele te amarra de um jeito que você que depois dessa conversa, eu digo assim, não tô dizendo que é o que vai acontecer, tem lugares, ah, fechou o contrato, agora ela querendo, ela fazendo ou não, ela vai ter que me pagar os 44.000.  
**Evelyn La:** Uhum. Exato. Mas eu vou te falar, Elane,  
**Elane Lima:** Vai.  
**Evelyn La:** nessa nesse ponto a gente sempre presou muito, a Sistem preza muito por essa transparência e e a gente sempre pensa o seguinte e até por isso que eu tô com eles há há dois anos, porque eu já trabalhei em outros lugares e com outros expert dos quais eu falo assim,  
   
 

### 02:04:32

   
**Evelyn La:** se não tem o os valores alinhados com os meus, eu não fico. Eu não fico. Eu já tive loja, eu também sou divorciada, eu também tenho filho. E tudo que você me trouxe é exatamente o que eu passo. Então,  
**Elane Lima:** He.  
**Evelyn La:** se eu não tenho confiança em trabalhar num lugar que tem uma entrega verdadeira, que vai ter isso, não faz sentido para mim, porque o que eu faço pro outro é o que vem para mim de retorno. Como eu trato a vida é como a vida vai me tratar,  
**Elane Lima:** justamente.  
**Evelyn La:** é como vai aparecer. Então, quanto a esse ponto, você tem a certeza que a gente tem muita, muita transparência, tá? A gente tem todo esse cuidado realmente com quem entra, porque o nosso objetivo é fazer o quê? essa pessoa ser um case para nós, porque não vale a pena para mim colocar dinheiro no meu caixa e meter um monte de depois trabalhar com monde o processo atrás, que é o caso de vários no mercado que hoje a gente encontra,  
**Elane Lima:** Mhm.  
**Evelyn La:** que o foco deles é a venda, mas a entrega é zero. E aí vai fazer algum sentido? Não, porque é um castelo de areia, uma hora esse cara cai, não se levanta nunca mais. E o nosso objetivo com Assistem aqui, o Renan e o Mateus, eles são pessoas muito corretas nesse sentido.  
   
 

### 02:05:49

   
**Evelyn La:** Tanto que são, foram seis anos para eles conseguir chegar no patamar que eles estão hoje. Foram 6 anos aprendendo, aprendendo com erro, acertando, testando, validando estratégia pra gente ter hoje tudo muito redondinho, pra gente ter esse acompanhamento de perto com grupo, com pessoas exclusivas de entrega, porque antes, no começo, eram tudo eles que faziam. Era o Renan, era o Mateus sozinho. Hoje a gente tem uma equipe, a gente tem segurança de estar com eles e saber que sim, é entregue e a gente quer um case. Porque para nós é muito melhor eu ter a Elane falando bem de mim, falando bem da System, indicando a System e trazendo isso, se tornando nossa sócia no futuro, do que a Elane falando mal e eu correndo o risco de, ao invés de ganhar um cliente a mais por indicação dela, perder 15, 20\. Então, pra gente não é interessante isso. Por isso a gente trabalha nessa transparência, nesse cuidado todo de realmente de fato fazer a entrega acontecer.  
**Elane Lima:** Deixa eu te perguntar só mais uma coisa.  
**Evelyn La:** Claro.  
**Elane Lima:** Eh, no caso da pessoa que eu pago hoje, se eu não conseguir reduzir, eh, porque toda pessoa que trabalha com você, ela tem alguém que filma ou ela mesmo pode filmar e mandar para vocês ou você tá entendendo?  
   
 

### 02:07:13

   
**Elane Lima:** Porque querendo não,  
**Evelyn La:** Sim.  
**Elane Lima:** eu vou te dizer hoje, ele, eu vou te dizer sinceramente, só ele me cobra  
**Evelyn La:** Nossa, mulher,  
**Elane Lima:** 3.000,  
**Evelyn La:** ele tá te fincando a faca.  
**Elane Lima:** porque na verdade o que que eu já Ele não tá como só filmake, ele tá como gerente de vendas e é isso que eu tô vendo que não tá dando  
**Evelyn La:** Hum.  
**Elane Lima:** certo.  
**Evelyn La:** Não tá, tá bagunçado aí.  
**Elane Lima:** Você entendeu? Ele ele filma, ele é responsável por falar com a minha secretária, ele é responsável por essa venda, isso que eu não tô tendo.  
**Evelyn La:** Não, ele tá, ele tá  
**Elane Lima:** É por isso que ele por isso que eu pago um pouco a mais. Aí eu quero te perguntar. Só que com ele não tem. É só também a gente nem assina contrato, na verdade já tá meio na boca, né? Se caso eu disser não,  
**Evelyn La:** Aha.  
**Elane Lima:** eu paro aqui porque esse é um valor que eu posso investir com vocês também. Você tá me entendendo?  
**Evelyn La:** Sì.  
**Elane Lima:** Aí eu quero saber o que eu posso fazer, pelo menos por enquanto, se tem como, não sei se vocês, eh, se eu posso conseguir essa filmagem, esse trabalho, vocês montam ou vocês não fazem isso de jeito nenhum,  
   
 

### 02:08:24

   
**Evelyn La:** A gente,  
**Elane Lima:** só para mim ter uma  
**Evelyn La:** claro, a gente te dá o direcionamento,  
**Elane Lima:** noção.  
**Evelyn La:** sim, caso você, por exemplo, ah, sei lá, vou pegar o meu filho aqui para me ajudar, para ele me filmar,  
**Elane Lima:** Uhum.  
**Evelyn La:** a gente te dá o direcionamento,  
**Elane Lima:** Só pegar o  
**Evelyn La:** te diz tudo certinho como você eh conduzir,  
**Elane Lima:** carregador,  
**Evelyn La:** como você conduzir a sua a sua fala, as postura, enfim, eh o que falar também,  
**Elane Lima:** até porque isso aí muita,  
**Evelyn La:** tudo isso a gente porque vai tá limpado com a  
**Elane Lima:** é, é,  
**Evelyn La:** estratégia.  
**Elane Lima:** é porque isso muito eu tenho já um pouco,  
**Evelyn La:** Exatamente.  
**Elane Lima:** né? Eu não sou mais é na  
**Evelyn La:** Você já tem isso meio que seu já trabalhado em  
**Elane Lima:** verdade e ele ele ele muita coisa sou eu que faço.  
**Evelyn La:** você.  
**Elane Lima:** O que que ele tem? Um microfone, uma a o celular ou uma câmera e ele sabe montar.  
**Evelyn La:** Aham.  
**Elane Lima:** Mas o texto, como que eu quero, as ideias, a grande maioria sou eu que faço.  
**Evelyn La:** Então, nesse ponto, eh, a gente consegue te dar o direcionamento, você mesmo pode filmar, pode fazer a tua a tua a tu, como é que eu falo assim, a tua edição ali, mandar para nós esse esse essa chamada que você vai fazer, o seu vídeo ou as fotos.  
   
 

### 02:09:43

   
**Evelyn La:** e a gente vai montar a sua campanha. Não necessariamente você precisa um filmaker hoje, um videomaker para você fazer. Não precisa pro tráfego pago, não. É, eu vejo assim ele mais necessário para fazer uma coisa bonita pro seu posicionamento, mas precisar necessariamente que ele faça para poder a gente linkar isso num  
**Elane Lima:** Entendi.  
**Evelyn La:** tráfego pago, não precisa.  
**Elane Lima:** É, mas aí eu posso ter alguém, uma outra pessoa que não necessariamente nesse valor que me possa me fazer, né?  
**Evelyn La:** Vem mais barato.  
**Elane Lima:** alguém que bem mais barato.  
**Evelyn La:** Mais barato. Olha,  
**Elane Lima:** É isso que eu é é essa  
**Evelyn La:** vou te falar que menos da metade você acha alguém.  
**Elane Lima:** a minha intenção,  
**Evelyn La:** Aham. Exatamente. Na verdade,  
**Elane Lima:** entendeu?  
**Evelyn La:** você tá com custos aí hoje, Elane, eh, que você tá dando tiro no  
**Elane Lima:** É, até porque ele não, ó, se tu olhar lá e eh muitas fica muito tempo sem postar,  
**Evelyn La:** escuro.  
**Elane Lima:** assim, tem muita coisa que eu não sei, entendeu? É essa falta de previsibilidade e de eu não sei números, eu não sei eu que não tá me me gerando uma tranquilidade esse negócio dele me deixar ao Léo, ao vento.  
   
 

### 02:10:58

   
**Elane Lima:** Não, eu tô fazendo, tá dando, tá chegando, tá indindo aí, a agenda tá indo aí, os buracos vão ficando,  
**Evelyn La:** Na verdade,  
**Elane Lima:** entendeu?  
**Evelyn La:** ele tá muito bem acomodado com você. Essa é a verdade. Ele tá acomodado,  
**Elane Lima:** né?  
**Evelyn La:** tá fazendo o jeito que ele quer, porque na cabeça dele,  
**Elane Lima:** E no final do mês ele sabe que eu vou vai receber e que eu não tenho muita  
**Evelyn La:** na cabeça dele é isso.  
**Elane Lima:** opção. E eu,  
**Evelyn La:** É.  
**Elane Lima:** de certa forma, eu me vendo  
**Evelyn La:** E é esse ponto que tá na hora de você virar sua chave agora. Por quê? Uma ele tá sendo um custo muito alto pelo que você tá tendo de retorno. Ele é um custo hoje, é um, acaba sendo um peso, vamos colocar assim na sua operação, porque esses 3.000 que você tá pagando para ele, você poderia est pagando a metade disso, menos até para um, para alguém fazer o filme, a parte de de social mídia que a gente fala ali para você. Com outra parte do salário dele, você contrataria outra pessoa, perfil vendas, e ajustaria valor de comissão com só com o salário  
**Elane Lima:** Uhum.  
**Evelyn La:** dele.  
   
 

### 02:12:12

   
**Evelyn La:** E colocaria que você tem hoje no pós-venda que vai te dar muito mais lucratividade com a parte  
**Elane Lima:** É,  
**Evelyn La:** fixa e você vai ter muito mais resultado.  
**Elane Lima:** é, é porque o pós-venda ele é fundamental,  
**Evelyn La:** fundamental é muito  
**Elane Lima:** né? É.  
**Evelyn La:** importante.  
**Elane Lima:** E aí o o amar seria o que eu pago para você. É assim, eu é sério, Evely, se a gente tiver o retorno do que a gente tá planejando,  
**Evelyn La:** Com certeza.  
**Elane Lima:** esses 7.000 tiram rápido num dia,  
**Evelyn La:** Muito fácil,  
**Elane Lima:** no num num lift a mais. O nariz que eu cobro oito,  
**Evelyn La:** muito fácil,  
**Elane Lima:** sabe?  
**Evelyn La:** muito fácil. Porque assim, o que que impactaria que eu que eu poderia dizer assim, a Elan, talvez a gente vai, sei lá, mais uns 3s meses para uns 4 meses,  
**Elane Lima:** Agora  
**Evelyn La:** sei lá, se você não tivesse ainda base de clientes, que é uma coisa que você tem, e se você não tivesse este de produto,  
**Elane Lima:** tenho.  
**Evelyn La:** por exemplo, é alguém que tá começando na cirurgia, é alguém que só faz off, Aí a gente tem limitações que aí a gente precisa trabalhar numa realidade diferente.  
   
 

### 02:13:21

   
**Evelyn La:** Agora você com todo a credibilidade que você já construiu a sua carreira e com com a esteira de produtos que você já tem, que é uma questão só de organizar, organizar, estruturar produto principal, produto de saída, produto de entrada, estratégia para um, estratégia pro outro, estratégia pro outro, linkar, chegou, converter. É simples, parece muita coisa no apresentar ali, mas é simples na execução. A gente vai guiando vocês bem certinho, passo a passo, segurou na mão e a gente vai junto. É muito fácil você atingir esse faturamento, de verdade.  
**Elane Lima:** E como é feito esse pagamento de seis parcelas?  
**Evelyn La:** Vamos lá. Eu consigo hoje eh cartão, cartão de crédito, eh ou se você der uma entrada, aí eu consigo reduzir também. Não sei como que você pensava fazer tudo no cartão. Posso parcelar, por exemplo, em dois cartões também diferentes, três cartões, se você precisar, dá para dividir  
**Elane Lima:** Parece brincadeira,  
**Evelyn La:** também.  
**Elane Lima:** mas eu tô com assim, até teria como negociar melhor, mas eu tô com problema no meu banco pelo Face ID.  
**Evelyn La:** Sério?  
**Elane Lima:** Sério? Porque ele não tá me reconhecendo. Tu acredita?  
**Evelyn La:** Ai  
**Elane Lima:** Eh, aí eu tô com o cartão.  
   
 

### 02:14:45

   
**Elane Lima:** O meu cartão tem um limite bom,  
**Evelyn La:** ai  
**Elane Lima:** não tem problema. Eh, talvez assim, aí eu não sei como seria essa negociação, porque eu conseguiria dar uma parte em dinheiro. Eu só não sei como por causa, entendeu? Teria que chegar lá para ver. Não sei. Me me dá as opções como seria.  
**Evelyn La:** lá. Se você tá com essa questão do banco, parcela tudo no cartão, então fica mais fácil, porque senão eh eh o que que é o melhor? Parcela tudo. A parcela em si, o nosso trabalho vai ser justamente o quê? Ajudar você a pagar essa parcela, entendeu? Então parcelando,  
**Elane Lima:** Se se nesse primeiro momento,  
**Evelyn La:** você vai pagar só mês que vem,  
**Elane Lima:** tá?  
**Evelyn La:** certo? E você já vai começar agora,  
**Elane Lima:** É,  
**Evelyn La:** entendeu?  
**Elane Lima:** entendi. Se nesse primeiro momento de serve, então eu vou, digamos que eu estenda para oito vezes,  
**Evelyn La:** Uhum.  
**Elane Lima:** entendeu? Não fique nem lá um ano,  
**Evelyn La:** Nem seis, nem um ano,  
**Elane Lima:** nem um ano para só para me dar uma certa mais só para uma coisa mais mental, sabe?  
   
 

### 02:15:46

   
**Evelyn La:** tá?  
**Elane Lima:** Mudaria alguma coisa?  
**Evelyn La:** Vamos ver. Já faço aqui. Vamos ver como que daria para fazer.  
**Elane Lima:** Tirar aqui um pouco que está me machucando. M.  
**Evelyn La:** Ó, vezes 5 996, 78 de  
**Elane Lima:** Nossa, de quanto antes?  
**Evelyn La:** sete de 7 44 em 8 fica 5696  
**Elane Lima:** aumenta quanto de sete e  
**Evelyn La:** fica aumenta R$ 2.000  
**Elane Lima:** quanto  
**Evelyn La:** mensal diminui, mas aumenta da do número de parcelas, né?  
**Elane Lima:** no valor geral,  
**Evelyn La:** Uhum.  
**Elane Lima:** né?  
**Evelyn La:** Mas ainda assim ele fica menos que o 51\.  
**Elane Lima:** E se desse uma parte em dinheiro no Pix?  
**Evelyn La:** Quanto que você tem em mente assim de entrada para eu poder recalcular?  
**Elane Lima:** digamos uns 5.000  
**Evelyn La:** Aham. A bater cinco. Então vamos lá. Gente, ó, se você der uma entrada de cinco parcelando em seis, ele vai dar uma parcela. em seis vezes de 6558\. Você quer ver pra mesma para oito com a entrada mais 8?  
**Elane Lima:** 6 500 e  
**Evelyn La:** 6558\. Vamos ver qual de  
   
 

### 02:18:31

   
**Elane Lima:** sim.  
**Evelyn La:** oito.  
**Elane Lima:** Ai, tô  
**Evelyn La:** Vai dar tudo certo.  
**Elane Lima:** nervosa.  
**Evelyn La:** Tá tranquila.  
**Elane Lima:** Talvez é por causa desse medo não tenha ainda alavancado mais não sei.  
**Evelyn La:** Exato. E é normal, é normal isso aí. Você tá dando um passo que vai mudar o jogo do seu negócio. E outra coisa, uma coisa que você não tem, então não tem como você não é conhecido, é normal, fica tranquila aqui assim. É, como eu te falei, nossa meta também é gerar case, porque, ó, de oito você der cinco de entrada, 8 de 5000 18,59, ele fica 40 mais ele fica 45 num total. Se você der cinco de entrada e parcelar em oito vezes o restante, parcelas de18, já reduz até mesmo pro pro custo que  
**Elane Lima:** Ja.  
**Evelyn La:** você oito vezes.  
**Elane Lima:** 5000\. Isso de seis vezes oito. Uhum. Daria para eu fazer.  
**Evelyn La:** O de com oito vezes cinco de entrada e oito. Você  
**Elane Lima:** É,  
**Evelyn La:** fala:  
**Elane Lima:** só tô hoje porque hoje eu não consegui entrar no meu aplicativo. Era uma questão de eu desinchar um  
   
 

### 02:20:24

   
**Evelyn La:** Aham. Mas assim, deixa eu te falar. Eh,  
**Elane Lima:** pouquinho.  
**Evelyn La:** se a gente fazer então a o parcelamento e deixa os cinco para você fazer depois,  
**Elane Lima:** Pode ser. Aí é com você,  
**Evelyn La:** tá?  
**Elane Lima:** entendeu? Eu poderia pagar o a parte de um cartão e é só acho que é talvez até o final da  
**Evelyn La:** Isso que você  
**Elane Lima:** semana esperar dar uma eh porque ele me pediu lá para mim também entrar  
**Evelyn La:** Isso.  
**Elane Lima:** com com a senha, mas aí eu tinha que ver com calma tudo isso,  
**Evelyn La:** Sim. Não faz assim.  
**Elane Lima:** né?  
**Evelyn La:** que a gente faz o valor do cartão hoje e aí na cláusula do contrato lá de negociação, a gente especifica a data para você fazer o 5.000. Tranquilo? Por exemplo, você falar: "Elin, acho mais vai já vou conseguir, né? Ali sexta-feira ou segunda que vem a gente especifica a data.  
**Elane Lima:** Pois é.  
**Evelyn La:** Pronto, tranquilo. Quanto a isso,  
**Elane Lima:** no no no contrato, porque assim, a gente já tá vendo o valor, né, digamos, eu pago depois que eu assino o  
**Evelyn La:** eh, como que funciona? A gente passa o cartão agora,  
**Elane Lima:** contrato.  
   
 

### 02:21:28

   
**Evelyn La:** te manda o link, você vai fazer o pagamento do cartão e eu já vou te mandar toda a documentação que você precisa me enviar para eu subir o contrato pro nosso jurídico amanhã já liberar para você, tá? Então, o nosso,  
**Elane Lima:** Uhum.  
**Evelyn La:** como que funciona? Como agora é 7:40, então amanhã, primeiro horário da manhã, ele já tem as informações do formulário que eu envio para ele agora com as suas com toda a nossa negociação, com todos os dados do qual você quer colocar no contrato, por exemplo, eu quero no CNPJ, vou querer no CPF, enfim, eu te mando a relação ali do que que eu preciso. Amanhã, no mais tardar, final da tarde, a gente sempre tenta acelerar antes. No mais tardar, dependendo como que tá os agendamentos dele lá de contrato também, a gente já te envia o contrato para você assinar e aí a gente já marca a primeira reunião  
**Elane Lima:** para  
**Evelyn La:** estratégica,  
**Elane Lima:** você.  
**Evelyn La:** tá? Então assim, assinou o contrato, se as meninas têm data no mesmo dia, elas já marcam no mesmo dia essa reunião. Senão,  
**Elane Lima:** Ai, é, isso é arriscado, né? pagar sem ver o contrato  
**Evelyn La:** Aham. Aham. Entendo.  
   
 

### 02:22:33

   
**Evelyn La:** Eh,  
**Elane Lima:** antes.  
**Evelyn La:** é que a como que a gente faz hoje? A gente a a metodologia da empresa é essa, né? Você pagar, a gente sobe as documentações e sobe o contrato. Tudo que tem no contrato é o que tá na nossa entrega,  
**Elane Lima:** É, não, eu te entendo.  
**Evelyn La:** tá?  
**Elane Lima:** Tem que tem só que confiar,  
**Evelyn La:** Só você entender.  
**Elane Lima:** né?  
**Evelyn La:** Não, mas sim,  
**Elane Lima:** Você entende,  
**Evelyn La:** claro,  
**Elane Lima:** né?  
**Evelyn La:** eu entendo. Mas eh em relação a isso, fique bem tranquila. Essa é a nossa metodologia mesmo, tá? Por isso que a gente abre pra negociação na call. Que que você prefere? Quer de oito vezes ali? Daí eu te mato.  
**Elane Lima:** É só, eu só quero que você esteja ciente que eu tô com esse probleminha, esse, né? No máximo, eh, se der tudo errado, eu tenho, eu tenho, vou te, eu te digo, eu tenho um dinheiro chegando lá, eu peço para fazer um depósito,  
**Evelyn La:** Tranquila, fica tranquila.  
**Elane Lima:** entendeu?  
**Evelyn La:** Uhum.  
**Elane Lima:** No máximo, assim, eu digo porque eu eu só tô falando fazendo isso porque eu sei que se eu não conseguir no online, eu chego lá, eu peço para alguém fazer um depósito na conta da tua empresa.  
   
 

### 02:23:47

   
**Elane Lima:** De coração,  
**Evelyn La:** Mhm.  
**Elane Lima:** eu tô dando um passo que eu assim, eu já tinha falado com outras agências, um preço muito menor, agências que digamos mais rypadas assim e eu recuei  
**Evelyn La:** Por algum motivo que você não sentiu segurança de entrega.  
**Elane Lima:** de algum motivo eu recuei, entendeu? no momento recuei e assim eu vou eu vou realmente ter que tomar uma a decisão de eu dar um passo, dar um ponto final nessa história com ele, porque ele tem uma coisa meio que amizade, só que eu tenho que separar porque já já deu.  
**Evelyn La:** Isso já  
**Elane Lima:** Eu sempre eu sempre soube que já deu.  
**Evelyn La:** deu.  
**Elane Lima:** O máximo que eu vou chegar com ele, ele vai dizer: "Ó, eu vou diminuir isso para tanto para você ficar só tirar a parte de gerente e fica só com filmeake.  
**Evelyn La:** É isso.  
**Elane Lima:** aceita aí.  
**Evelyn La:** Ele tá sendo um gargalo para você.  
**Elane Lima:** Ele vai me é aí ele vai me  
**Evelyn La:** E nessa hora você tem que pensar com o seu CNPJ e não com o CPF da  
**Elane Lima:** dizer.  
**Evelyn La:** Elane. Ele chegou até aqui com você e que bom, ele aprendeu,  
**Elane Lima:** É,  
**Evelyn La:** você aprendeu, todo mundo tem o seu aprendizado, mas esse ciclo encerrou.  
   
 

### 02:24:55

   
**Evelyn La:** E isso que você vai deixar claro para ele. Por quê? Porque para o CNPJ, ele é um gargalo hoje. Se ele não fiz,  
**Elane Lima:** não, isso eu já tá já tinha consciência.  
**Evelyn La:** né? Se ele tivesse, se, se tivesse tudo bem,  
**Elane Lima:** Eu  
**Evelyn La:** ele estaria te, te trazendo resultado. Se pagou.  
**Elane Lima:** não estaria tanto essa  
**Evelyn La:** Exatamente.  
**Elane Lima:** conversa.  
**Evelyn La:** Então assim, as decisões às vezes nessa vida nos exigem eh postura, encerramento.  
**Elane Lima:** Coragem.  
**Evelyn La:** Às vezes o encerramento ele vem com o embate, mas é necessário porque é a saúde do seu CNPJ, é o seu futuro, inclusive em jogo, que tá sangrando, né? A gente tá falando de uma oportunidade da Elane triplicar,  
**Elane Lima:** É.  
**Evelyn La:** quadruplicar de tamanho, que tá sendo sugada agora, querendo ou não, porque tá tendo um vazamento aí, ó.  
**Elane Lima:** Tá bom. Vamos.  
**Evelyn La:** Vamos fazer acontecer diferente esse  
**Elane Lima:** Vamos fazer,  
**Evelyn La:** ano.  
**Elane Lima:** vamos, deixa eu te falar, o Itaú às vezes ele breca no primeiro valor, entendeu?  
**Evelyn La:** Aham.  
**Elane Lima:** Aí eles me mandam uma mensagem no WhatsApp, aí eu confirmo e aí eu vou, a gente só para te saber que pode ser que isso  
   
 

### 02:26:19

   
**Evelyn La:** Tá. Então deixa. Vamos lá.  
**Elane Lima:** aconteça.  
**Evelyn La:** Então você vai dar os cinco de entrada depois.  
**Elane Lima:** É,  
**Evelyn La:** A entrada que vai ser depois  
**Elane Lima:** é, a entrada vai ser, não vai ser  
**Evelyn La:** e os 37 que aí vai ficar na parcelinha de 5 e  
**Elane Lima:** entrada.  
**Evelyn La:** 18 em oito vezes. Oito, né? Tá.  
**Elane Lima:** É.  
**Evelyn La:** Vou te  
**Elane Lima:** Vou fazer de oito porque é melhor cinco.  
**Evelyn La:** mandar.  
**Elane Lima:** Tem outras coisas aí, se Deus quiser da próxima vai ser bem diferente a  
**Evelyn La:** Claro. Vai sim,  
**Elane Lima:** conversa.  
**Evelyn La:** com certeza. Eu vou te mandar contrato de se meses.  
**Elane Lima:** Contrato, contrato de se meses,  
**Evelyn La:** Uhum.  
**Elane Lima:** né?  
**Evelyn La:** Eu vou te mandar no grupo lá que a gente confirmou a reunião, é mais fácil,  
**Elane Lima:** Uhum.  
**Evelyn La:** acredito. Deixa eu só achar aqui. Te mandei o link ali. Quanto você vai fazendo,  
**Elane Lima:** Tá,  
**Evelyn La:** agora quem vai pegar uma água sou eu e vou fazer um xixi, tá bom?  
**Elane Lima:** tá bom. Aí eu posso fazer aqui,  
**Evelyn La:** Pode ir fazendo aí.  
   
 

### 02:27:29

   
**Evelyn La:** Aham.  
**Elane Lima:** né? Evely,  
**Evelyn La:** Voltei.  
**Elane Lima:** é só porque eu queria fazer no CNPJ. Será que tem algum problema? Não.  
**Evelyn La:** Não.  
**Elane Lima:** Só achar aqui uma coisa.  
**Evelyn La:** Quanto?  
**Elane Lima:** Só achar o CNPJ de cabeça aqui da meu rapidinho.  
**Evelyn La:** Já vou pegar aqui também.  
**Elane Lima:** Очень  
**Evelyn La:** os dados  
**Elane Lima:** Não interfere o fato do seu do cartão ser pessoa física, não,  
**Evelyn La:** não quanto é isso não.  
**Elane Lima:** né? Deixa ver aqui uma coisa. Pinho.  
**Evelyn La:** Ч. Tô olhando até o calendário aqui  
**Elane Lima:** Deixa eu te falar, amanhã eu tô com o dia todo livre. seria uma boa. Olha, no à tarde, no final da tarde,  
**Evelyn La:** para fazer a primeira call. Ah,  
**Elane Lima:** eu acho que assim que eu chegar,  
**Evelyn La:** maravilha. Eu já mando pras meninas aqui se elas tiverem horário.  
**Elane Lima:** assim que eu chegar lá,  
**Evelyn La:** Você tá tranquila amanhã à tarde?  
**Elane Lima:** tô  
**Evelyn La:** Não. Perfeito. Finalizando aqui, eu já mando mensagem pra Mari. Já falo. Mari, pode chamar já. Já. cria o seu grupo ali que aí que que acontece?  
   
 

### 02:30:59

   
**Evelyn La:** Eu vou criar um novo grupo aonde vai est eu, o Renan, o Mateus, as meninas da parte estratégica e o Renan e o Mateus que são os estratégicos. E aí ali vai ser a comunicação depois contigo para marcar essas reuniões, enfim, todo o processo. Aí eu já marco a Mari e já falo: "Mari, amanhã a a Ilane já tem tarde livre. Se você tiver horário na sua agenda, já marca com ela a primeira call. Ela já marca contigo. Se ela tiver horário livre lá, tenha certeza que ela já faz  
**Elane Lima:** Tá só achar  
**Evelyn La:** isso.  
**Elane Lima:** aqui.  
**Evelyn La:** Aí você só me passa certinho que data fica melhor para você para para fazer os 5.000, tá? Você prefere sexta, você prefere na próxima segunda?  
**Elane Lima:** Tá.  
**Evelyn La:** Daí eu já deixo.  
**Elane Lima:** Eu eu acho eh você pode deixar pra próxima segunda, mas se se assim porque uma questão de desist porque se eu se eu não conseguir é a minha  
**Evelyn La:** Claro,  
**Elane Lima:** último meu último prazo, aí eu faço depósito,  
**Evelyn La:** tranquilo.  
**Elane Lima:** entendeu?  
**Evelyn La:** Que aí a gente eu deixo isso especificado no contrato, a data certinha, mas aí você sabe que a o até segunda fica  
**Elane Lima:** Aham.  
   
 

### 02:32:16

   
**Evelyn La:** mais tranquilo para ti, né? Eu vou pegando os dados já aqui do quais você precisa me passar. Deixa eu para eu subir o meu formulário hoje que de amanhã no primeiro horário o José, que é o nosso jurídico já faz. E a Mari também já te chama.  
**Elane Lima:** fazer logo.  
**Evelyn La:** O meu pequeno chegou da escola, tá fazendo uma espada ali.  
**Elane Lima:** Oh, meu Deus, que idade ele tem?  
**Evelyn La:** Ele vai fazer sete em abril, mês que vem. Quando ele nasceu? Ele nasceu no dia da Páscoa. Aham.  
**Elane Lima:** Oi.  
**Evelyn La:** Foi meu presente de Páscoa.  
**Elane Lima:** Oh meu Deus, que  
**Evelyn La:** Foi uma bção.  
**Elane Lima:** bção.  
**Evelyn La:** Ele é muito, muito tranquilo assim. Não posso. Deus me abençoou com esse primeiro filho. Se eu vi a casar de novo,  
**Elane Lima:** É,  
**Evelyn La:** né, e ser mãe de novo, aí não. Vamos ver veremos porque as personalidades são bem diferentes, né? Você tem experiência, pode falar com  
**Elane Lima:** ó,  
**Evelyn La:** três.  
**Elane Lima:** com três. É verdade, mas também dei muita sorte, graças a Deus. Assim,  
**Evelyn La:** Ai,  
**Elane Lima:** meus meus adolescentes são bons adolescentes,  
   
 

### 02:34:08

   
**Evelyn La:** ai, que bom, que bom.  
**Elane Lima:** não são?  
**Evelyn La:** pensando às vezes nessa fase.  
**Elane Lima:** Eh,  
**Evelyn La:** Deixa eu achar aqui os o que eu preciso do seu documento. Угу. E tá quente aí em Floripane. Você já acostumada com  
**Elane Lima:** É, eu acho quente porque para mim lá onde Onde eu moro sempre  
**Evelyn La:** calor, né?  
**Elane Lima:** é oito vezes,  
**Evelyn La:** Eu aqui para nós aqui, nossa,  
**Elane Lima:** né?  
**Evelyn La:** essa semana fez um calor muito muito assim que a gente do Sul não não tá tão acostumado assim com com o abafamento, sabe?  
**Elane Lima:** Um calor.  
**Evelyn La:** Minha nossa,  
**Elane Lima:** Eu vou eu vou. Bora ver.  
**Evelyn La:** vai lá processando.  
**Elane Lima:** Vou tá processando,  
**Evelyn La:** Beleza.  
**Elane Lima:** tá?  
**Evelyn La:** Aí você só manda o comprovante ali no naquele grupo nosso do agendamento mesmo,  
**Elane Lima:** Uhum.  
**Evelyn La:** que ali eu já mandei os dados que eu preciso e  
**Elane Lima:** Bora aqui esse  
**Evelyn La:** dali eu vou fazer o outro grupo de acompanhamento agora  
**Elane Lima:** cartão.  
**Evelyn La:** VIP.  
**Elane Lima:** Olha, ele rejeitou. Deixa eu ver só o que ele vai me mandar no WhatsApp.  
**Evelyn La:** Uhum.  
   
 

### 02:35:59

   
**Elane Lima:** Tá. Bora. Ai,  
**Evelyn La:** vai dar certo. Às vezes é só o que você falou lá primeira vez.  
**Elane Lima:** é, bora ver, Felina. Tô esperando  
**Evelyn La:** O meu ele pede confirmação em duas etapas sempre das minhas transações.  
**Elane Lima:** aqui  
**Evelyn La:** E aí, às vezes ele dá isso também e depois ele M.  
**Elane Lima:** aqui revisar dados e tentar novamente. Bora de novo, senão eu entro em contato lá com cartão. Cartãozinho não vai me deixar na mão. O chat de eu estar longe parece, não sei. Esse cartão todo. E ele é tão bom. Tenho há tantos anos.  
**Evelyn La:** Ah, mas é ele  
**Elane Lima:** Olha, deu de novo. Oação.  
**Evelyn La:** dá.  
**Elane Lima:** Operação não permitida.  
**Evelyn La:** Será que é o  
**Elane Lima:** Não sei te dizer,  
**Evelyn La:** horário?  
**Elane Lima:** sabe? E ele ainda não mandou. Geralmente ele chega logo o WhatsApp aqui.  
**Evelyn La:** Quer aguardar um minutinho e tentar de novo? Você já tentou duas vezes, né?  
**Elane Lima:** Aí, Evil, eu não sei o que fazer.  
**Evelyn La:** Ele tá dando erro.  
   
 

### 02:39:04

   
**Elane Lima:** Não, não. Tá, tá. Operação não permitida.  
**Evelyn La:** Talvez seja o horário mesmo.  
**Elane Lima:** Tá dando operação. Deixa eu até ver aqui. Olha, vou até fazer um print. Eh,  
**Evelyn La:** Uhum.  
**Elane Lima:** pagamento rejeitado, operação não permitida.  
**Evelyn La:** Faz assim.  
**Elane Lima:** Deixa eu ver aqui, entrar aqui com você de novo.  
**Evelyn La:** Você quer quiser tentar às vezes esperar  
**Elane Lima:** Ai,  
**Evelyn La:** um minutinho e tentar de novo.  
**Elane Lima:** por sem problema. Deixa eu entrar aqui no WhatsApp de novo.  
**Evelyn La:** Esses eles são mais burocráticos em alguns pontos mesmo.  
**Elane Lima:** É, não, Itaú,  
**Evelyn La:** Eu tinha Itaú antes também,  
**Elane Lima:** ele é assim.  
**Evelyn La:** eu lembro.  
**Elane Lima:** E mas esse cartão eu tenho, sério, sem brincadeira, tem mais de 15 anos.  
**Evelyn La:** Ah.  
**Elane Lima:** É cartão antigo, eu não tenho conta, entendeu? Só que por eu ser uma cliente fiel,  
**Evelyn La:** Aham.  
**Elane Lima:** ele foi, eu já tenho até o black dele, mas é sempre assim.  
**Evelyn La:** É,  
**Elane Lima:** Eu posso mandar a foto do que apareceu aqui nesse  
**Evelyn La:** não é. Manda.  
   
 

### 02:40:11

   
**Elane Lima:** grupo,  
**Evelyn La:** Pode mandar lá na no grupo.  
**Elane Lima:** nesse grupo Auditoria Comercial,  
**Evelyn La:** Isso.  
**Elane Lima:** Elane,  
**Evelyn La:** Aham.  
**Elane Lima:** eu vou pôr aqui, tá? Como como foi que deu a mensagem aqui, Evil? Eu vou fechar, não tem nem perigo. Eu só quero,  
**Evelyn La:** Não faz assim,  
**Elane Lima:** só vamos organizar isso aí.  
**Evelyn La:** ó. Eh, você mandou lá, né?  
**Elane Lima:** Mandei opera deu pagamento rejeitado,  
**Evelyn La:** Aham.  
**Elane Lima:** operação não permitida. Aí eu já fui lá,  
**Evelyn La:** Aham.  
**Elane Lima:** ele pede aqui revisar os dados. Eu já fui lá, revisei os dados, tá tudo certinho, refiz o cartão e apareceu de  
**Evelyn La:** Tá. Vamos fazer o seguinte,  
**Elane Lima:** novo.  
**Evelyn La:** amanhã de manhã, eh, eu te mando,  
**Elane Lima:** Eu vou tentar ligar.  
**Evelyn La:** te mando ali, te chamo ali no grupo e te mando novamente o link.  
**Elane Lima:** Hum.  
**Evelyn La:** E aí amanhã você finaliza o link,  
**Elane Lima:** Tá.  
**Evelyn La:** faz o pagamento, já me manda seus dados para eu subir seu seu contrato.  
**Elane Lima:** Prato. Eu vou te mandar os dados. Eu vou amanhã não vou para não tenho mentoria,  
   
 

### 02:41:05

   
**Evelyn La:** Isso  
**Elane Lima:** só que eu e ia ter que ir para fora. Como eu tô operada, eu eu vou vou ficar só aqui na pousada. Então a gente vai se falando.  
**Evelyn La:** sim. Não, tranqu. Vamos fazer o seguinte, você me manda os dados.  
**Elane Lima:** Aí eu tenho como ligar lá para eles qualquer  
**Evelyn La:** Aham. Mas faz assim, ó.  
**Elane Lima:** coisa.  
**Evelyn La:** Eu acredito que seja muito por conta do horário, até mesmo pode ser alguma coisa no meu link pelo horário, tá? Fica tranquila quanto a isso. Eh,  
**Elane Lima:** Entendi.  
**Evelyn La:** você me só me manda ali seus dados que eu te mandei no grupo ali, você viu os dados que eu preciso?  
**Elane Lima:** Uhum.  
**Evelyn La:** Me manda seus dados agora que eu já vou subir o seu formulário.  
**Elane Lima:** Tá.  
**Evelyn La:** Aí eu já subo a nossa negociação que é esses 378 vezes e os cinco paraa segunda-feira que vem que vai ser dia. Pegar certinho a data aqui. Dia 9\. Meu calendário. Deixa eu confirmar aqui. Dia 9\. Calendário isso. Então, 5.000 no Pix dia 9, 37 em oito vezes em parcelas de 18,78.  
   
 

### 02:42:28

   
**Evelyn La:** os seus dados ali. Já subo isso no formulário agora de noite. Amanhã de manhã o José já encaminha o seu, já faz o seu contrato certinho e aí sobe o link para assinatura. Aí você amanhã de manhã eu te mando novamente o link aqui no grupo, tá? Você faz o pagamento do link.  
**Elane Lima:** Tá,  
**Evelyn La:** Se a Mari tiver agenda livre à tarde, a gente já faz a primeira call, tá bom?  
**Elane Lima:** tá ótimo. Perfeito.  
**Evelyn La:** Perfeito.  
**Elane Lima:** Certo.  
**Evelyn La:** Aí amanhã quando você finalizar o link e me mandar os dados do do  
**Elane Lima:** Certo.  
**Evelyn La:** contrato aqui, eu faço o grupo VIP lá pra gente fazer o acompanhamento depois.  
**Elane Lima:** Tá, eu vou já preencher isso aqui e te mando,  
**Evelyn La:** Já isso já me manda que daí eu já tô aqui também. Eu já subo o formulário,  
**Elane Lima:** tá bom?  
**Evelyn La:** já agiliza pro José amanhã de manhã, tá bom?  
**Elane Lima:** Tá ótimo.  
**Evelyn La:** Elan,  
**Elane Lima:** Certo.  
**Evelyn La:** seja muito bem-vinda.  
**Elane Lima:** Tá bom.  
**Evelyn La:** Parabéns pela decisão.  
**Elane Lima:** Vai,  
**Evelyn La:** É uma decisão muito importante para você,  
**Elane Lima:** vai.  
**Evelyn La:** primeiramente pro seu negócio. Vamos trabalhar esse CNPJ aí, vamos fazer acontecer, porque você tem muito potencial de crescimento, tem muita coisa aí que a gente consegue expandir na sua operação depois. É só o começo, né? Vamos movimentar umas peças aí da da sua operação que precisa.  
**Elane Lima:** Vai dar certo. Vai dar certo. Já deu. Se Deus quiser. Tá bom. Obrigada. Tá. Já vou mandar. Tchauzinho. Até amanhã.  
   
 

### A transcrição foi encerrada após 02:44:17

*Esta transcrição editável foi gerada por computador e pode conter erros. As pessoas também podem alterar o texto depois que ele for criado.*', '# AUDITORIA DE CALL — Evelyn La x Elane Lima
**Data:** 02/03/2026 | **Duração:** 164 min | **Resultado:** FECHAMENTO - R$ 44.000 (R$ 5.000 entrada + 8x R$ 4.878)

---

## 1. RESUMO EXECUTIVO

Call de fechamento com resultado positivo, mas execução tecnicamente deficiente. Closer demonstrou conhecimento do produto e construiu rapport adequado, porém violou múltiplos princípios do protocolo de elite. Diagnóstico superficial (apenas 3 métricas obtidas), ausência total de perguntas de consequência NEPQ, apresentação monológica excessiva (15+ minutos sem checkpoint), e múltiplas promessas perigosas sem base ("impossível não bater 10 lifts", "mínimo 200k deixando na mesa"). Lead fechou mais pela dor pessoal existente e timing do que pela qualidade da condução. Score reflete execução abaixo do protocolo, apesar do resultado comercial.

---

## 2. SCORECARD

| # | Dimensão | Peso | Nota | Ponderada | Evidência |
|---|---|---|---|---|---|
| 1 | Frame e Liderança | 8% | 7,0 | 0,56 | Rapport longo (7min), três intenções apresentadas mas sem pactos claros |
| 2 | Qualificação Preliminar | 10% | 3,0 | 0,30 | Budget obtido indiretamente, decisor confirmado, sem urgência específica |
| 3 | Diagnóstico Quantitativo | 12% | 2,5 | 0,30 | Apenas 3 métricas: faturamento (~120-300k), tráfego (R$3k), custo fixo (~100k) |
| 4 | Diagnóstico Qualitativo | 8% | 6,0 | 0,48 | Lead verbalizou dores: "corrida dos ratos", falta de previsibilidade |
| 5 | Perguntas de Consequência | 10% | 0,0 | 0,00 | ZERO perguntas "o que acontece se nada mudar" |
| 6 | Ensino Comercial | 5% | 4,0 | 0,20 | Mencionou case Débora, mas sem insight novo transformador |
| 7 | Reframe de Identidade | 5% | 2,0 | 0,10 | Tentativa superficial: "você tem potencial", sem reframe estrutural |
| 8 | Ancoragem de Valor | 10% | 5,0 | 0,50 | Value stack 268k→67k, mas sem ROI traduzido em unidades do negócio |
| 9 | Isolamento de Objeção | 10% | 8,0 | 0,80 | "Isolando fator financeiro, entraria?" executado corretamente |
| 10 | Proporção de Fala | 8% | 3,0 | 0,24 | Closer ~70% do tempo (principalmente 30-60min monológico) |
| 11 | Segurança de Promessas | 8% | 1,0 | 0,08 | Múltiplas promessas perigosas sem base factual |
| 12 | Checkpoints | 3% | 2,0 | 0,06 | Poucos checkpoints em apresentação de 30+ minutos |
| 13 | Controle e Fechamento | 3% | 8,0 | 0,24 | Próximos passos definidos, onboarding iniciado na call |

**SCORE FINAL: 3,9/10 — CALL FRACA**

---

## 3. ANÁLISE BLOCO A BLOCO

### [00:00-07:00] — Abertura e Rapport Inicial | Fase 1A
**O que aconteceu:** Closer iniciou com rapport pessoal sobre lift recém-feito, descobriu origem (Pará), explorou contexto profissional e familiar. Lead compartilhou trajetória de 20+ anos.
**Frameworks aplicados:** Rapport contextual básico
**Frameworks ausentes:** Frame de autoridade, agenda clara, pactos
**Pontos fortes:** Conexão genuína, lead confortável, informações relevantes coletadas
**Erros:** Rapport excessivamente longo (7min), sem controle temporal, sem estabelecer autoridade
**Veredicto do bloco:** 6/10

### [07:00-12:00] — Apresentação e Três Intenções | Fase 1B  
**O que aconteceu:** Closer se apresentou como especialista, mencionou credenciais (6 anos mercado), estabeleceu três intenções: ouvir, avaliar aderência, proposta se fizer sentido.
**Frameworks aplicados:** Três intenções Alex Hormozi
**Frameworks ausentes:** Frame de elegibilidade, segundo pacto
**Pontos fortes:** Estrutura clara das intenções, posicionamento como parceiro
**Erros:** Sem "eu também te avalio", sem "sim ou não, talvez não existe"
**Veredicto do bloco:** 7/10

### [12:00-25:00] — Diagnóstico Estrutural | Fase 2A
**O que aconteceu:** Mapeamento da estrutura: clínica própria, 8 salas, farmacêutica parceira, secretária há 10 anos, gerente, rapaz marketing fixo. Custo alto (~100k), sem processos claros.
**Frameworks aplicados:** SPIN Situação superficial
**Frameworks ausentes:** Diagnóstico quantitativo completo, SPIN Problema/Implicação
**Pontos fortes:** Entendimento da estrutura física e time
**Erros:** Não quantificou métricas específicas (conversão, show rate, ticket real)
**Veredicto do bloco:** 5/10

### [25:00-30:00] — Validação Preliminar | Fase 2B
**O que aconteceu:** Closer validou cenário: "você tá deixando 200k na mesa", mencionou case Débora (150k→550k), estabeleceu potencial sem base calculada.
**Frameworks aplicados:** Social proof contextualizado
**Frameworks ausentes:** Cálculo demonstrado do potencial
**Pontos fortes:** Case similar (Pará, mesma especialidade)
**Erros:** **PROMESSA PERIGOSA:** "mínimo 200k na mesa" sem cálculo demonstrado
**Veredicto do bloco:** 4/10

### [30:00-60:00] — Apresentação Metodologia | Fase 5A (fora de sequência)
**O que aconteceu:** Apresentação extensa dos 8 pilares, CRM, protocolos, sem interação significativa do lead. Monólogo de 30 minutos praticamente ininterrupto.
**Frameworks aplicados:** Apresentação estruturada
**Frameworks ausentes:** Checkpoints regulares, NEPQ, consequência
**Pontos fortes:** Conteúdo estruturado, metodologia clara
**Erros:** **CRÍTICO:** Apresentação antes de amplificar dor, zero checkpoints por 30min, proporção 90/10
**Veredicto do bloco:** 3/10

### [60:00-90:00] — Validação e Tentativa de Consequência | Fase 4A
**O que aconteceu:** Lead confirmou necessidade de processos ("não tenho processo nenhum"), closer tentou validar valor mas sem aprofundar consequências emocionais.
**Frameworks aplicados:** Validação da metodologia
**Frameworks ausentes:** **NEPQ Consequência** - pergunta mais importante da call
**Pontos fortes:** Lead verbalizou dor abertamente
**Erros:** **FATAL:** Não perguntou "o que acontece nos próximos 12 meses se nada mudar?"
**Veredicto do bloco:** 4/10

### [90:00-120:00] — Apresentação Execução e Cases | Fase 5B
**O que aconteceu:** Detalhamento de como funciona implementação, groups VIP, cronograma de reuniões, cases de resultados sem base temporal clara.
**Frameworks aplicados:** Prova social, implementação detalhada
**Frameworks ausentes:** Ancoragem baseada no diagnóstico específico do lead
**Pontos fortes:** Processo bem estruturado, acompanhamento detalhado
**Erros:** Não conectou oferta aos problemas específicos diagnosticados
**Veredicto do bloco:** 6/10

### [120:00-145:00] — Isolamento e Ancoragem Valor | Fase 4B e 5C
**O que aconteceu:** "Isolando fator financeiro, entraria?" - SIM. Ancoragem 268k → 67k → 51k → 44k com condição especial para decisão em call.
**Frameworks aplicados:** Isolamento financeiro correto, ancoragem de valor
**Frameworks ausentes:** ROI traduzido em procedimentos específicos
**Pontos fortes:** Isolamento bem executado, desconto justificado por decisão em call
**Erros:** Não traduziu: "X lifts a mais pagam o investimento"
**Veredicto do bloco:** 8/10

### [145:00-164:00] — Negociação e Fechamento | Fase 6
**O que aconteceu:** Negociação forma de pagamento, ajuste parcelas (6x→8x), tentativa pagamento com problemas técnicos, reagendamento para dia seguinte com contrato.
**Frameworks aplicados:** Flexibilidade na negociação
**Frameworks ausentes:** Fechamento emocional, reforço pós-decisão
**Pontos fortes:** Flexibilidade, próximos passos claros
**Erros:** Não reforçou a decisão, deixou energia cair
**Veredicto do bloco:** 7/10

---

## 4. MAPA DE FRAMEWORKS

| Framework | Presença (0-10) | Onde aplicou | Onde faltou | Impacto |
|---|---|---|---|---|
| Hormozi (CLOSER) | 4/10 | Label (dores), Sell vacation (tranquilidade) | Clarify, Overlook, Explain away | Médio - estrutura parcial |
| Miner (NEPQ) | 2/10 | Connection básica | **Consequence Questions (ZERO)** | **ALTO - perdeu momento crucial** |
| Belfort (Straight Line) | 3/10 | Controle parcial | Lead desviou várias vezes sem redirecionamento | Médio |
| Cole Gordon | 5/10 | Frame inicial, Isolamento | Diagnóstico profundo ausente | Médio |
| Eli Wilde | 2/10 | Tentativas de reframe superficiais | Mudança de crença/identidade | Alto - não trabalhou bloqueios |
| Dan Lok | 6/10 | Postura autoridade mantida | Poderia ser mais "médico" | Baixo |
| Rackham (SPIN) | 3/10 | Situação mapeada | Problema→Implicação→Necessidade | Alto - diagnóstico superficial |
| Challenger Sale | 3/10 | Case Débora como insight | Tensão construtiva, ensino comercial | Médio |
| Sabri Suby | 6/10 | Ancoragem valor, oferta estruturada | ROI específico, garantias | Médio |
| Brad Lea | 5/10 | Antecipou objeção financeira | Outras objeções universais | Baixo |

---

## 5. TOP 5 ACERTOS
1. **Isolamento de Objeção Financeira** — [120:38] — "Isolando o fator financeiro, hoje você estaria em parceria com a gente?" Executado perfeitamente conforme Cole Gordon.
2. **Case Contextualizado** — [36:17] — Débora de Parauapebas, mesmo estado, mesma especialidade, resultado concreto 150k→550k.
3. **Flexibilidade na Negociação** — [145:00+] — Ajustou parcelas de 6x para 8x conforme capacidade do lead, mantendo fechamento.
4. **Próximos Passos Claros** — [162:00+] — Contrato, primeira reunião em 48h, grupo VIP, onboarding estruturado.
5. **Ancoragem de Valor Estruturada** — [142:46] — 268k→67k→51k→44k com justificativa do desconto por decisão em call.

---

## 6. TOP 5 ERROS (por gravidade)

### 1. **[GRAVIDADE ALTA] Ausência Total de NEPQ Consequence** — [Todo diagnóstico]
**Descrição:** Zero perguntas sobre consequências de não mudar. Perdeu o momento mais importante da call.
**O que deveria ter sido:** "Elane, se nos próximos 12 meses nada mudar, onde você se vê? O que acontece com essa ''corrida dos ratos'' que você mencionou?"
**Framework que preveniria:** Jeremy Miner NEPQ
**Impacto:** CRÍTICO - Lead não sentiu urgência emocional de mudança

### 2. **[GRAVIDADE ALTA] Promessas Perigosas sem Base** — [Multiple timestamps]
**Descrição:** "Impossível não bater 10 lifts", "mínimo 200k na mesa", "muito fácil atingir"
**O que deveria ter sido:** "Cases similares conseguem X resultado em Y prazo, depende da execução"
**Framework que preveniria:** Auditoria de promessas
**Impacto:** ALTO - Risco de churn por expectativas infladas

### 3. **[GRAVIDADE ALTA] Diagnóstico Quantitativo Superficial** — [12:00-25:00]
**Descrição:** Apenas 3 métricas coletadas, sem taxa conversão, show rate, ticket real
**O que deveria ter sido:** "Quantos leads chegam por mês? Quantos agendam? Quantos comparecem? Quantos fecham? Ticket médio real?"
**Framework que preveniria:** SPIN Selling estruturado
**Impacto:** ALTO - Proposta sem base sólida de potencial

### 4. **[GRAVIDADE MÉDIA-ALTA] Apresentação Monológica** — [30:00-60:00]
**Descrição:** 30 minutos sem checkpoint significativo, proporção 90/10
**O que deveria ter sido:** Checkpoint a cada 5min: "Até aqui faz sentido? Alguma dúvida?"
**Framework que preveniria:** Controle de proporção Brad Lea
**Impacto:** MÉDIO-ALTO - Lead desconectado, sem confirmação de entendimento

### 5. **[GRAVIDADE MÉDIA] Apresentação Antes da Amplificação** — [30:00]
**Descrição:** Pulou direto para solução sem aprofundar dor emocional
**O que deveria ter sido:** NEPQ consequence → ensino comercial → ENTÃO apresentação
**Framework que preveniria:** Protocolo 6 fases sequencial
**Impacto:** MÉDIO - Perdeu oportunidade de criar necessidade

---

## 7. REESCRITA DE MOMENTOS CRÍTICOS

### Momento 1: [25:16] — Validação sem Base Calculada
**O QUE FOI DITO:** "Pelo que você tá me passando, você no mínimo tá deixando os 200k na mesa só por não ter processo"
**O QUE DEVERIA TER SIDO DITO:** "Vamos calcular juntas. Você fatura 150k gastando 3k de tráfego. Se otimizarmos essa conversão - casos similares melhoram 40-60% - estamos falando de 60-90k a mais por mês. Em 6 meses, são 360-540k de potencial adicional. Isso faz sentido pelo seu cenário?"
**POR QUÊ:** Sabri Suby - ancoragem baseada em cálculo demonstrado, não estimativa genérica
**IMPACTO ESTIMADO:** Credibilidade técnica + urgência baseada em números reais

### Momento 2: [60:00] — Momento NEPQ Perdido
**O QUE FOI DITO:** [Partiu direto para apresentação]
**O QUE DEVERIA TER SIDO DITO:** "Elane, me ajuda a entender uma coisa. Você falou dessa ''corrida dos ratos'', dessa ansiedade de não saber se vai ter agenda no mês que vem. Se nos próximos 12 meses nada mudar nesse cenário, onde você se vê? Como isso afeta sua tranquilidade, seu sono, sua família? O que essa incerteza faz com você?"
**POR QUÊ:** Jeremy Miner NEPQ Consequence - pergunta mais importante da call
**IMPACTO ESTIMADO:** Lead verbalizaria dor emocional profunda, criando necessidade real de mudança

### Momento 3: [142:00] — Ancoragem sem ROI Traduzido
**O QUE FOI DITO:** "O valor todo se fosse colocar em cash seria 268k, mas você vai ter 75% desconto"
**O QUE DEVERIA TER SIDO DITO:** "Você cobra 20k por lifting. Nosso investimento são R$ 44k no total. Você precisa de 2,2 liftings a mais em 6 meses para pagar o programa. Pelos números que levantamos, você tem potencial para 10+ por mês. Quanto vale vs quanto custa?"
**POR QUÊ:** Alex Hormozi Value Equation - ROI traduzido em unidades do negócio
**IMPACTO ESTIMADO:** Decisão lógica clara baseada em números familiares ao lead

### Momento 4: [90:45] — Reframe Superficial
**O QUE FOI DITO:** "Você tem muito potencial, com certeza"
**O QUE DEVERIA TER SIDO DITO:** "Elane, você já é a cirurgiã certa para o próximo nível. Tem 20 anos de experiência, clínica própria, credibilidade construída. O que falta não é competência técnica - você já provou isso. O que falta é um sistema comercial à altura do que você entrega. É como ter uma Ferrari com pneu de Fusca."
**POR QUÊ:** Eli Wilde Identity Reframe - mudança de crença limitante
**IMPACTO ESTIMADO:** Lead passaria de "será que consigo?" para "mereço ter isso funcionando"

### Momento 5: [158:33] — Promessa sem Base
**O QUE FOI DITO:** "É impossível você não fazer 10 lifting por mês com o nome que você já tem"
**O QUE DEVERIA TER SIDO DITO:** "Temos cases de cirurgiões similares que passaram de 1-2 por semana para 8-10 por mês implementando o processo. Com sua credibilidade e estrutura, esse range é muito viável. Claro que depende da execução tanto sua quanto nossa."
**POR QUÊ:** Auditoria de promessas - resultado baseado em cases, não garantia absoluta
**IMPACTO ESTIMADO:** Expectativa realista + proteção contra churn futuro

---

## 8. PLANO DE AÇÃO

### Recomendação 1: Implementar Gate de NEPQ Obrigatório
- **O que fazer:** Nunca avançar para apresentação sem pelo menos 2 perguntas de consequência respondidas
- **Por quê:** É o momento que transforma interesse em necessidade urgente
- **Como treinar:** Role-play focado: diagnosticar → NEPQ → só então apresentar
- **Prioridade:** ALTA

### Recomendação 2: Calibrar Linguagem de Promessas
- **O que fazer:** Substituir "impossível não", "garanto", "com certeza" por "cases similares", "potencial", "depende da execução"
- **Por quê:** Reduzir churn e passivo jurídico por expectativas infladas
- **Como treinar:** Gravar calls e marcar toda promessa perigosa para reescrita
- **Prioridade:** ALTA

### Recomendação 3: Estruturar Diagnóstico Quantitativo
- **O que fazer:** Checklist obrigatório de 10 métricas antes de avançar
- **Por quê:** Proposta sem base quantitativa é tiro no escuro
- **Como treinar:** Script exato de perguntas + planilha para cálculos na call
- **Prioridade:** ALTA

### Recomendação 4: Controlar Proporção de Fala
- **O que fazer:** Checkpoint obrigatório a cada 5 minutos de apresentação
- **Por quê:** Lead desconectado não compra, só aceita por outras razões
- **Como treinar:** Timer visível + meta: closer máximo 40% do tempo
- **Prioridade:** MÉDIA

### Recomendação 5: ROI em Unidades do Negócio
- **O que fazer:** Sempre traduzir investimento em "X procedimentos" ou "Y% do faturamento atual"
- **Por quê:** Lead pensa em procedimentos, não em valores abstratos
- **Como treinar:** Calculadora de ROI por nicho + fórmulas prontas
- **Prioridade:** MÉDIA

### Recomendação 6: Sequência do Protocolo 6 Fases
- **O que fazer:** Respeitar ordem: diagnóstico → consequência → ensino → ENTÃO apresentação
- **Por quê:** Cada fase prepara a próxima psicologicamente
- **Como treinar:** Checklist de gates de passagem entre fases
- **Prioridade:** MÉDIA

### Recomendação 7: Reframe de Identidade Estruturado
- **O que fazer:** Trabalhar crença limitante ANTES do preço usando fórmula Eli Wilde
- **Por quê:** Lead que não se vê merecendo não sustenta a decisão
- **Como treinar:** Script: "Você já é X, o que falta é Y à sua altura"
- **Prioridade:** BAIXA

---

## 9. ALERTAS DE PROMESSA

**PROMESSAS DE RISCO IDENTIFICADAS:**

1. **[19:44]** "No mínimo você teria que tá recebendo o dobro" → "Cases similares conseguem 40-100% de melhoria"
2. **[158:33]** "É impossível você não fazer 10 lifting por mês" → "O potencial para 8-12 é muito viável baseado no seu cenário"
3. **[109:46]** "Posso estar equivocada, mas você no mínimo tá deixando 200k na mesa" → "Pela média de conversão que vemos, o potencial adicional é significativo"
4. **[158:59]** "Acho impossível a gente não ter 10 cirurgias para colocar na sua mão" → "Nossa meta é trabalhar para esse range baseado em cases similares"
5. **[212:21]** "Muito fácil você atingir esse faturamento" → "Com execução consistente, esse resultado é alcançável"

**RISCO:** Expectativas infladas podem gerar churn se resultados demorarem ou forem menores.

**VERSÕES SEGURAS:** Sempre usar "cases similares", "potencial", "com execução adequada", "objetivo é".

---

## 10. ANÁLISE DE SENTIMENTO DO LEAD

### Sentimento Geral
- **Sentimento:** Positivo com momentos de ansiedade
- **Score de Sentimento:** 0.6 (escala -1.0 a 1.0)
- **Nível de Engajamento:** Médio-Alto

### Timeline de Sentimento
| Trecho | Sentimento | Confiança (0-1) | Momento-Chave |
|--------|-----------|-----------------|---------------|
| 00:00-07:00 | neutro-positivo | 0.8 | Rapport sobre lift e trajetória |
| 07:00-30:00 | positivo | 0.9 | Engajamento nas dores do negócio |
| 30:00-60:00 | neutro | 0.7 | Apresentação longa sem interação |
| 60:00-90:00 | positivo | 0.8 | "É isso que eu quero" |
| 90:00-120:00 | ansioso-positivo | 0.9 | "Me dá até frio na barriga" |
| 120:00-145:00 | negociação | 0.8 | Resistência ao preço |
| 145:00-164:00 | positivo-decidido | 0.9 | "Vou fechar" |

### Objeções Detectadas
1. **[148:13]** "Achei 8000 mês ainda pesado para mim" | **Resposta:** Ajuste parcelas | **Efetividade:** Boa
2. **[149:05]** "Tinha uma média de 3,5 a 4 no máximo" | **Resposta:** Negociação valor | **Efetividade:** Boa  
3. **[200:17]** "Preciso que a clínica renda mais para segurar isso" | **Resposta:** "Já tem que tá faturando dobro no segundo mês" | **Efetividade:** Ruim (promessa perigosa)
4. **[241:14]** "É arriscado pagar sem ver o contrato" | **Resposta:** "É nossa metodologia" | **Efetividade:** Média

**PRINCIPAIS GATILHOS EMOCIONAIS:**
- "Corrida dos ratos" (dor recorrente)  
- "Quero paz" (desejo principal)
- "Altura do campeonato" (senso de urgência temporal)
- Case Débora (prova social forte por similaridade)', '🔴 AUDITORIA: Elane x Cliente Teste
📅 2026-03-02 | ⏱ 60min
📊 Score: 3.9/10 — FRACA

✅ Top Acertos:
1. Isolamento de Objeção Financeira
2. Case Contextualizado
3. Flexibilidade na Negociação

❌ Top Erros:
1. Ausência Total de NEPQ Consequence
2. Promessas Perigosas sem Base
3. Diagnóstico Quantitativo Superficial', '[{"rank": 1, "title": "Ausência Total de NEPQ Consequence", "severity": "GRAVIDADE ALTA", "description": "[Todo diagnóstico]"}, {"rank": 2, "title": "Promessas Perigosas sem Base", "severity": "GRAVIDADE ALTA", "description": "[Multiple timestamps]"}, {"rank": 3, "title": "Diagnóstico Quantitativo Superficial", "severity": "GRAVIDADE ALTA", "description": "[12:00-25:00]"}, {"rank": 4, "title": "Apresentação Monológica", "severity": "GRAVIDADE MÉDIA-ALTA", "description": "[30:00-60:00]"}, {"rank": 5, "title": "Apresentação Antes da Amplificação", "severity": "GRAVIDADE MÉDIA", "description": "[30:00]"}]'::jsonb, '[{"rank": 1, "title": "Isolamento de Objeção Financeira", "description": "[120:38] — \"Isolando o fator financeiro, hoje você estaria em parceria com a gente?\" Executado perfeitamente conforme Cole Gordon."}, {"rank": 2, "title": "Case Contextualizado", "description": "[36:17] — Débora de Parauapebas, mesmo estado, mesma especialidade, resultado concreto 150k→550k."}, {"rank": 3, "title": "Flexibilidade na Negociação", "description": "[145:00+] — Ajustou parcelas de 6x para 8x conforme capacidade do lead, mantendo fechamento."}, {"rank": 4, "title": "Próximos Passos Claros", "description": "[162:00+] — Contrato, primeira reunião em 48h, grupo VIP, onboarding estruturado."}, {"rank": 5, "title": "Ancoragem de Valor Estruturada", "description": "[142:46] — 268k→67k→51k→44k com justificativa do desconto por decisão em call."}]'::jsonb, '[{"rank": 1, "title": "Implementar Gate de NEPQ Obrigatório", "por_que": "É o momento que transforma interesse em necessidade urgente", "prioridade": "ALTA", "o_que_fazer": "Nunca avançar para apresentação sem pelo menos 2 perguntas de consequência respondidas", "como_treinar": "Role-play focado: diagnosticar → NEPQ → só então apresentar"}, {"rank": 2, "title": "Calibrar Linguagem de Promessas", "por_que": "Reduzir churn e passivo jurídico por expectativas infladas", "prioridade": "ALTA", "o_que_fazer": "Substituir \"impossível não\", \"garanto\", \"com certeza\" por \"cases similares\", \"potencial\", \"depende da execução\"", "como_treinar": "Gravar calls e marcar toda promessa perigosa para reescrita"}, {"rank": 3, "title": "Estruturar Diagnóstico Quantitativo", "por_que": "Proposta sem base quantitativa é tiro no escuro", "prioridade": "ALTA", "o_que_fazer": "Checklist obrigatório de 10 métricas antes de avançar", "como_treinar": "Script exato de perguntas + planilha para cálculos na call"}, {"rank": 4, "title": "Controlar Proporção de Fala", "por_que": "Lead desconectado não compra, só aceita por outras razões", "prioridade": "MÉDIA", "o_que_fazer": "Checkpoint obrigatório a cada 5 minutos de apresentação", "como_treinar": "Timer visível + meta: closer máximo 40% do tempo"}, {"rank": 5, "title": "ROI em Unidades do Negócio", "por_que": "Lead pensa em procedimentos, não em valores abstratos", "prioridade": "MÉDIA", "o_que_fazer": "Sempre traduzir investimento em \"X procedimentos\" ou \"Y% do faturamento atual\"", "como_treinar": "Calculadora de ROI por nicho + fórmulas prontas"}, {"rank": 6, "title": "Sequência do Protocolo 6 Fases", "por_que": "Cada fase prepara a próxima psicologicamente", "prioridade": "MÉDIA", "o_que_fazer": "Respeitar ordem: diagnóstico → consequência → ensino → ENTÃO apresentação", "como_treinar": "Checklist de gates de passagem entre fases"}, {"rank": 7, "title": "Reframe de Identidade Estruturado", "por_que": "Lead que não se vê merecendo não sustenta a decisão", "prioridade": "BAIXA", "o_que_fazer": "Trabalhar crença limitante ANTES do preço usando fórmula Eli Wilde", "como_treinar": "Script: \"Você já é X, o que falta é Y à sua altura\""}]'::jsonb, '[{"frase": "No mínimo você teria que tá recebendo o dobro", "descricao": "\"Cases similares conseguem 40-100% de melhoria\"\n2. **[158:33]** \"É impossível você não fazer 10 lifting por mês\" → \"O potencial para 8-12 é muito viável baseado no seu cenário\"\n3. **[109:46]** \"Posso estar equivocada, mas você no mínimo tá deixando 200k na mesa\" → \"Pela média de conversão que vemos, o potencial adicional é significativo\"\n4. **[158:59]** \"Acho impossível a gente não ter 10 cirurgias para colocar na sua mão\" → \"Nossa meta é trabalhar para esse range baseado em cases similares\"\n5. **[212:21]** \"Muito fácil você atingir esse faturamento\" → \"Com execução consistente, esse resultado é alcançável\""}]'::jsonb, '[{"impact": "Credibilidade técnica + urgência baseada em números reais", "reason": "Sabri Suby - ancoragem baseada em cálculo demonstrado, não estimativa genérica", "original": "Pelo que você tá me passando, você no mínimo tá deixando os 200k na mesa só por não ter processo", "rewritten": "Vamos calcular juntas. Você fatura 150k gastando 3k de tráfego. Se otimizarmos essa conversão - casos similares melhoram 40-60% - estamos falando de 60-90k a mais por mês. Em 6 meses, são 360-540k de potencial adicional. Isso faz sentido pelo seu cenário?", "description": "[25:16] — Validação sem Base Calculada"}, {"impact": "Lead verbalizaria dor emocional profunda, criando necessidade real de mudança", "reason": "Jeremy Miner NEPQ Consequence - pergunta mais importante da call", "original": "[Partiu direto para apresentação]", "rewritten": "Elane, me ajuda a entender uma coisa. Você falou dessa ''corrida dos ratos'', dessa ansiedade de não saber se vai ter agenda no mês que vem. Se nos próximos 12 meses nada mudar nesse cenário, onde você se vê? Como isso afeta sua tranquilidade, seu sono, sua família? O que essa incerteza faz com você?", "description": "[60:00] — Momento NEPQ Perdido"}, {"impact": "Decisão lógica clara baseada em números familiares ao lead", "reason": "Alex Hormozi Value Equation - ROI traduzido em unidades do negócio", "original": "O valor todo se fosse colocar em cash seria 268k, mas você vai ter 75% desconto", "rewritten": "Você cobra 20k por lifting. Nosso investimento são R$ 44k no total. Você precisa de 2,2 liftings a mais em 6 meses para pagar o programa. Pelos números que levantamos, você tem potencial para 10+ por mês. Quanto vale vs quanto custa?", "description": "[142:00] — Ancoragem sem ROI Traduzido"}, {"impact": "Lead passaria de \"será que consigo?\" para \"mereço ter isso funcionando", "reason": "Eli Wilde Identity Reframe - mudança de crença limitante", "original": "Você tem muito potencial, com certeza", "rewritten": "Elane, você já é a cirurgiã certa para o próximo nível. Tem 20 anos de experiência, clínica própria, credibilidade construída. O que falta não é competência técnica - você já provou isso. O que falta é um sistema comercial à altura do que você entrega. É como ter uma Ferrari com pneu de Fusca.", "description": "[90:45] — Reframe Superficial"}, {"impact": "Expectativa realista + proteção contra churn futuro", "reason": "Auditoria de promessas - resultado baseado em cases, não garantia absoluta", "original": "É impossível você não fazer 10 lifting por mês com o nome que você já tem", "rewritten": "Temos cases de cirurgiões similares que passaram de 1-2 por semana para 8-10 por mês implementando o processo. Com sua credibilidade e estrutura, esse range é muito viável. Claro que depende da execução tanto sua quanto nossa.", "description": "[158:33] — Promessa sem Base"}]'::jsonb, '{"Dan Lok": {"score": 6.0, "impact": "Baixo", "where_applied": "Postura autoridade mantida", "where_missing": "Poderia ser mais \"médico\""}, "Brad Lea": {"score": 5.0, "impact": "Baixo", "where_applied": "Antecipou objeção financeira", "where_missing": "Outras objeções universais"}, "Eli Wilde": {"score": 2.0, "impact": "Alto - não trabalhou bloqueios", "where_applied": "Tentativas de reframe superficiais", "where_missing": "Mudança de crença/identidade"}, "Sabri Suby": {"score": 6.0, "impact": "Médio", "where_applied": "Ancoragem valor, oferta estruturada", "where_missing": "ROI específico, garantias"}, "Cole Gordon": {"score": 5.0, "impact": "Médio", "where_applied": "Frame inicial, Isolamento", "where_missing": "Diagnóstico profundo ausente"}, "Miner (NEPQ)": {"score": 2.0, "impact": "**ALTO - perdeu momento crucial**", "where_applied": "Connection básica", "where_missing": "**Consequence Questions (ZERO)**"}, "Rackham (SPIN)": {"score": 3.0, "impact": "Alto - diagnóstico superficial", "where_applied": "Situação mapeada", "where_missing": "Problema→Implicação→Necessidade"}, "Challenger Sale": {"score": 3.0, "impact": "Médio", "where_applied": "Case Débora como insight", "where_missing": "Tensão construtiva, ensino comercial"}, "Hormozi (CLOSER)": {"score": 4.0, "impact": "Médio - estrutura parcial", "where_applied": "Label (dores), Sell vacation (tranquilidade)", "where_missing": "Clarify, Overlook, Explain away"}, "Belfort (Straight Line)": {"score": 3.0, "impact": "Médio", "where_applied": "Controle parcial", "where_missing": "Lead desviou várias vezes sem redirecionamento"}}'::jsonb, '[]'::jsonb, 'test://elane-call-2026-03-02.ogg', NULL, NULL, NULL, NULL, 'whisper-large-v3', 'claude-sonnet-4-20250514', 61938, 6806, 0.2879, '2026-03-25T03:43:25.941975+00:00', NULL, '2026-03-25T04:20:13.365517+00:00', '2026-03-28T01:21:28.617+00:00', '2026-03-28T01:21:28.617+00:00', '2026-03-25T03:43:25.941975+00:00', '2026-03-28T01:21:28.652144+00:00', 'positive', '[{"sentiment": "positive", "confidence": 0.9, "key_moment": "Engajamento nas dores do negócio", "timestamp_range": "07:00-30:00"}, {"sentiment": "neutral", "confidence": 0.7, "key_moment": "Apresentação longa sem interação", "timestamp_range": "30:00-60:00"}, {"sentiment": "positive", "confidence": 0.8, "key_moment": "\"É isso que eu quero\"", "timestamp_range": "60:00-90:00"}]'::jsonb, 0.6, 'medium', '[]'::jsonb, '1.0', 'c38c5031ea0bcad6', 'bef46d54-8c64-4403-9f59-d0eda47e0065/auditoria_2026-03-02_cliente-teste.md');

INSERT INTO call_audits (id, organization_id, closer_id, lead_name, call_date, duration_minutes, resultado, valor_fechamento, status, error_message, score_final, classificacao, d01_frame, d02_qualificacao, d03_diag_quantitativo, d04_diag_qualitativo, d05_consequencia, d06_ensino, d07_identidade, d08_ancoragem, d09_isolamento, d10_proporcao_fala, d11_promessas, d12_checkpoints, d13_fechamento, transcricao, relatorio_completo, resumo_whatsapp, top_erros, top_acertos, plano_acao, frases_proibidas, reescrita_falas, mapa_frameworks, fases_analise, audio_path, audio_duration_seconds, drive_file_id, drive_url, drive_report_url, modelo_transcricao, modelo_analise, tokens_input, tokens_output, custo_estimado, uploaded_at, transcribed_at, analyzed_at, notified_at, completed_at, created_at, updated_at, sentiment_overall, sentiment_timeline, sentiment_score, engagement_level, objections_detected, prompt_version, report_hash, storage_report_path) VALUES
('35597e31-aa45-4026-b864-84d53f13a2cc', '4ecd8f2d-d0c5-419c-a5bc-b2e94dca0465', '171a0543-1dde-4ba4-99f8-d396c6832b60', 'Dra. Luciana Dias', '2026-03-16', 60, NULL, NULL, 'completed', NULL, 1.7, 'FRACA', 2.0, 1.0, 0.5, 4.0, 0.0, 2.0, 0.0, 1.0, 0.0, 3.0, 7.0, 1.0, 0.0, '16 de mar. de 2026

## Auditoria Comercial | Dra. Luciana Dias \- Transcrição

### 00:00:00

   
**Evelyn La:** Oi, Luciana. Só acender minha luz aqui.  
**luciana:** Oi.  
**Evelyn La:** Tudo bem? Tá me ouvindo?  
**luciana:** Sim, tô te ouvindo.  
**Evelyn La:** Consegue abrir sua câmera?  
**luciana:** Hã,  
**Evelyn La:** Consegue abrir sua câmera?  
**luciana:** sim. Espera só um minutinho  
**Evelyn La:** Claro, claro. Vou acender minha luz aqui  
**luciana:** aqui.  
**Evelyn La:** também.  
**luciana:** Já tá pronta aqui. Mas você quer entrar para saber o que que ela vai falar ou não? Hã? Você quer entrar para saber o que que ela vai falar ou não? E depois tem que ver. Se que sabe porque daí se você chegou paciente faz depois você agora fazer mais você que sabe você quiser partir não quiser você quiser me falar depois obrigada esses trein esses cursos assim tem uns cursos que a tanto Ai, meu Deus. Agora é consulta. Tem que pronto. Socorro. Pronto. Socorro. Ah, você vai ter que me dar 10 minutos. Eu tenho que atender um paciente. Tem problema?  
**Evelyn La:** Eh, mas é rápido mesmo ou você acredita que demora  
**luciana:** Eu não sei qual que é o problema dele.  
**Evelyn La:** mais?  
**luciana:** Tá lá no Pronto. Socorro. Acho que uns 10, 15 minutos.  
   
 

### 00:01:49

   
**Evelyn La:** Hum.  
**luciana:** Vou deixar até aberto  
**Evelyn La:** Então, eh, então eu vou fazer o seguinte, Luciana,  
**luciana:** aqui,  
**Evelyn La:** porque como nossos horários eu tenho agendamento depois e deu quanto que atrasa aqui compromete o do próximo. Eu vou falar com a Laía, gente, qual coisa reagenda,  
**luciana:** tá? Mas então vou fazer o seguinte,  
**Evelyn La:** é mais fácil.  
**luciana:** será que que que eu preciso? É o seguinte, eh porque você falou que vocês entregam pacientes, né?  
**Evelyn La:** Como assim? Entrega o  
**luciana:** Tipo assim, entrega para sempre, vamos supor,  
**Evelyn La:** paciente.  
**luciana:** eh, ou vocês só fazem qual pelo pelo que eu vi a propaganda no Instagram que vocês me lotam meu consultório em relação aos  
**Evelyn La:** Uhum.  
**luciana:** procedimentos que eu faço.  
**Evelyn La:** Uhum.  
**luciana:** Foi pelo menos foi isso que eu entendi.  
**Evelyn La:** Certo?  
**luciana:** Então aí eu quero saber se realmente eu entendi isso ou se  
**Evelyn La:** O que que acontece, na verdade,  
**luciana:** não.  
**Evelyn La:** Luciana? O diagnóstico é para eu poder entender o seu cenário para de fato saber se o que a gente tem como método, ele se encaixa na sua realidade. Por quê? Porque a gente trabalha duas frentes. A gente trabalha a qualificação e captação por tráfego pago mais estrutura comercial.  
   
 

### 00:02:52

   
**luciana:** Entendi.  
**Evelyn La:** Então eu até preciso entender, por exemplo, hoje a Luciana ela tem uma secretária e aí várias coisas que eu preciso entender no diagnóstico para de fato saber se vai ser viável para você a nossa  
**luciana:** Tem  
**Evelyn La:** metodologia, porque o lotar a agenda, ele vai vi como consequência de vários processos comerciais, não só tráfego pago. Na verdade, o tráfego pago ele é o de menos.  
**luciana:** não. Sim, claro, com certeza.  
**Evelyn La:** Então, eh, para eu poder realmente entender, eh, a gente precisaria fazer o diagnóstico, porque se no diagnóstico também entender que o seu cenário ele não vai não, né? Ah, no por exemplo, não vai conseguir aplicar, eh, a gente nem dá sequência, porque senão acaba sendo frustrante,  
**luciana:** É porque assim,  
**Evelyn La:** né?  
**luciana:** eu já entrei com várias empresas e aí eu não consegui reverter, entendeu?  
**Evelyn La:** Aham. Aí você entrou com empresas de  
**luciana:** Então não adiantar, é, inclusive até aqui da região mesmo,  
**Evelyn La:** marketing.  
**luciana:** já gastei muito dinheiro com tráfego pago, com faz propaganda, tudo, eu não consigo reverter. Não adianta você só fazer propaganda para se mostrar no Instagram se não conseguir reverter.  
**Evelyn La:** Exatamente. Por isso que a gente não foca em tráfego pago,  
   
 

### 00:04:13

   
**luciana:** Então,  
**Evelyn La:** a gente faz também. Mas o grande processo que vai trazer e vai aumentar a sua venda é uma você aprender a vender. De fato,  
**luciana:** Uhum.  
**Evelyn La:** você ter uma oferta eh que seja atraente. Quando eu falo de oferta não é vender o produto isolado, não. Existe uma metodologia para isso. E você ter processos comerciais que vão trabalhar inclusive base de pacientes que você tem. É isso que vai te trazer conversão, é isso que vai te fazer ter mais  
**luciana:** E o que que você quer saber a respeito de hoje?  
**Evelyn La:** volume.  
**luciana:** Como eu trabalho? O que que você precisa saber?  
**Evelyn La:** Eu precis entender como que é a sua atuação hoje, seus objetivos,  
**luciana:** Eu  
**Evelyn La:** toda a parte hoje de estrutura que você tem, para onde você quer chegar e como que é feito o seu comercial  
**luciana:** sou médico,  
**Evelyn La:** atualmente.  
**luciana:** clínico geral e dermatologista. Eu, como na parte da dermatologia, eh, eu abranjo muita coisa. Eu faço testes alérgicos,  
**Evelyn La:** Uhum.  
**luciana:** eu faço cirurgias, pequenas cirurgias retiradas de câncer, de tumor, faz toda a parte de do estimulador, preenchimento, eh, botox, peeling, hum,  
**Evelyn La:** Угу.  
**luciana:** faço laser de CO2, faço a parte cirúrgica, eu também abordo, eu faço também bleferoplastia.  
   
 

### 00:05:36

   
**luciana:** Então assim, eu tenho um leque para trabalhar muito grande, não sei porque um dos motivos que eu acho que não converte é o quê? Eu trabalho dentro de um hospital, então ele é uma estrutura fechada. Eh, e esse hospital é mais plano, então são pessoas de de mais baixa renda, classe C, e são procedimentos um pouco mais caros, né? Então é difícil você eh eh às vezes, então eu acho que a dificuldade pode ser essa, mais difícil  
**Evelyn La:** Tá. Mas você queria lotar sua agenda particular ou você necessariamente precisa estar vinculada ao  
**luciana:** você  
**Evelyn La:** hospital?  
**luciana:** não tanto  
**Evelyn La:** A gente tem um problema mesmo,  
**luciana:** faz  
**Evelyn La:** entendeu? uma limitação  
**luciana:** não, eu não,  
**Evelyn La:** sua,  
**luciana:** eu posso atender um paciente que só vem aqui atender comigo. Eu possoer procedimentos particulares,  
**Evelyn La:** certo?  
**luciana:** eu posso fazer procedimento sem mesa mesmo aqui dentro do hospital sem estar vinculado ao hospital, entendeu?  
**Evelyn La:** Ah,  
**luciana:** Eu não problema de estar atendendo o plano de saúde,  
**Evelyn La:** tá.  
**luciana:** mas eu não, eu tenho que converter essa consulta do plano de saúde, eu tenho que vender numa bleferoplastia ou faço emagrecimento também, como se diz, né? Só não faço chover no deserto, doento. Então assim, eh, então não, vamos supor, ah, vem você é você não tem, você quer vir tratar comigo para fazer uma géferoplastia, não tem problema nenhum você fazer dentro do hospital, até melhor porque eu faço no centro cirúrgico do que se fizesse numa clínica.  
   
 

### 00:07:06

   
**luciana:** Então você tem toda a estrutura,  
**Evelyn La:** Uhum.  
**luciana:** né, de leitos de de um hospital que o paciente sente às vezes até mais confortável, mas seguro,  
**Evelyn La:** Entendi.  
**luciana:** né?  
**Evelyn La:** E a secretária, ela é sua? exclusivo ou é do hospital?  
**luciana:** tem secretários do hospital e tenho eu tenho uma minha  
**Evelyn La:** Ah, tá.  
**luciana:** exclusiva.  
**Evelyn La:** É porque assim, eh, o que que é a nossa proposta de método? Eh, o mínimo você precisa ter uma secretária só sua, não tem como ser secretário compartilhada.  
**luciana:** Uhum.  
**Evelyn La:** Por quê? porque ela vai precisar cumprir alguns processos dos quais a gente tem na implementação e é trabalhoso. Então a gente já inclusive uma coisa que a gente sempre fala, ó, se é a pessoa que não cumpre processo, não vai ter resultado, não tem como ter garantia, né? Pelo fato do quê?  
**luciana:** Mhm.  
**Evelyn La:** A implementação comercial, ela traz estratégias, eh, coisas que já são validadas para que, de fato, a consequência da rotina da aplicação dela é o que vai gerar o volume. Então, a importância da secretária saber como que ela faz um verdadeiro agendamento, eh, o quanto ela consegue levar esses comparecimentos e aí depois do comparecimento você ter de fato uma oferta, né?  
   
 

### 00:08:27

   
**Evelyn La:** Você saber ofertar o seu procedimento ou até mesmo eh o que que vai encaixar para aquele paciente, mas de uma maneira que você agregue valor ao que você traz. E aí a gente eleva é ticket, inclusive, né, nesse processo. E também as cadências de retorno, followups, campanhas exclusiva para trabalhar a base. Então tudo isso é a secretária que ela precisa estar mais no operacional,  
**luciana:** Entendi.  
**Evelyn La:** uma pessoa exclusiva para dar conta de fazer, porque sozinho, se,  
**luciana:** Угу.  
**Evelyn La:** por exemplo, fosse só a Luciana hoje, eh, tanto para cuidar, para atender e tudo mais, não tem como, não dá, né? Então a gente precisa e paralela a gente trabalha o tráfego pago também, mas o tráfego pago não é uma coisa que a gente foca porque não é dele que vai vir todo o volume que você precisa, é muitas vezes de pacientes que estão parados, né? Então, a gente tem várias eh fontes de captação que a gente diz, o tráfego pago é uma delas e ele vem como um auxiliar para ajudar nesse volume.  
**luciana:** Então aqui o hospital ele já tem eh mais de 30 anos. Então ele tem uma carteira,  
**Evelyn La:** Uhum.  
**luciana:** inclusive eu sempre já pedi isso para fazer, ele tem uma carteira de clientes muito grande.  
   
 

### 00:09:45

   
**luciana:** A que passa mais ou menos por mês. Eu acho que a gente deve fazer mais de 1000 atendimentos por mês,  
**Evelyn La:** Aham.  
**luciana:** muito mais uns 5.000 entre todos os médicos que trabalham aqui, né? Médico, dentistaudo. E eu sempre já tem uns 2 tr anos que eu tô pedindo para fazer o quê?  
**Evelyn La:** Certo.  
**luciana:** Mandar mala direta pros pacientes, né? ou pelo WhatsApp ou pelo e-mail, deve ter um e-mail cadastrado porque a gente tem um programa.  
**Evelyn La:** Sim. Aham.  
**luciana:** Eu nunca fui atendida relação a isso,  
**Evelyn La:** Угу.  
**luciana:** porque você conseguiria captar, né? Eh, porque tem muita assim, você vai entrar no meu Instagram, meu Instagram não tem nem 2.000 eh seguidores. Então, eu tô nova no hospital, eu tenho uns 4 anos, 4, 5 anos que eu tô no hospital. Então, tem muita gente ainda que não me conhece, né? E essa parte de estética,  
**Evelyn La:** É,  
**luciana:** né? Então assim, ela é uma parte cara, não é para qualquer público, né? Igual hoje você tá falando uma letra,  
**Evelyn La:** tá.  
**luciana:** é uma média de mais ou menos uns 5 a R$ 7.000, não é pessoa que vai conseguir pagar isso.  
   
 

### 00:10:46

   
**Evelyn La:** Uhum.  
**luciana:** E aí depois você tem que vender um toquex, então você tem que vender, todo mundo sabe que procedimento, esses procedimentos estéticos são caros. Eh, então assim, é isso que eu tenho essa dificuldade, porque eu não sei mais aonde atacar, entendeu?  
**Evelyn La:** Uhum.  
**luciana:** Eu falo  
**Evelyn La:** Hoje o Hoje o paciente que vem,  
**luciana:** não  
**Evelyn La:** ele vem direto com você ou ele passa pelo hospital primeiro pela por algum processo do hospital?  
**luciana:** ele tem, vamos supor, você vai vir consultado, então você passa primeiro numa recepção, eh, e na frente dessa recepção tem todos o tem nome de todos os médicos. E aí, eh, e às vezes, às vezes o paciente até pergunta: "Ah, eu quero um clínico geral, tem alguém que se indica". Então aí fala todos os clínicos: "Ah, eu quero uma dermatologista, tem alguém que se indica, eu tô com problema de pele, alguma coisa?" Não, tem a Dra. Luciana, alguma coisa assim, e aí eles indicam e aí esse paciente chega até mim, aí é cadastrada a consulta na recepção e esse paciente chega até mim. Então ele vai chegar normalmente ou a a maior parte das queixas chega pela parte da dermatologia clínica, não pela estética.  
**Evelyn La:** Humum, entendi. E você já tentou fazer tráfego pago antes para puxar pra  
   
 

### 00:12:13

   
**luciana:** Já ah,  
**Evelyn La:** estética?  
**luciana:** já tentei até se você quiser anotar meu Instagram para você dar uma olhada nele também.  
**Evelyn La:** Uhum.  
**luciana:** Inclusive até o até o próprio hospital ele eh inclusive tipo  
**Evelyn La:** Ah.  
**luciana:** também trabalho no pronto socorro. Inclusive até o próprio hospital era um hospital muito conceituado, é um hospital bem conceitado aqui na região, só que ele tá perdendo muito clientes mesmo,  
**Evelyn La:** Hum. Hum. É um  
**luciana:** clientes de plano, né? Porque tanto faz você ir no hospital A, B ou C pelo plano, vamos supor, você tá com a dor de cabeça, você vai no pronto socorro. Tanto faz você ir num consultório, num hospital ABC, você tem eh eh pelo plano você vai ser atendido da mesma forma,  
**Evelyn La:** Ja.  
**luciana:** você vai pagar o mesmo valor. E nisso a gente então então a gente tá perdendo. Eu já cheguei a atender, né, a gente atendia por 30 pacientes por dia no pronto socorro. Hoje a gente tá atendendo 30 por semana,  
**Evelyn La:** E você já chegou a pensar em abrir um para você?  
**luciana:** um hospital.  
**Evelyn La:** Não, um  
**luciana:** É muito caro que aqui aqui Mineiros tem clínicas excelentes de alto padrão,  
**Evelyn La:** consultório.  
**luciana:** né? Então eu gastaria, eu não tenho dinheiro para isso.  
   
 

### 00:13:27

   
**luciana:** Gastaria aí 1 milhão, sei lá, 15 milhão e nem sei quanto. Eu vou alugar,  
**Evelyn La:** Mhm.  
**luciana:** reformar, montar tudo. Então é um valor que eu não tenho esse valor. Agora tem montar só uma salinha, porque pelo menos tá eh vamos supor, eu não tenho esse paciente, mas pelo menos eu tenho outros pacientes, né? e me gera, tá me gerando ainda uma  
**Evelyn La:** Uhum. É porque aqui a gente teria um,  
**luciana:** carteira  
**Evelyn La:** como eu te falei, uma limitação referente à questão do hospital. A gente não conseguiria trabalhar a Luciana só porque ela tá vinculada ao hospital.  
**luciana:** pode porque se o paciente também, vamos supor que se você falar que você quer vir numa consulta diretamente comigo, você chega na recepção, fala: "Ó, eu quero consultar com a Dra. Luciano, eles encaminham você até meu consultório. Você cadastra lá na frente e encaminha aqui. Aí na parte, se você quiser, vamos supor, fazer uma bloplastia, aí sou eu que vendo. Você quiser fazer um botox, aí é na consulta que a gente começa a vender isso.  
**Evelyn La:** Uhum, entendi.  
**luciana:** Então assim, eu não vejo esse problema de eu continuar no hospital,  
**Evelyn La:** Угуm.  
**luciana:** pelo menos, né?  
   
 

### 00:14:40

   
**luciana:** Então, um certo ponto, o problema que eu acho daqui do hospital é que tem esses pacientes que são de baixa renda, então a gente precisa aumentar a renda os pacientes, o público do paciente do hospital ou trazer públicos de fora para me quer dizer,  
**Evelyn La:** Eh,  
**luciana:** teria que trabalhar duas vertentes, né? Aí teria que se o hospital quiser trabalhar essa captação para ele ou eh eh trabalhar essa eh eh eu trabalhar essa captação pro meu consultório específico. Meu consultório é vinculado, mas desvinculado, você  
**Evelyn La:** Uhum, entendi.  
**luciana:** entendeu?  
**Evelyn La:** Não, se você tem essa liberdade, OK, porque se fosse algo meio que alguns eh têm tem parcerias, mas é não pode ter, não pode trabalhar, é tipo advogado que não pode pegar a causa própria se tem se trabalha em algum escritório,  
**luciana:** Não, não, não.  
**Evelyn La:** sabe?  
**luciana:** Tanto é porque assim, se o paciente vê aqui, ele pagou uma consulta, ele vai fazer, vamos supor blast blas, exemplo. Você vê aqui, se é particular, você vai pagar a consulta, eu pago 20%. Então você vai pagar consulta lá em cima, eu pago 20% pro hospital. Aí você vai fazer a blefroplastia. Então aí eu vou comprar o meu horário para eu atender você lá no centro cirúrgico, comprar material, vou comprar as coisas.  
   
 

### 00:16:07

   
**luciana:** Todo o hospital tá  
**Evelyn La:** Entendi.  
**luciana:** ganhando.  
**Evelyn La:** E hoje você tá fazendo essas cirurgias eh mais eh dermatológicas que você falou, né?  
**luciana:** Isso  
**Evelyn La:** E hoje qual que é mais ou menos o seu ticket assim com o hospital aí tirando os 20%.  
**luciana:** você recebeu o meu faturamento.  
**Evelyn La:** Isso que que você mede a fatura hoje?  
**luciana:** Uns de 15 a 20.000.  
**Evelyn La:** 15 a 20\. E você pretendia alavancar quanto desse faturamento com as cirurgias particulares?  
**luciana:** Ah, pelo menos aí chega até uns 60, 70.000,  
**Evelyn La:** Uhum.  
**luciana:** né?  
**Evelyn La:** A tua secretária, ela é período integral, como que  
**luciana:** É de segunda a  
**Evelyn La:** é?  
**luciana:** sexta.  
**Evelyn La:** E aí você dessas cirurgias da face, você fala sobre blefor e tal, eh, faria também um full face assim ou só focaria Uhum.  
**luciana:** Não, pode fazer também. Fácil também. E também não faço só cirurgias da face, né? No caso, eu tiro, vamos supor, se você tiver câncer de pele no corpo, eu tiro também.  
**Evelyn La:** faz todo um agregado ali,  
**luciana:** todo todo empregado biópsia,  
   
 

### 00:17:22

   
**Evelyn La:** né?  
**luciana:** vamos supor, você tá com um dermatite atópica, eu faço a biópsia, tudo  
**Evelyn La:** Uhum,  
**luciana:** também.  
**Evelyn La:** entendi. Certo. Por que que eu te pergunto? Eh, só para eu entender de fato, ah, o teu ticket hoje, se a gente,  
**luciana:** Угуm.  
**Evelyn La:** o quanto que a gente precisaria, por exemplo, trabalhar com você para você alavancar para esses 70.000, entendeu? Se só para eu entender nesse ponto, porque aquilo que eu te falei, não adianta eu querer trazer uma proposta para você, por exemplo, que você não vai conseguir aplicar agora e só vai se frustrar e não vai conseguir chegar às vezes o que você precisa. para esse primeiro passo para depois aí dar passo os maiores, né? Então, por quê? Por que que eu te falo isso?  
**luciana:** Sim.  
**Evelyn La:** Que que é assistem digital hoje, né? Só para você entender um pouquinho agora sobre o nosso trabalho um pouquinho melhor. Nós não somos agência de tráfego pago, não somos mentoria, a gente trabalha como parceiro do cirurgião.  
**luciana:** Угуm.  
**Evelyn La:** Então, esse essa parceria ela envolve o quê? trabalhar uma uma captação e também a estruturação dos processos comerciais.  
   
 

### 00:18:41

   
**Evelyn La:** Porém, no seu caso hoje, com o cenário que você tá, Luciana, esse programa mais completo, né, essa forma de trabalho aqui que a gente tem das duas frentes, ele não faria sentido agora para ti por conta de todo o processo  
**luciana:** Entendi.  
**Evelyn La:** que a gente tem dentro do método. O que que eu te indicaria? a começar com mais básico, eh, agregando valor ao ticket que você já tem hoje. Só que eu não sei como que ficaria esse. Por exemplo, o preço ele é tabelado pelo hospital, pelo cliente que vem, o paciente que vem do hospital.  
**luciana:** Não, eu posso cobrar,  
**Evelyn La:** Você pode fazer o  
**luciana:** eu eu sou livre para usar o meu, como se diz, de uma certa forma,  
**Evelyn La:** teu.  
**luciana:** eu só Entre aspas, eu alugo aqui o espaço do hospital. Então, se eu quiser cobrar de você 50.000 para fazer uma blefer, eu posso. Se eu quiser cobrar R$ 500, eu posso  
**Evelyn La:** Ah, tá, entendi. Ótimo. Muito bom.  
**luciana:** Sì.  
**Evelyn La:** Porque aí o que acontece? Eh, hoje o, já que você tem a secretária, o melhor seria, primeira coisa, eh, criar o sua metodologia, né? criar a esteira de produtos que a gente fala que é dentro disso que a gente consegue agregar, trazer valor mais agregado ao ticket médio seu de venda, te ensinar e te passar toda a parte de construção de oferta e venda e você já focar nas primeiras com essa metodologia para depois você fazer os upgrads, porque o nosso programa mais eh full, assim, vamos dizer,  
   
 

### 00:20:23

   
**Evelyn La:** Aí você vai é necessário algum alguns ajustes na operação que pelo tamanho que você tá hoje eh a proposta ela não ia conduzer com o seu cenário, né? Precisaria eh de talvez até mais uma pessoa no comercial para poder ajudar. Então, para começar, o bom seria a gente começar com uma ativação, aonde o que que a Sistem trabalha. Eh, no ativação a gente não faz o troco pago. Então, assim, isso seria um detalhe também. Eh, se para você hoje você não tá fazendo tráfego pago e seria importante, é uma coisa que nós não entregamos no ativação.  
**luciana:** Não,  
**Evelyn La:** O ativação é para trabalhar paciência.  
**luciana:** o que eu quero, o que eu quero, eu não sei por onde, porque eu já fiz também tráfego pago e de vez em quando eu faço porque eu tenho uma pessoa que mexe e a gente também mexe aqui, eu e minha secretária, a gente mexe aqui no Instagram, gravo alguns vídeos, faço algumas coisas e a gente mesmo entrega, não sei se tá certo ou se tá errado, né?  
**Evelyn La:** Ah,  
**luciana:** Se a gente tá fazendo certo ou errado, a gente entrega alguma coisa. Então assim, só que eu não, igual eu tô te falando, eu não tô tendo retorno. Então o que eu quero,  
**Evelyn La:** Угуm.  
   
 

### 00:21:34

   
**luciana:** eu não sei, eu não sei como que eu tenho que fazer, né? Mas o que eu quero é um retorno. Por isso que eu tô eh eh tentando entrar com alguém que saiba o método que eu tenho que fazer para ter o retorno. Porque o que eu quero, eu não importo se eu vou fazer tráfego pago ou se eu vou ou se eu vou é fazer Google ou sei lá, se eu vou fazer o que que for que o que eu quero é fazer alguma coisa e que esse alguma coisa que eu fizer me dê retorno, porque eu tô cansada de pagar,  
**Evelyn La:** Uhum.  
**luciana:** de ter gasto, de pagar isso, pagar aquilo e eu continuo com os mesmos  
**Evelyn La:** M coisas.  
**luciana:** pacientes.  
**Evelyn La:** Se eu investir antes em tráfego, pago na média de quanto por  
**luciana:** Nossa, eu já investi muito dinheiro com uma com uma empresa aí,  
**Evelyn La:** mês?  
**luciana:** mas assim, igual uma vez eu coloquei, eu fui fazer um procedimento, um laser,  
**Evelyn La:** Uhum.  
**luciana:** eu investi R$ 500, de R$ 500 ou R$ 1.000 antes do laser, que eu investi bastante para eh tentar arrumar mais pacientes para poder impulsionar, né? Eh, não veio um paciente pelo veio paciente do laser, mas não pelo tráfego pago.  
**Evelyn La:** E você chegou a fazer com agência esse daí ou você mesmo fez?  
   
 

### 00:22:51

   
**luciana:** Foi a menina que mexe com o meu Instagram, né? Já cheguei a fazer com a agência também que mexe com o Instagram aqui do hospital também já fizeram.  
**Evelyn La:** Tá.  
**luciana:** Aí eu gastei um dinheirão e nada de retorno.  
**Evelyn La:** Uhum. Entendi. É, eu diria que para esse começo, eh, seria uma ativação realmente que encaixaria para quê? pra gente poder agregar valor, você vender mais caro o que você já tem com paciente que já chega para você, porque é daí que você vai ter o seu reinvestimento para depois você começar fazer outros passinhos, sabe? eh, pelo fato de você já ter feito investimento, já, né, ter tido essa frustração, querendo ou não, aí com agências, eh, antes mesmo de você iniciar um tráfego pago, a gente, nós, por exemplo, aqui, quando a gente faz o tráfego pago por acelerado, a gente faz todo um mapeamento antes, a gente faz todo um uma estratégia realmente comercial dentro do estrutura e da esteira de produto dessa pessoa, porque é aí que vai ficar mais assertivo. você só impulsionar e você só fazer campanha aleatória assim no sentido de tentar vender o produto isolado, você não consegue mesmo. E é d mais os gargalos, porque aí chega lead, mas são desqualificados, a uma grande maioria, né?  
   
 

### 00:24:16

   
**luciana:** Mhm.  
**Evelyn La:** E aí no produto de ativação que a gente tem nesse programa de ativação, a gente faz o quê? Eh, é, é o start primeiro para você eh entender, construir a oferta e o quem chegar, quem sentar na frente, na cadeira da Luciana, a Luciana precisa  
**luciana:** É, na realidade assim,  
**Evelyn La:** converter.  
**luciana:** tanto eu quanto acho que a minha secretária, ela precisa eh ser treinada para vender e fazer o pós-venda  
**Evelyn La:** Uhum.  
**luciana:** também.  
**Evelyn La:** Isso.  
**luciana:** Eu preciso fazer cursos de de vendas e ela  
**Evelyn La:** Esse é o Aham.  
**luciana:** também.  
**Evelyn La:** Exatamente. Eh, esse ativação é justamente para primeiro, a gente fala assim, primeiro você organiza a casa interna para depois a gente começar a trazer mais visitas, que não adianta de nada eu querer lotar a agenda da Luciana hoje, se a o gargalo ali no pré-vendas ele não tá corrigido. Se eu gargalo na venda, não tá corrigido, porque pode vir 10, 15, 20,  
**luciana:** อ  
**Evelyn La:** 30 pessoas qualificadas e ainda assim não gerar venda. Então, primeiro eu preciso organizar isso, treinar e refinar essa parte, né? ter essa a metodologia, apresentação de vendas e dos próprios que você já tem, a gente agrega o seu ticket para você vender mais caro, tem uma lucratividade um pouquinho maior e aí depois sim, aí a gente tá falando de um upgrade para alotar a agenda, mas aí você já tem a casa organizada, sabe?  
   
 

### 00:25:55

   
**luciana:** E e isso? O que que vocês eh então eh se organizar essa casa, você estaria me vendendo o quê? Você estaria me proporcionando o  
**Evelyn La:** A organização aqui,  
**luciana:** quê?  
**Evelyn La:** o programa de ativação, ele foca em te trazer as primeiras vendas de valor de ticket já agregado. Ou seja, por exemplo,  
**luciana:** Eli  
**Evelyn La:** hoje você cobra 5.000 numa blefaro. Como vender, como criar uma oferta para você vender essa mesma bleo por 7,5, por exemplo?  
**luciana:** vendendo por cinco, pelo menos três por mês, eu já fico feliz.  
**Evelyn La:** já.  
**luciana:** Já vai ser muita coisa.  
**Evelyn La:** Aham. Porque assim, a ideia desse ativação é você estruturar sua esteira de produtos, trazer essa clareza e agregar esse ticket já para que você possa fazer as primeiras vendas. Mas você precisa ter pacientes chegando,  
**luciana:** Então, né? Porque assim,  
**Evelyn La:** entendeu?  
**luciana:** porque não adianta nada também eu tentar me organizar aqui a casa e ter nada de pacientinho  
**Evelyn La:** Você não ter paciente,  
**luciana:** para esse que é o detalhe.  
**Evelyn La:** é esse que é o detalhe.  
**luciana:** Então eu preciso, claro que eu vamos supor, eu organizo a casa e pelo menos um pouquinho de pelo menos dois pacientes do primeiro mês, pelo menos três no segundo mês, né?  
   
 

### 00:27:18

   
**luciana:** E começar a agregar, porque se eu só organizar a casa e aí não chega nada, aí também fica frustrado,  
**Evelyn La:** Exatamente.  
**luciana:** né? Porque não adianta que que assim, o meu consultório, ele é um consultório bonito, ele é um consultório e aqui do hospital um dos consultórios mais bonitos,  
**Evelyn La:** É.  
**luciana:** é um consultório diferenciado. Eh, então assim, eh, sabe quanto eu sinto que eu tô chegando, quase chegando, mas eu tô nadando, andando, andando, morrendo na praia. Então eu preciso,  
**Evelyn La:** Mm.  
**luciana:** eu concordo com você que eu preciso organizar melhor, me estruturar melhor, tanto curso de venda, curso de oratório, eh eh minha secretária também, tá? a relação, né, tanto na venda quanto na pós-venda, que a pós-venda ficaria mais com ela. Então assim, a gente precisa melhorar nessa parte, mas não adianta a gente vender se não tem  
**Evelyn La:** Hoje os pacientes que vocês têm eh os pacientes que  
**luciana:** paciente.  
**Evelyn La:** vocês têm relacionado à base, a base que já vem do hospital, Você conseguiria vender, por exemplo, blefor para esses pacientes agregar ou não?  
**luciana:** Menos de 1%.  
**Evelyn La:** Hum. Aí é um, aí é um problema.  
**luciana:** Esse que é o problema.  
   
 

### 00:28:36

   
**luciana:** Menos de 1%. É que o negócio baixa rindo. É porque aqui tudo a maioria dos pacientes que vem aqui tudo é CLT.  
**Evelyn La:** Não  
**luciana:** ganha dois, três salários por mês.  
**Evelyn La:** entendo,  
**luciana:** Quem ganha três é muito aí.  
**Evelyn La:** sabe? Porque assim, ó, é esse seria um problema, porque assim, o mesmo ativação, a gente precisaria de pacientes que você conseguisse vender. Não adianta a gente treinar a venda, que nem você falou, você ficar boa na venda, tua secretária ficar ótima no pós-venda, num pré pré-agendamento, mas você não conseguiu o paciente adequado para aquilo.  
**luciana:** Ой.  
**Evelyn La:** E aí o que seria? seria um programa de aceleração que a gente teria o tráfego pago incluso para ajudar nessa captação. Porém, o aceleração hoje eu penso que para pro cenário que você tá no sentido de estrutura mesmo, sabe? Só uma secretária, eh, ele ficaria arriscado, porque assim, eu não tenho como te dar garantia de retorno, sabe? Tipo, ah, Luciana, eu vou te dar certeza que nesse primeiro mês você vai conseguir fazer R$ 100.000. Pode ser que aconteça. Já a gente tem cases aqui no no nosso sistema que eh fez 100.000 em uma semana, fez 100.000 em um mês, fez 100.000 depois de 2 meses.  
   
 

### 00:30:01

   
**Evelyn La:** Mas eu não posso dar essa garantia paraa Luciana, não tem como. Até mesmo porque eu vou precisar que a sua secretária ela cumpra todos os processos ali, né? execute de forma eh constante a nossa metodologia, porque é daí que vai trabalhar principalmente a parte de de pacientes base.  
**luciana:** อ  
**Evelyn La:** Só que como a sua base ela é uma base fraca, vamos dizer assim, por conta do ticket de de renda mesmo dos seus pacientes, essa estratégia não funcionaria, porque se a base é fraca,  
**luciana:** Então a gente, então a gente vai ter que ver, pensar, talvez até fazer uma outra reunião. dê uma olhada no meu Instagram, pesquise um pouco em relação à cidade também e a gente pensar em alguma coisa e ver preço também, né? Porque também eu não não tenho condições agora de pagar alguma coisa muito valor muito alto.  
**Evelyn La:** Sim, claro. É justamente eh pelo fato de você dar conta do teu cenário, da sua estrutura, o ticket que hoje você tá tendo referente ao hospital, eh não faz sentido eu querer te trazer uma proposta que vai ser inviável. Você não vai conseguir executar, não vai conseguir, né? Não, não, não vale a pena nem para você e nem para nós, porque a gente quer que você evolua, né, dentro do da nossa jornada juntos ali. Não que você gere o ROY garantido, né, de faturamento aí de de alavancagem de faturamento.  
   
 

### 00:31:41

   
**Evelyn La:** Então, é uma das coisas só que eu assim eh eh eu gosto, eu sou bem transparente, né? fal nas as nas,  
**luciana:** Não tem e precisa ter porque não adianta,  
**Evelyn La:** né?  
**luciana:** né?  
**Evelyn La:** Você já investiu, sabe? É, é muito frustrante isso para para alguém que já vem aí de histórico,  
**luciana:** Eu  
**Evelyn La:** de investimento, sem retorno, isso vai, vai gerando eh até um desânimo no sentido de não acreditar mais  
**luciana:** não sei. E também assim,  
**Evelyn La:** que  
**luciana:** o que eu fico preocupada também assim, o o hospital caiu demais o o o número de pacientes.  
**Evelyn La:** sério. Que que tu acha que tá  
**luciana:** Não sei se é crise,  
**Evelyn La:** acontecendo?  
**luciana:** eu não sei o que que é. Inclusive eu até vou eu eu tem formava filoso de quarteirões aqui para porque não cabia todo mundo na recepção. Hoje é que abre 7 horas, né? Então quando é 6 6:30 o pessoal começa a chegar, né, para pegar o mais cedo, formava filas. Eh, e hoje praticamente quase você chega, passa aqui em 37 horas, não tem ninguém.  
**Evelyn La:** Meu Deus, mulher, que estranho,  
**luciana:** muito estranho. Então assim,  
**Evelyn La:** né?  
   
 

### 00:33:00

   
**luciana:** também é preocupante em relação a isso. Igual eu te falei, socorro, antes eu chegava a atender, em 24 horas eu cheguei 30, 40 pacientes em um dia. Hoje numa semana você tá atendendo 30\. Aí falou assim: "Ah, mas é a crise, tudo bem, é a crise". Mas no outro, no outro hospital que a gente tem enfermeiras que trabalham em outros hospitais, só à noite ela atende, atende 30 pacientes no período da noite que ela fica nos outros hospitais.  
**Evelyn La:** Pois é, até nisso a acabaria influenciando no sentido de eh por mais que a gente fosse tentar fazer qualquer trabalho de de base para você não precisar investir tanto em tráfego, por exemplo, seria um impasse,  
**luciana:** É isso.  
**Evelyn La:** sabe?  
**luciana:** É. E assim, e aí os diretores aqui do hospital é um pouco, eles são um pouco e eh difíceis no sentido assim que eles não gostam muito porque já viveram várias crises, né, tudo tal, então assim, ah, vai melhorar, então, e aí fica, sabe que o hospital também é complicado você tá eh eh fazendo uma uma divulgação, né? tem toda aquela  
**Evelyn La:** Eh, Eh,  
**luciana:** legislação,  
**Evelyn La:** exatamente. Questão divulgação, posicionamento, aí seria bem complexo, complexo  
   
 

### 00:34:21

   
**luciana:** é, já é um pouco mais complicado em relação a isso,  
**Evelyn La:** assim.  
**luciana:** mas eu acho que se tem alguém ganhando dinheiro, tem que ganhar também. Eu não sou diferente de ninguém.  
**Evelyn La:** E os outros outros profissionais, como é que é? E os outros profissionais aí no hospital,  
**luciana:** Ó,  
**Evelyn La:** tudo meio que o mesmo cenário que o seu, assim, nesse  
**luciana:** não tem dois, três médicos que já estão mais de 30 anos aqui no hospital e consegue que tem uma carteira bem grande, mas caiu um pouco também. E tem alguns médicos que mais ou menos do mesmo jeito,  
**Evelyn La:** Entendi. Não.  
**luciana:** né? Mas assim e e eu tô percebendo igual assim,  
**Evelyn La:** No.  
**luciana:** eu já cheguei a trabalhar muito aqui no hospital, já cheguei a atender, tipo assim, mais de 20 pacientes por dia, não só no pronto socorro, incluso do meu consultório, mas pronto socorro. Então assim, e eu percebo que tá caindo muito movimento e não cai só o meu movimento, cai o movimento de todo mundo.  
**Evelyn La:** de todo mundo.  
**luciana:** O médico que fazer aí 100,  
**Evelyn La:** É,  
**luciana:** 120.000 por mês, tá fazendo 50, 60\.  
**Evelyn La:** nossa, caiu muito, hein.  
   
 

### 00:35:31

   
**Evelyn La:** Ai, que que eu vou te falar? Porque assim, ó,  
**luciana:** Tai  
**Evelyn La:** do que eu tenho hoje no meu ecossistema, eh, o programa mais completo que teria o tráfego pago para poder te ajudar, ele ficaria muito fora da tua realidade hoje. Te confesso, não faria sentido. Agora o de ativação,  
**luciana:** quanto, mas em relação ao dinheiro.  
**Evelyn La:** o de aceleração,  
**luciana:** Uhum.  
**Evelyn La:** o aceleração ele tá na faixa de 70.000 hoje.  
**luciana:** Nossa Senhora.  
**Evelyn La:** Exato.  
**luciana:** Bem forte.  
**Evelyn La:** Uhum.  
**luciana:** Não tem condições de jeito  
**Evelyn La:** É, não, não faria sentido para você.  
**luciana:** nenhum.  
**Evelyn La:** Até mesmo porque assim, para um programa desse, eu precisaria uma outra estrutura sua e para te trazer realmente  
**luciana:** Uhum.  
**Evelyn La:** uma previsibilidade de, por exemplo, ó, você vai ter o ROI de retorno do teu investimento no pelo menos em um mês. Então assim, não faria sentido hoje. Eh, o nosso programa que fica em intermediário para você,  
**luciana:** อ  
**Evelyn La:** que seria uma ativação, ele teria um outro impasse, porque os clientes não chegam até você. E aí a gente não tem o trabalho de tráfego pago, você teria que fazer esse trabalho com alguém, então você já teria mais um custo pela por essa questão.  
   
 

### 00:36:46

   
**Evelyn La:** Ja.  
**luciana:** E também além de fazer o trabalho, o tráfego pago, é saber se vai fazer o o tráfego pago bem feito, porque não adianta você só pagar e ir lá pegar, porque para fazer o tráfego pago, eu gravo um vídeo e coloco R$ 100 no no Instagram e rodo uma semana, né? Que o que eu faço é assim.  
**Evelyn La:** Uhum. Eh, o tráfego pago teria que fazer um uma estratégia mesmo ali, eh, linkar, primeira coisa, trabalhar teu posicionamento, linkar um cliente de ideal para que você atingir, fazer um mapeamento disso para daí montar a estratégia, aí vai ser mais assertivo.  
**luciana:** É, mas aí não tem ninguém que faça, né? Então assim, então eu simplesmente gravo um vídeo e vou lá, posto no Instagram e pago,  
**Evelyn La:** Uhum. Porque quando você faz só impulsionamento,  
**luciana:** que não é assim,  
**Evelyn La:** você acaba atraindo mais desqualificado do que qualificado. Então, eh, a importância de fazer uma coisa,  
**luciana:** Так.  
**Evelyn La:** né, com estratégia é por conta disso, mas eu é como você falou, é achar aí alguém que vá fazer. Então, a gente teria esse impasse também. Aí não adianta nada eu querer te trazer e falar: "Ó, Luciana, vamos fazer uma ativação, vamos construir uma esteira, vamos elevar o seu ticket, se você não vai ter para quem vender?" Não faz sentido.  
   
 

### 00:38:15

   
**luciana:** Eh,  
**Evelyn La:** E hoje o outro produto que eu teria, que talvez te ajudaria mais na venda, é a nossa mentoria, que são aulas gravadas, mas ele vai trabalhar só a venda, não vai resolver teu problema da mesma forma.  
**luciana:** E esse essa mentoria ficaria quanto mais ou menos?  
**Evelyn La:** Essa daí ela fica, deixa eu abrir aqui minha tabela. Hum. Deixa eu só ver aqui. Oxe, ela vai dar mais ou menos 550 por mês. Vai dar uns 6000 e pouquinho.  
**luciana:** Bem carinho também.  
**Evelyn La:** E só e assim, ela vai trabalhar só a questão da venda e protocolos de caixa para quem tem base boa. É outro ponto. Eu não nem te recomendaria você comprar nem esse inclusive. Por quê? Porque a estratégia que a gente tem para gerar caixa de base de paciente, esse paciente ele tem que ser um paciente bom também. E aí não adianta não falar assim: "Ah, Luciana, compra, vai lá que não sei o quê, aplica o protocolo que vai dar certo". Porque não vai, porque você já me falou que o teu lead, o paciente que você tem de base hoje, que é os que você atendeu, que poderia, a gente poderia tentar ativá-los, eles não têm condição de te pagar o que você precisa,  
   
 

### 00:40:18

   
**luciana:** É,  
**Evelyn La:** entendeu?  
**luciana:** não tem.  
**Evelyn La:** Então assim, ai amada, eu eu não vou não vou te empurrar nada não, viu? Porque eu não sou desse tipo de pessoa,  
**luciana:** Não tá  
**Evelyn La:** tá? Eh,  
**luciana:** certo.  
**Evelyn La:** não vejo assim que a gente conseguiria te ajudar hoje no cenário que você tá, não tá? Porque assim,  
**luciana:** Entendi.  
**Evelyn La:** nós não somos uma agência de tráfego pago, né? Se fosse só agência, se a gente tivesse só o serviço do tráfego  
**luciana:** E se a gente, e se a gente começar, porque eu teria, e se a gente, se eu tentar conversar com os diretores aqui do hospital para ver que de  
**Evelyn La:** p,  
**luciana:** estruturar primeiro o hospital, com isso a gente fazer um estruturamento. Aí vocês trabalham com hospitais também?  
**Evelyn La:** tem um tem um médico que a gente atende hoje que ele Ele tem uma estrutura que é como se fosse um mini hospital, tá?  
**luciana:** Uhum.  
**Evelyn La:** E aí ele tem assim vários profissionais com ele. Tem um no nosso ecossistema que a gente tá atendendo hoje.  
**luciana:** Entendi.  
**Evelyn La:** Talvez seria uma uma possibilidade sim, viu?  
**luciana:** A, eu vou ver, eu vou conversar com eles aqui.  
**Evelyn La:** É.  
   
 

### 00:41:32

   
**luciana:** Qualquer coisa eu passo contato e aí vocês marcam uma reunião, alguma coisa para ver que que são as, porque aqui a gente é tipo uma cooperativa, né? Então, cada médico tem um uma eh sócio,  
**Evelyn La:** Ага.  
**luciana:** né? Então você tem uma para ter um gasto desse também, porque teria que entrar com tudo e só que aí aqui tem muito funcionário, né? E aí teria que fazer um treinamento com todos esses  
**Evelyn La:** Pois é.  
**luciana:** funcionários.  
**Evelyn La:** É, eu penso que hoje talvez para você seria o fato de você conseguir achar uma agência boa para você começar a tentar vender eh as os seus procedimentos particulares para ir depois  
**luciana:** Aí eu  
**Evelyn La:** você ir estruturando, né?  
**luciana:** vouar.  
**Evelyn La:** Mas agora fazer pelo menos umas vendas aí dos particulares, porque com o que você tá tendo do hospital, realmente não é,  
**luciana:** É, tá difícil.  
**Evelyn La:** não, não te sobra para tu nem reinvestir, né, no teu próprio,  
**luciana:** Угу.  
**Evelyn La:** né, no teu próprio, no teus próprios ganhos, vamos dizer assim. Eh, eh, é, fica, fica difícil mesmo. E você fica querendo não meio que amarrada, né? É. Daí não não vou daí. É o que eu te falei, não vou te não vou te Eu falo assim, eu não iludo,  
**luciana:** Não, com certeza não. Mas então tá,  
**Evelyn La:** eu não tá bom,  
**luciana:** deixa eu ir atender ali um paciente então.  
**Evelyn La:** tá bom. Qualquer coisa,  
**luciana:** Então  
**Evelyn La:** eh,  
**luciana:** tá.  
**Evelyn La:** eu te te dei uma pincelada um pouco sobre as os nossos os nossos treinamentos e tudo mais.  
   
 

### A transcrição foi encerrada após 00:43:45

*Esta transcrição editável foi gerada por computador e pode conter erros. As pessoas também podem alterar o texto depois que ele for criado.*', '# AUDITORIA DE CALL — Evelyn La x Dra. Luciana Dias
**Data:** 16 de março de 2026 | **Duração:** 43 min | **Resultado:** Não fechamento - lead desqualificado pelo closer

---

## 1. RESUMO EXECUTIVO

Call extremamente fraca com múltiplas violações do protocolo. Evelyn perdeu controle logo no início, permitiu que lead atendesse paciente durante call, não seguiu framework estruturado e desqualificou lead sem explorar alternativas. Lead demonstrava interesse real e orçamento (R$ 15-20k faturamento atual), mas closer focou em problemas ao invés de soluções. Ausência total de diagnóstico quantitativo, perguntas de consequência e isolamento de objeções. Call virou conversa informal sobre limitações ao invés de processo comercial estruturado. Score baixíssimo reflete execução amadora que desperdiçou oportunidade comercial clara.

---

## 2. SCORECARD

| # | Dimensão | Peso | Nota | Ponderada | Evidência |
|---|---|---|---|---|---|
| 1 | Frame e Liderança | 8% | 2,0 | 0,16 | Permitiu interrupção aos 1:49, sem agenda definida |
| 2 | Qualificação Preliminar | 10% | 1,0 | 0,10 | Budget estimado indiretamente, decisor não confirmado |
| 3 | Diagnóstico Quantitativo | 12% | 0,5 | 0,06 | Apenas faturamento mencionado (15-20k), métricas ausentes |
| 4 | Diagnóstico Qualitativo | 8% | 4,0 | 0,32 | Lead verbalizou frustrações, mas sem aprofundamento |
| 5 | Perguntas de Consequência | 10% | 0,0 | 0,00 | Nenhuma pergunta NEPQ realizada |
| 6 | Ensino Comercial | 5% | 2,0 | 0,10 | Mencionou diferença entre tráfego e processo comercial |
| 7 | Reframe de Identidade | 5% | 0,0 | 0,00 | Não trabalhou identidade/crença do lead |
| 8 | Ancoragem de Valor | 10% | 1,0 | 0,10 | Preço mencionado (R$ 70k) sem value stack |
| 9 | Isolamento de Objeção | 10% | 0,0 | 0,00 | Não isolou objeções, aceitou "sem condições" |
| 10 | Proporção de Fala | 8% | 3,0 | 0,24 | Lead falou ~60%, mas sem direcionamento |
| 11 | Segurança de Promessas | 8% | 7,0 | 0,56 | Não fez promessas perigosas, foi conservadora |
| 12 | Checkpoints | 3% | 1,0 | 0,03 | Checkpoints inexistentes |
| 13 | Controle e Fechamento | 3% | 0,0 | 0,00 | Desqualificou sem tentar fechar |

**SCORE FINAL: 1,67/10 — CALL FRACA**

---

## 3. ANÁLISE BLOCO A BLOCO

### [00:00-02:00] — Abertura Caótica | Fase 1
**O que aconteceu:** Call iniciou com problemas técnicos, lead atendeu emergência médica e closer perdeu controle total. Lead perguntou diretamente sobre entrega de pacientes sem passar por diagnóstico.
**Frameworks aplicados:** Nenhum
**Frameworks ausentes:** Frame inicial, três intenções, agenda, controle
**Pontos fortes:** Nenhum identificado
**Erros:** [ALTA] Permitir interrupção da call, [ALTA] não estabelecer frame de autoridade
**Veredicto do bloco:** 1/10

### [02:00-08:30] — Tentativa de Diagnóstico | Fase 2
**O que aconteceu:** Lead explicou atuação (dermatologia + estética), estrutura hospitalar, faturamento 15-20k. Closer mencionou necessidade de secretária exclusiva.
**Frameworks aplicados:** Fragmentos de diagnóstico situacional
**Frameworks ausentes:** SPIN estruturado, métricas quantitativas, perguntas de problema
**Pontos fortes:** Lead forneceu informações relevantes espontaneamente
**Erros:** [MÉDIA] Não aprofundar métricas, [BAIXA] não mapear processo comercial atual
**Veredicto do bloco:** 4/10

### [08:30-18:00] — Conversa sobre Limitações | Fase 2 continuação
**O que aconteceu:** Lead detalhou tentativas frustradas com tráfego pago, closer focou em limitações da estrutura hospitalar ao invés de explorar oportunidades.
**Frameworks aplicados:** Nenhum framework estruturado
**Frameworks ausentes:** Perguntas de consequência, social proof, ensino comercial
**Pontos fortes:** Lead demonstrou histórico de investimento e interesse
**Erros:** [ALTA] Focar em problemas sem explorar soluções
**Veredicto do bloco:** 3/10

### [18:00-35:00] — Apresentação Prematura e Desqualificação | Fases 3-5 ausentes
**O que aconteceu:** Closer apresentou produtos (ativação R$ 70k, mentoria R$ 6k) sem diagnóstico completo, desqualificou lead baseado em suposições.
**Frameworks aplicados:** Apresentação básica de produtos
**Frameworks ausentes:** NEPQ, isolamento de objeções, ancoragem de valor, reframe
**Pontos fortes:** Não iludiu o lead com promessas falsas
**Erros:** [ALTA] Apresentar preço sem valor, [ALTA] desqualificar sem explorar alternativas
**Veredicto do bloco:** 2/10

### [35:00-43:45] — Encerramento Sem Fechamento | Fase 6 ausente
**O que aconteceu:** Conversa informal sobre possibilidade de trabalhar com hospital, closer sugeriu procurar agência, call terminou sem próximos passos.
**Frameworks aplicados:** Nenhum
**Frameworks ausentes:** Tentativa de fechamento, isolamento de objeções, próximos passos
**Pontos fortes:** Manteve relacionamento cordial
**Erros:** [ALTA] Não tentar nenhum fechamento ou alternativa
**Veredicto do bloco:** 1/10

---

## 4. MAPA DE FRAMEWORKS

| Framework | Presença (0-10) | Onde aplicou | Onde faltou | Impacto |
|---|---|---|---|---|
| Hormozi (CLOSER) | 1/10 | - | Todo protocolo ausente | Crítico - sem estrutura |
| Miner (NEPQ) | 0/10 | - | 15:00-25:00 era momento ideal | Crítico - sem consequência |
| Belfort (Straight Line) | 1/10 | - | Controle perdido desde início | Crítico - sem liderança |
| Cole Gordon | 2/10 | Frame superficial 2:00 | Diagnóstico/pitch estruturado | Alto - sem metodologia |
| Eli Wilde | 0/10 | - | Reframe necessário 25:00-30:00 | Alto - sem mudança identidade |
| Dan Lok | 2/10 | Postura médica 31:00 | Qualificação estruturada | Alto - sem autoridade |
| Rackham (SPIN) | 3/10 | Situação 5:00-8:00 | Problema/Implicação/Necessidade | Alto - diagnóstico incompleto |
| Challenger Sale | 2/10 | Diferenciação tráfego 4:00 | Insight disruptivo | Médio - sem ensino |
| Sabri Suby | 1/10 | - | Oferta irrecusável | Alto - sem ancoragem |
| Brad Lea | 0/10 | - | Antecipação objeções | Médio - reativo às objeções |

---

## 5. TOP 5 ACERTOS
1. **Transparência sobre limitações** — 31:00-32:00 — "não vou te empurrar nada" manteve ética comercial aplicando Dan Lok de não ser vendedor pedinte
2. **Coleta de informações básicas** — 5:00-7:00 — Obteve faturamento atual (15-20k) e objetivo (60-70k) seguindo fragmentos de SPIN Selling
3. **Identificação de estrutura** — 7:00-8:00 — Confirmou secretária exclusiva aplicando requisitos operacionais do método
4. **Diferenciação da concorrência** — 4:00-4:30 — Explicou diferença entre tráfego pago e processo comercial usando Challenger Sale básico
5. **Manutenção do relacionamento** — 41:00-42:00 — Sugeriu alternativa (trabalhar com hospital) mantendo porta aberta para futuro

---

## 6. TOP 5 ERROS (por gravidade)
1. **[GRAVIDADE ALTA] Perda total de controle** — 1:49 — Permitiu que lead atendesse paciente durante call. DEVERIA: "Entendo a urgência, mas nossa agenda é importante. Prefere remarcar ou consegue 5 minutos para definirmos se vale prosseguir?"
2. **[GRAVIDADE ALTA] Ausência de NEPQ** — 15:00-25:00 — Não fez perguntas de consequência quando lead verbalizou frustrações. DEVERIA: "Se nos próximos 12 meses nada mudar, o que acontece com esses 15-20k que você está faturando?"
3. **[GRAVIDADE ALTA] Desqualificação prematura** — 30:00-31:00 — Desqualificou sem explorar alternativas ou parcelamento. DEVERIA: "Isolando o fator financeiro, se a condição fizesse sentido, você estaria conosco hoje?"
4. **[GRAVIDADE MÉDIA-ALTA] Diagnóstico quantitativo incompleto** — 8:00-15:00 — Não coletou métricas essenciais. DEVERIA: "Quantos pacientes você atende por mês? Qual seu ticket médio? Taxa de conversão atual?"
5. **[GRAVIDADE MÉDIA-ALTA] Apresentação sem ancoragem** — 35:30 — Falou "R$ 70.000" sem value stack. DEVERIA: "Para chegar nos seus 60-70k de meta, o investimento seria X, mas primeiro deixa eu mostrar o valor que isso representa..."

---

## 7. REESCRITA DE MOMENTOS CRÍTICOS

### Momento 1: 01:49 — Interrupção para atendimento
**O QUE FOI DITO:** "Ah, você vai ter que me dar 10 minutos. Eu tenho que atender um paciente."
**O QUE DEVERIA TER SIDO DITO:** "Dra. Luciana, entendo que é uma emergência. Nossa conversa é importante para definir se posso te ajudar a sair dos 15k atuais para os 60-70k que você quer. Prefere que eu aguarde 10 minutos ou reagendamos para um momento que você tenha 100% de foco? Porque o que vamos conversar pode mudar seu cenário financeiro."
**POR QUÊ:** Jordan Belfort - manter controle da call + Alex Hormozi - clarificar valor da conversa
**IMPACTO ESTIMADO:** Manteria autoridade e reforçaria importância da call

### Momento 2: 16:30 — Meta de 60-70k revelada
**O QUE FOI DITO:** "Ah, pelo menos aí chega até uns 60, 70.000, né?"
**O QUE DEVERIA TER SIDO DITO:** "60-70k é uma meta importante. Me conta uma coisa: o que essa diferença de 45-55k a mais por mês representaria para você? Para sua família? Para sua segurança financeira? E se em 12 meses você continuar nos 15-20k atuais, como você se sentiria?"
**POR QUÊ:** Jeremy Miner NEPQ - transformar número em emoção e consequência
**IMPACTO ESTIMADO:** Criaria urgência emocional e justificaria investimento

### Momento 3: 28:36 — Lead revela conversão de "menos de 1%"
**O QUE FOI DITO:** "Menos de 1%. Esse que é o problema."
**O QUE DEVERIA TER SIDO DITO:** "Menos de 1% é exatamente onde vejo oportunidade. Dra., vou te ensinar algo que vai mudar sua perspectiva: o problema não é a classe social dos seus pacientes. É que você está tentando vender procedimento isolado. Se eu te mostrasse como transformar consulta de R$ 50 em procedimento de R$ 5.000 usando os mesmos pacientes, mudaria tudo, não é?"
**POR QUÊ:** Challenger Sale - ensino comercial que muda perspectiva
**IMPACTO ESTIMADO:** Reframe total do problema e posicionamento como solução

### Momento 4: 35:38 — Apresentação do preço R$ 70.000
**O QUE FOI DITO:** "o aceleração ele tá na faixa de 70.000 hoje."
**O QUE DEVERIA TER SIDO DITO:** "Antes de falar investimento, deixa eu mostrar o que isso representa: você quer ir de 20k para 70k mensais, certo? São 50k a mais por mês. Em 6 meses, são 300k adicionais. O programa que te levaria lá tem investimento de 70k. Ou seja, você investiria o equivalente a 1,4 meses do seu objetivo para ter os outros 58,6 meses. Faz sentido esse raciocínio?"
**POR QUÊ:** Alex Hormozi - Value Equation + ancoragem de ROI
**IMPACTO ESTIMADO:** Transformaria "caro" em "investimento inteligente"

### Momento 5: 31:00 — Desqualificação final
**O QUE FOI DITO:** "não vejo assim que a gente conseguiria te ajudar hoje no cenário que você tá"
**O QUE DEVERIA TER SIDO DITO:** "Dra. Luciana, isolando a questão financeira por um momento: se eu trouxesse uma proposta que coubesse no seu orçamento atual e ainda assim te ajudasse a chegar nos 60-70k, você toparia trabalhar comigo? Porque tenho uma ideia que pode funcionar para o seu cenário específico..."
**POR QUÊ:** Cole Gordon - isolamento de objeção + criação de alternativa
**IMPACTO ESTIMADO:** Manteria oportunidade viva e exploraria soluções criativas

---

## 8. PLANO DE AÇÃO

### Recomendação 1: Implementar Frame de Autoridade Obrigatório
- **O que fazer:** Primeiros 3 minutos sempre com agenda, três intenções e pacto de "sim ou não"
- **Por quê:** Call sem frame vira conversa informal sem direção comercial
- **Como treinar:** Role-play obrigatório de abertura até executar automaticamente
- **Prioridade:** ALTA

### Recomendação 2: Nunca pular diagnóstico quantitativo
- **O que fazer:** Lista obrigatória de 10 métricas antes de qualquer apresentação
- **Por quê:** Sem números não há como calcular ROI nem justificar investimento
- **Como treinar:** Checklist visual durante calls até memorizar sequência
- **Prioridade:** ALTA

### Recomendação 3: Dominar perguntas NEPQ de consequência
- **O que fazer:** Sempre perguntar "o que acontece se nada mudar em 12 meses?"
- **Por quê:** Sem dor emocional, lead não compra solução cara
- **Como treinar:** Praticar variações da pergunta até soar natural
- **Prioridade:** ALTA

### Recomendação 4: Criar alternativas antes de desqualificar
- **O que fazer:** Sempre testar 3 formatos diferentes antes de desistir
- **Por quê:** Esta call tinha lead real com orçamento e necessidade clara
- **Como treinar:** Lista de 5 alternativas para diferentes cenários
- **Prioridade:** MÉDIA

### Recomendação 5: Aprender ancoragem de valor obrigatória
- **O que fazer:** Nunca falar preço sem antes empilhar valor e calcular ROI
- **Por quê:** R$ 70k sem contexto parece caro; com ROI calculado vira investimento
- **Como treinar:** Script de ancoragem memorizado e praticado
- **Prioridade:** ALTA

### Recomendação 6: Implementar ensino comercial (Challenger)
- **O que fazer:** Preparar 3-5 insights disruptivos para cada objeção comum
- **Por quê:** Lead precisa aprender algo novo para mudar perspectiva
- **Como treinar:** Banco de insights organizados por tipo de objeção
- **Prioridade:** MÉDIA

### Recomendação 7: Treinar isolamento de objeções
- **O que fazer:** "Isolando o fator X, você fecharia hoje?" antes de qualquer negociação
- **Por quê:** Objeções não isoladas viram conversas circulares infinitas
- **Como treinar:** Role-play com todas variações possíveis
- **Prioridade:** ALTA

---

## 9. ALERTAS DE PROMESSA
**Nenhuma promessa perigosa identificada.** Closer foi conservadora demais, mas não fez promessas infladas. Ponto positivo da call.

---

## 10. ANÁLISE DE SENTIMENTO DO LEAD

### Sentimento Geral
- **Sentimento:** Misto (positivo inicial → frustrado → resignado)
- **Score de Sentimento:** 0.2 (levemente positivo, mas com frustração crescente)
- **Nível de Engajamento:** Médio-Alto (lead participativo e detalhista)

### Timeline de Sentimento
| Trecho | Sentimento | Confiança (0-1) | Momento-Chave |
|--------|-----------|-----------------|---------------|
| 00:00-05:00 | neutro | 0.9 | Problemas técnicos, foco na emergência |
| 05:00-15:00 | positivo | 0.8 | Engajamento ativo, compartilhando cenário |
| 15:00-25:00 | esperançoso | 0.7 | Interesse em soluções, detalhando frustrações |
| 25:00-35:00 | preocupado | 0.8 | Reconhecendo limitações, mas ainda interessado |
| 35:00-43:45 | resignado | 0.9 | Aceitando que não há fit, mas mantendo educação |

### Objeções Detectadas
1. **Timestamp:** 10:46 | **Objeção:** "não é pessoa que vai conseguir pagar isso" (público baixa renda) | **Resposta do Closer:** Concordou sem contestar | **Efetividade:** ruim
2. **Timestamp:** 21:34 | **Objeção:** "não tô tendo retorno" (histórico negativo) | **Resposta do Closer:** Explicou diferenciação básica | **Efetividade:** boa
3. **Timestamp:** 26:18 | **Objeção:** "não adianta organizar casa sem paciente" | **Resposta do Closer:** Concordou sem alternativas | **Efetividade:** ruim
4. **Timestamp:** 35:39 | **Objeção:** "Nossa Senhora. Bem forte." (preço R$ 70k) | **Resposta do Closer:** "não faria sentido para você" | **Efetividade:** ruim
5. **Timestamp:** 38:57 | **Objeção:** "Bem carinho também" (mentoria R$ 6k) | **Resposta do Closer:** Desencorajou a compra | **Efetividade:** ruim

**Análise de Objeções:** Lead apresentou objeções típicas e tratáveis, mas closer concordou com todas ao invés de isolar e contornar. Perdeu múltiplas oportunidades de reframe e fechamento.', '🔴 AUDITORIA: Elane x Dra. Luciana Dias
📅 2026-03-16 | ⏱ 60min
📊 Score: 1.67/10 — FRACA

✅ Top Acertos:
1. Transparência sobre limitações
2. Coleta de informações básicas
3. Identificação de estrutura

❌ Top Erros:
1. Perda total de controle
2. Ausência de NEPQ
3. Desqualificação prematura', '[{"rank": 1, "title": "Perda total de controle", "severity": "GRAVIDADE ALTA", "description": "1:49 — Permitiu que lead atendesse paciente durante call. DEVERIA: \"Entendo a urgência, mas nossa agenda é importante. Prefere remarcar ou consegue 5 minutos para definirmos se vale prosseguir?\""}, {"rank": 2, "title": "Ausência de NEPQ", "severity": "GRAVIDADE ALTA", "description": "15:00-25:00 — Não fez perguntas de consequência quando lead verbalizou frustrações. DEVERIA: \"Se nos próximos 12 meses nada mudar, o que acontece com esses 15-20k que você está faturando?\""}, {"rank": 3, "title": "Desqualificação prematura", "severity": "GRAVIDADE ALTA", "description": "30:00-31:00 — Desqualificou sem explorar alternativas ou parcelamento. DEVERIA: \"Isolando o fator financeiro, se a condição fizesse sentido, você estaria conosco hoje?\""}, {"rank": 4, "title": "Diagnóstico quantitativo incompleto", "severity": "GRAVIDADE MÉDIA-ALTA", "description": "8:00-15:00 — Não coletou métricas essenciais. DEVERIA: \"Quantos pacientes você atende por mês? Qual seu ticket médio? Taxa de conversão atual?\""}, {"rank": 5, "title": "Apresentação sem ancoragem", "severity": "GRAVIDADE MÉDIA-ALTA", "description": "35:30 — Falou \"R$ 70.000\" sem value stack. DEVERIA: \"Para chegar nos seus 60-70k de meta, o investimento seria X, mas primeiro deixa eu mostrar o valor que isso representa...\""}]'::jsonb, '[{"rank": 1, "title": "Transparência sobre limitações", "description": "31:00-32:00 — \"não vou te empurrar nada\" manteve ética comercial aplicando Dan Lok de não ser vendedor pedinte"}, {"rank": 2, "title": "Coleta de informações básicas", "description": "5:00-7:00 — Obteve faturamento atual (15-20k) e objetivo (60-70k) seguindo fragmentos de SPIN Selling"}, {"rank": 3, "title": "Identificação de estrutura", "description": "7:00-8:00 — Confirmou secretária exclusiva aplicando requisitos operacionais do método"}, {"rank": 4, "title": "Diferenciação da concorrência", "description": "4:00-4:30 — Explicou diferença entre tráfego pago e processo comercial usando Challenger Sale básico"}, {"rank": 5, "title": "Manutenção do relacionamento", "description": "41:00-42:00 — Sugeriu alternativa (trabalhar com hospital) mantendo porta aberta para futuro"}]'::jsonb, '[{"rank": 1, "title": "Implementar Frame de Autoridade Obrigatório", "por_que": "Call sem frame vira conversa informal sem direção comercial", "prioridade": "ALTA", "o_que_fazer": "Primeiros 3 minutos sempre com agenda, três intenções e pacto de \"sim ou não\"", "como_treinar": "Role-play obrigatório de abertura até executar automaticamente"}, {"rank": 2, "title": "Nunca pular diagnóstico quantitativo", "por_que": "Sem números não há como calcular ROI nem justificar investimento", "prioridade": "ALTA", "o_que_fazer": "Lista obrigatória de 10 métricas antes de qualquer apresentação", "como_treinar": "Checklist visual durante calls até memorizar sequência"}, {"rank": 3, "title": "Dominar perguntas NEPQ de consequência", "por_que": "Sem dor emocional, lead não compra solução cara", "prioridade": "ALTA", "o_que_fazer": "Sempre perguntar \"o que acontece se nada mudar em 12 meses?\"", "como_treinar": "Praticar variações da pergunta até soar natural"}, {"rank": 4, "title": "Criar alternativas antes de desqualificar", "por_que": "Esta call tinha lead real com orçamento e necessidade clara", "prioridade": "MÉDIA", "o_que_fazer": "Sempre testar 3 formatos diferentes antes de desistir", "como_treinar": "Lista de 5 alternativas para diferentes cenários"}, {"rank": 5, "title": "Aprender ancoragem de valor obrigatória", "por_que": "R$ 70k sem contexto parece caro; com ROI calculado vira investimento", "prioridade": "ALTA", "o_que_fazer": "Nunca falar preço sem antes empilhar valor e calcular ROI", "como_treinar": "Script de ancoragem memorizado e praticado"}, {"rank": 6, "title": "Implementar ensino comercial (Challenger)", "por_que": "Lead precisa aprender algo novo para mudar perspectiva", "prioridade": "MÉDIA", "o_que_fazer": "Preparar 3-5 insights disruptivos para cada objeção comum", "como_treinar": "Banco de insights organizados por tipo de objeção"}, {"rank": 7, "title": "Treinar isolamento de objeções", "por_que": "Objeções não isoladas viram conversas circulares infinitas", "prioridade": "ALTA", "o_que_fazer": "\"Isolando o fator X, você fecharia hoje?\" antes de qualquer negociação", "como_treinar": "Role-play com todas variações possíveis"}]'::jsonb, '[]'::jsonb, '[{"impact": "Manteria autoridade e reforçaria importância da call", "reason": "Jordan Belfort - manter controle da call + Alex Hormozi - clarificar valor da conversa", "original": "Ah, você vai ter que me dar 10 minutos. Eu tenho que atender um paciente.", "rewritten": "Dra. Luciana, entendo que é uma emergência. Nossa conversa é importante para definir se posso te ajudar a sair dos 15k atuais para os 60-70k que você quer. Prefere que eu aguarde 10 minutos ou reagendamos para um momento que você tenha 100% de foco? Porque o que vamos conversar pode mudar seu cenário financeiro.", "description": "01:49 — Interrupção para atendimento"}, {"impact": "Criaria urgência emocional e justificaria investimento", "reason": "Jeremy Miner NEPQ - transformar número em emoção e consequência", "original": "Ah, pelo menos aí chega até uns 60, 70.000, né?", "rewritten": "60-70k é uma meta importante. Me conta uma coisa: o que essa diferença de 45-55k a mais por mês representaria para você? Para sua família? Para sua segurança financeira? E se em 12 meses você continuar nos 15-20k atuais, como você se sentiria?", "description": "16:30 — Meta de 60-70k revelada"}, {"impact": "Reframe total do problema e posicionamento como solução", "reason": "Challenger Sale - ensino comercial que muda perspectiva", "original": "Menos de 1%. Esse que é o problema.", "rewritten": "Menos de 1% é exatamente onde vejo oportunidade. Dra., vou te ensinar algo que vai mudar sua perspectiva: o problema não é a classe social dos seus pacientes. É que você está tentando vender procedimento isolado. Se eu te mostrasse como transformar consulta de R$ 50 em procedimento de R$ 5.000 usando os mesmos pacientes, mudaria tudo, não é?", "description": "28:36 — Lead revela conversão de \"menos de 1%\""}, {"impact": "Transformaria \"caro\" em \"investimento inteligente", "reason": "Alex Hormozi - Value Equation + ancoragem de ROI", "original": "o aceleração ele tá na faixa de 70.000 hoje.", "rewritten": "Antes de falar investimento, deixa eu mostrar o que isso representa: você quer ir de 20k para 70k mensais, certo? São 50k a mais por mês. Em 6 meses, são 300k adicionais. O programa que te levaria lá tem investimento de 70k. Ou seja, você investiria o equivalente a 1,4 meses do seu objetivo para ter os outros 58,6 meses. Faz sentido esse raciocínio?", "description": "35:38 — Apresentação do preço R$ 70.000"}, {"impact": "Manteria oportunidade viva e exploraria soluções criativas", "reason": "Cole Gordon - isolamento de objeção + criação de alternativa", "original": "não vejo assim que a gente conseguiria te ajudar hoje no cenário que você tá", "rewritten": "Dra. Luciana, isolando a questão financeira por um momento: se eu trouxesse uma proposta que coubesse no seu orçamento atual e ainda assim te ajudasse a chegar nos 60-70k, você toparia trabalhar comigo? Porque tenho uma ideia que pode funcionar para o seu cenário específico...", "description": "31:00 — Desqualificação final"}]'::jsonb, '{"Dan Lok": {"score": 2.0, "impact": "Alto - sem autoridade", "where_applied": "Postura médica 31:00", "where_missing": "Qualificação estruturada"}, "Brad Lea": {"score": 0.0, "impact": "Médio - reativo às objeções", "where_applied": "-", "where_missing": "Antecipação objeções"}, "Eli Wilde": {"score": 0.0, "impact": "Alto - sem mudança identidade", "where_applied": "-", "where_missing": "Reframe necessário 25:00-30:00"}, "Sabri Suby": {"score": 1.0, "impact": "Alto - sem ancoragem", "where_applied": "-", "where_missing": "Oferta irrecusável"}, "Cole Gordon": {"score": 2.0, "impact": "Alto - sem metodologia", "where_applied": "Frame superficial 2:00", "where_missing": "Diagnóstico/pitch estruturado"}, "Miner (NEPQ)": {"score": 0.0, "impact": "Crítico - sem consequência", "where_applied": "-", "where_missing": "15:00-25:00 era momento ideal"}, "Rackham (SPIN)": {"score": 3.0, "impact": "Alto - diagnóstico incompleto", "where_applied": "Situação 5:00-8:00", "where_missing": "Problema/Implicação/Necessidade"}, "Challenger Sale": {"score": 2.0, "impact": "Médio - sem ensino", "where_applied": "Diferenciação tráfego 4:00", "where_missing": "Insight disruptivo"}, "Hormozi (CLOSER)": {"score": 1.0, "impact": "Crítico - sem estrutura", "where_applied": "-", "where_missing": "Todo protocolo ausente"}, "Belfort (Straight Line)": {"score": 1.0, "impact": "Crítico - sem liderança", "where_applied": "-", "where_missing": "Controle perdido desde início"}}'::jsonb, '[]'::jsonb, 'test://dra.-luciana-dias-2026-03-16.ogg', NULL, NULL, NULL, NULL, 'gemini-notes', 'claude-sonnet-4-20250514', 22633, 5439, 0.1495, '2026-03-25T04:22:48.488531+00:00', NULL, '2026-03-25T04:24:41.925829+00:00', '2026-03-25T04:34:48.877395+00:00', '2026-03-25T04:34:48.877395+00:00', '2026-03-25T04:22:48.488531+00:00', '2026-03-25T04:36:53.396222+00:00', 'mixed', '[{"sentiment": "neutral", "confidence": 0.9, "key_moment": "Problemas técnicos, foco na emergência", "timestamp_range": "00:00-05:00"}, {"sentiment": "positive", "confidence": 0.8, "key_moment": "Engajamento ativo, compartilhando cenário", "timestamp_range": "05:00-15:00"}]'::jsonb, 0.2, 'medium', '[{"objection": "não é pessoa que vai conseguir pagar isso\" (público baixa renda)", "timestamp": "10:46", "effectiveness": "poor", "closer_response": "Concordou sem contestar"}, {"objection": "não tô tendo retorno\" (histórico negativo)", "timestamp": "21:34", "effectiveness": "good", "closer_response": "Explicou diferenciação básica"}, {"objection": "não adianta organizar casa sem paciente", "timestamp": "26:18", "effectiveness": "poor", "closer_response": "Concordou sem alternativas"}, {"objection": "Nossa Senhora. Bem forte.\" (preço R$ 70k)", "timestamp": "35:39", "effectiveness": "poor", "closer_response": "não faria sentido para você"}, {"objection": "Bem carinho também\" (mentoria R$ 6k)", "timestamp": "38:57", "effectiveness": "poor", "closer_response": "Desencorajou a compra"}]'::jsonb, '1.0', '70133828cebd27aa', '35597e31-aa45-4026-b864-84d53f13a2cc/auditoria_2026-03-16_dra-luciana-dias.md');

INSERT INTO call_audits (id, organization_id, closer_id, lead_name, call_date, duration_minutes, resultado, valor_fechamento, status, error_message, score_final, classificacao, d01_frame, d02_qualificacao, d03_diag_quantitativo, d04_diag_qualitativo, d05_consequencia, d06_ensino, d07_identidade, d08_ancoragem, d09_isolamento, d10_proporcao_fala, d11_promessas, d12_checkpoints, d13_fechamento, transcricao, relatorio_completo, resumo_whatsapp, top_erros, top_acertos, plano_acao, frases_proibidas, reescrita_falas, mapa_frameworks, fases_analise, audio_path, audio_duration_seconds, drive_file_id, drive_url, drive_report_url, modelo_transcricao, modelo_analise, tokens_input, tokens_output, custo_estimado, uploaded_at, transcribed_at, analyzed_at, notified_at, completed_at, created_at, updated_at, sentiment_overall, sentiment_timeline, sentiment_score, engagement_level, objections_detected, prompt_version, report_hash, storage_report_path) VALUES
('5152361d-69e8-4188-bb97-a855c8227ac3', '4ecd8f2d-d0c5-419c-a5bc-b2e94dca0465', '171a0543-1dde-4ba4-99f8-d396c6832b60', 'Luiz', '2026-03-29', NULL, NULL, NULL, 'completed', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '12 de fev. de 2026

##  Auditoria Comercial \- Luiz  \<\> System Digital \- Transcrição

### 00:00:00

   
**Evelyn La:** Por que que travou? Engraçado. M. Oi, Luiz.  
**Luiz Jorge:** Tudo bom?  
**Evelyn La:** Tudo bem contigo?  
**Luiz Jorge:** Tudo ótimo.  
**Evelyn La:** Tá me ouvindo  
**Luiz Jorge:** Agora sim. Tô, tô escutando  
**Evelyn La:** bem?  
**Luiz Jorge:** perfeitamente.  
**Evelyn La:** Você fala da onde?  
**Luiz Jorge:** Belém do Pará.  
**Evelyn La:** Belém. Tá longe, hein? Tô no Paraná.  
**Luiz Jorge:** É longe. Eu tive aí janeiro,  
**Evelyn La:** Curitiba.  
**Luiz Jorge:** Curitiba.  
**Evelyn La:** Você tá de boa. Gosto ali de Curitiba.  
**Luiz Jorge:** Casamento. Passei uns cinco dias  
**Evelyn La:** Ah,  
**Luiz Jorge:** lá.  
**Evelyn La:** que legal. Família. Casamento.  
**Luiz Jorge:** Família não de amigo. E o que era de Belém?  
**Evelyn La:** Ah,  
**Luiz Jorge:** Se mudou para lá e acabou casando lá. A gente foi para lá pro casamento.  
**Evelyn La:** saiu de Belém, veio pro sul passar frio esse,  
**Luiz Jorge:** Não, pior que tava calor aí.  
**Evelyn La:** hein?  
**Luiz Jorge:** Mas antes tivesse frio que calor a gente baixa de calor aqui que é calor o ano  
**Evelyn La:** É,  
**Luiz Jorge:** todo.  
**Evelyn La:** né? Aí não tem. Aí o inverno de vocês aí é o quê? 20º.  
   
 

### 00:02:29

   
**Evelyn La:** E olhe lá, né?  
**Luiz Jorge:** E tá todo mundo morrendo de hipotermia já.  
**Evelyn La:** Sério?  
**Luiz Jorge:** Acho que nem bate 20º, eu acho. Já que é chuva, é menos chuva ou mais chuva.  
**Evelyn La:** Hum, entendi. Nossa, eu não, provavelmente não me adaptaria então tanto a ao clima.  
**Luiz Jorge:** É muito úmido.  
**Evelyn La:** Mas E você tava com o filho jogando  
**Luiz Jorge:** É,  
**Evelyn La:** bola.  
**Luiz Jorge:** ele chegou, cheguei, ele queria ficar lá embaixo jogando bola. Eu falei: "Não, aí eu tive que ficar lá com ele. O problema é que eu tô com ro da eu não podia nem fazer nada, tava só sentado  
**Evelyn La:** Ah,  
**Luiz Jorge:** olhando.  
**Evelyn La:** certo. O ro para quem mesmo? É o do cardiológico,  
**Luiz Jorge:** Cardiológico. É.  
**Evelyn La:** né? Ah, entendi. Ah, eu tenho um pequeno também, ele volta e meio e me arrasta pra quadra do prédio que eu falo: "Ai, filha, eu já não domino tanto e ainda você me faz eu jogar." Ah,  
**Luiz Jorge:** Pois é, tem que fazer essa esse papel, né?  
**Evelyn La:** thank. Mas faz parte, né?  
**Luiz Jorge:** É, faz parte.  
**Evelyn La:** É casado também.  
   
 

### 00:03:31

   
**Evelyn La:** Eh,  
**Luiz Jorge:** Sou fazer um dia vai ela,  
**Evelyn La:** tem que faz parte.  
**Luiz Jorge:** um dia vai eu.  
**Evelyn La:** Vai,  
**Luiz Jorge:** Então,  
**Evelyn La:** dá uma alternada. Eu também. Vai. Uma. Uma hora vai eu, outra hora é o pai dele que leva ele em algum lugar porque senão  
**Luiz Jorge:** é, e tem muita energia essas crianças.  
**Evelyn La:** tem o teu. Tem que idade?  
**Luiz Jorge:** Sete,  
**Evelyn La:** É o meu também.  
**Luiz Jorge:** um de 7 de 12\.  
**Evelyn La:** Eu tenho um de sete. Ele tá tá no primeiro ano agora esses dias aí. foi agora esses dias pro primeiro ano, né? Aí ele veio todo feliz que ele tinha conseguido ler uma frase sozinho. Falei: "Ah, isso aí é boa".  
**Luiz Jorge:** É, essa fase é boa. Começando a a ler,  
**Evelyn La:** É,  
**Luiz Jorge:** escrever.  
**Evelyn La:** essa fase é boa. Mas que bacana. E como é que tá a região aí pro seu pro seu mercado? Vi que você é cirurgião ortognático, isso, né?  
**Luiz Jorge:** É cirujambuc maxilo.  
**Evelyn La:** Buco,  
**Luiz Jorge:** É,  
**Evelyn La:** certo?  
**Luiz Jorge:** aí eu tô mudando um pouquinho de área que eu tô de saco cheio desse negócio de hospital, de trauma, de ortognática.  
   
 

### 00:04:30

   
**Luiz Jorge:** Aí eu tô começando a fazer cirurgias estéticas da  
**Evelyn La:** Aham.  
**Luiz Jorge:** face já,  
**Evelyn La:** Legal. Já tá atuando com as cirurgias estéticas ou você vai  
**Luiz Jorge:** porque como eu comecei há pouco tempo,  
**Evelyn La:** fazer?  
**Luiz Jorge:** eu já peguei dois casos só, então tá muito no começo e eu tô ainda triando,  
**Evelyn La:** Tá.  
**Luiz Jorge:** já tem umas pessoas já mais ou menos fechada, mas ainda tô no começo dessa área.  
**Evelyn La:** Uhum.  
**Luiz Jorge:** disso, eu faço muito implante, siso no consultório, mas eu quero focar nessa parte estética aí,  
**Evelyn La:** Ah, legal, legal que sim.  
**Luiz Jorge:** parte cirúrgica, no caso,  
**Evelyn La:** Uhum.  
**Luiz Jorge:** né?  
**Evelyn La:** Cirúrgicas em si. Deixa eu te apresentar um pouquinho da Evelyn, então agora para você conhecer sobre quem vai tá te auxiliando aqui nesse diagnóstico. A gente pede para entrar pelo computador porque aí fica mais fácil você visualizar as nossas apresentações, caso a gente entre, né, nesse quesito também. Mas antes de eu iniciar aqui contigo sobre conhecer um pouquinho mais a tanto na atuação quanto também a parte de como você já vem fazendo com todo o seu processo ali de marketing, enfim, né? A gente vai entrar em algumas questões, te apresentar um pouquinho da Evelyn para você conhecer também sobre mim aí, sobre quem vai tá contigo esse tempinho.  
   
 

### 00:05:49

   
**Evelyn La:** Eu sou a Evelyn, mãe do Eitor palmeirense. Minha criança foi pro foi pro lá pro time do pai,  
**Luiz Jorge:** Eita\!  
**Evelyn La:** não quis ficar com o time da mãe, que é o Grêmio, né? Não que esteja uma fase tão boa assim, mas pelo menos tem mundial. Eu falo brincando para ele.  
**Luiz Jorge:** É isso aí.  
**Evelyn La:** Aí ele me arrastando aqui pros pro jogo de futebol. Volta e meia, né? Adoro jogar bola. Eu já não gosto tanto, sou mais fazer atividades de caristenia, né? Gosto de treinar. Eu como moro em Cascavel, eu fico bem do ladinho de Foz. Foz é praticamente aí meu quintal de casa,  
**Luiz Jorge:** Cel  
**Evelyn La:** eu falo, né? As cataratas. Ali volte a gente dá um pulo lá. Tem uns uns hotéis bem bem bacana assim, principalmente para criança, né?  
**Luiz Jorge:** dá quanto tempo devel para lá?  
**Evelyn La:** Tem muita dá 1 hora30 no máximo.  
**Luiz Jorge:** Nossa,  
**Evelyn La:** Aham.  
**Luiz Jorge:** muito perto.  
**Evelyn La:** E aí eu tenho Paraguai e Argentina também aqui do lado, né?  
**Luiz Jorge:** É bem  
**Evelyn La:** Então é, dá para comprar os vinhos que eu gosto muito,  
**Luiz Jorge:** pertinho.  
   
 

### 00:06:48

   
**Evelyn La:** né? Sou de descendência italiana, então meu vô me ensinou a tomar vinho. Tinha a idade do meu filho praticamente quando ele me ensinou. E não fico sem chimarrão. Então tem umas ervas boa ali no Paraguai também.  
**Luiz Jorge:** Aí a minha mãe é gaúcha, minha família para parte de mãe é gaúcha. Eu nunca gostei de chimarrão, nunca consegui tomar.  
**Evelyn La:** Sério,  
**Luiz Jorge:** Hum.  
**Evelyn La:** tem gente que não não curte mesmo. Eu tenho uns familiar que são gaúchos e não Aí,  
**Luiz Jorge:** E a minha mãe não toma também, né? Minha mãe,  
**Evelyn La:** ó. Uhum.  
**Luiz Jorge:** ela não  
**Evelyn La:** É bem opcional mesmo, né? Não tem muito.  
**Luiz Jorge:** toma.  
**Evelyn La:** A cultura é forte sim, mas conheço uns gaúchos também que não são muito adepto ao Shima. Bom, um pouquinho da minha parte profissional para você conhecer, né? como que eu vim parar aqui. Eu sou formada na área da saúde,  
**Luiz Jorge:** M.  
**Evelyn La:** sou mestre em genética, trabalhei durante 10 anos em laboratório. Eh, tive aí uma trajetória bem bacana, né, em hospitais, inclusive também eu fazia análises da parte microbiológica de um hospital universitário aqui do do Paraná.  
   
 

### 00:07:45

   
**Evelyn La:** E depois que eu tive o Heitor, aí eu fui me aventurar no ramo do empreendedorismo. Aí eu abri uma loja, tive ali 4 anos de experiência com a loja, né, de sua parte de empresário, empresariado. Era uma loja de produtos naturais, ficava num prédio alugado e a mulher acabou vendendo o prédio e eu tive que encerrar minhas atividades. Mas foi uma boa experiência, foi onde eu entrei mais pro mercado das vendas em si e atualmente atuo como closer, né? Então a closer hoje ela faz o quê? O responsável por esse diagnóstico, por essa análise.  
**Luiz Jorge:** Угуm.  
**Evelyn La:** E eu fiz essa transição pro mundo das vendas porque é um mundo aonde a gente consegue fazer um capital muito bom hoje, sabe? a fala assim: "Vendas é coração de qualquer empresa, de qualquer negócio. Sem vendas não tem faturamento." E foi onde eu me encontrei de fato, juntei as duas coisas, né? Querendo ou não. Hoje eu atendo aí dentistas, a gente atende médicos, então eu tenho um pouco dessa trajetória na área ali e unir a útil agradável. Então, só no ano de 2025 eu fechei mais de 2 milhões de vendas em faturamento no um a um, que a gente diz, né, que é essa venda personalizada, tanto eventos presenciais quanto online.  
   
 

### 00:09:02

   
**Evelyn La:** E quando é presencial não deixo de levar meu chimarrão também.  
**Luiz Jorge:** Aí faz falta, né?  
**Evelyn La:** Falou. Então, essa é um pouquinho da Evelyn para conhecer aí, né, quem vai tá te auxiliando nesse diagnóstico agora. E pra gente começar, eh, vou deixar só, eu gosto de colocar três, três intenções bem claras aqui, né, Luiz? Então, assim, não tô para te vender e nem te empurrar nada. Óbvio que quando a gente faz uma venda é muito bom, sim. Mas antes de qualquer coisa, eu tô aqui para contribuir, tô aqui para te ajudar. Para isso, eu vou entender um pouquinho melhor seu cenário, vou conhecer um pouquinho mais de você, da sua atuação, de como que tá hoje o seu cenário, seus objetivos, para ver se faz sentido você estar com a gente, né? E claro, fazendo sentido,  
**Luiz Jorge:** Угуm.  
**Evelyn La:** aí eu te apresento um pouquinho mais o nosso trabalho para você analisar se faz sentido o nosso ecossistema também para aquilo que você almeja, né? Então é sempre eu falo, é uma via de mão dupla, né? é uma uma ambas as partes aqui precisam estarem em alinhamento de expectativas. Então, hoje aqui a gente vai começar eh eu querendo conhecendo um pouquinho mais hoje de como você atua, né?  
   
 

### 00:10:23

   
**Evelyn La:** Você falou que você atua em hospitais e como que tá sendo as cirurgias aí da face, tá? Com algum consultório eh paralelo? Fala um pouquinho aí sobre isso hoje.  
**Luiz Jorge:** Pois é, sou eu sou cirurgião Buco Maxilo. Eh, atuo muito na área de trauma, ortognática, cirurgia de ATM. Então eu trabalho cinco hospitais, então trabalho em três hospitais regionais, um em Belém e um no e dois no interior, um em Capanema, 160, 180 km e outro a 300 km daqui. Só que eu já não aguento mais pegar a estrada, fazer plantão, então trabalho de domingo a domingo. Então a minha intenção é diminuir isso,  
**Evelyn La:** Nossa\!  
**Luiz Jorge:** ficar mais no consultório, que eu tenho meu consultório particular, tenho duas salas lá que eu eu atendo quando eu tô no consultório, que eu tenho muito paciente, só que não voltado para essa área cirúrgica estética, tenho muita paciente de siso,  
**Evelyn La:** Mhm.  
**Luiz Jorge:** de de implante, enxerto, biópsia, mas eu queria focar mais no consultório nessa parte particular. Até o momento eu tenho, eu tô atendendo plano de saúde, que é o Unodonto e a Petrobras, só que eu tô diminuindo, então a minha intenção é tentar tirar os planos.  
   
 

### 00:11:44

   
**Luiz Jorge:** Então eu já fechei dia que eu no consultório eu atendo segunda de manhã que eu faço só consulta, quarta de manhã e de tarde eu deixei agora só para só para plano e quinta e  
**Evelyn La:** Tá,  
**Luiz Jorge:** sexta eu tô deixando só para particular. Aí fora,  
**Evelyn La:** não entendi.  
**Luiz Jorge:** sobre aviso, plantão e outros dias,  
**Evelyn La:** Uhum.  
**Luiz Jorge:** sábado, domingo. Então essa minha intenção é trabalhar menos, ganhar mais, ter uma qualidade melhor final de semana, chegar mais cedo para curtir meu filho,  
**Evelyn La:** Sim,  
**Luiz Jorge:** que esse momento de hoje da quadra lá, eu não tenho como falar não, porque eu já não passo muito tempo com eles, eu só chego tarde, tarde da noite em casa,  
**Evelyn La:** com certeza.  
**Luiz Jorge:** então aí eu não tenho como falar não.  
**Evelyn La:** Sim, super.  
**Luiz Jorge:** Então tive que fazer descer lá com ele. não, a gente tava na rua, fui pegar ele, daí tive que fazer isso porque eu não vou falar não, já que eu nunca tô presente. Então,  
**Evelyn La:** Sim,  
**Luiz Jorge:** a intenção é essa,  
**Evelyn La:** sim,  
**Luiz Jorge:** é curtir mais eles,  
**Evelyn La:** tem.  
**Luiz Jorge:** ganhar um bom dinheiro particular e trabalhar menos. Eh, ter meu minha minha ir pra academia no horário de herdeiro,  
**Evelyn La:** Uhum.  
   
 

### 00:12:46

   
**Luiz Jorge:** coisa que eu só vou se quando eu é 5 da 5 da manhã,  
**Evelyn La:** Sim.  
**Luiz Jorge:** então se à noite não pode fazer o que for, não dá para eu ir. Porque eu já chego quebrado à noite, então se eu não for 5 da manhã eu não já tô  
**Evelyn La:** Depois final tá esgotado,  
**Luiz Jorge:** quebrado.  
**Evelyn La:** né?  
**Luiz Jorge:** Então aí por enquanto, como eu tá fraca essa parte particular que eu eu tô enchendo mais a sexta-feira no consultório, eh principalmente a parte de implante, extração de dente incluso, aí na quinta-feira eu tô acompanhando uma dentista que faz muita cirurgia estética da face. Então lá que eu fico praticando, que ela não sabe fazer mais,  
**Evelyn La:** Certo.  
**Luiz Jorge:** faz mais ou menos, aí eu acabo sendo uma ajuda muito importante para ela. Então quem faz lá praticamente sou eu. Mas eu tô começando a cobrar baratinho de algumas pessoas para poder fazer, que as pessoas gostam de fazer negócio de antes e depois.  
**Evelyn La:** อือ  
**Luiz Jorge:** Então eu tento fazer o mínimo possível. Daí eu tô cobrando pouco. Já tem uns casos já mais ou menos fechado que eu já tô cobrando pouquinho, mas mais nada do que eu gostaria. Mas todo começo, digo, uma área assim, então para poder fazer o nome, fazer registro de antes e depois é assim.  
   
 

### 00:14:05

   
**Luiz Jorge:** Vamos.  
**Evelyn La:** E e hoje, Luís, você atende no consultório esses que você falou que abriu, né, para quinta e sexta? É um consultório seu, é alugado, como que  
**Luiz Jorge:** Não é meu, é meu. Outório é meu.  
**Evelyn La:** é?  
**Luiz Jorge:** Eu tenho duas salas, né? Tenho duas, são duas cadeiras odontológicas em duas salas.  
**Evelyn La:** Certo? Aham. E aí você  
**Luiz Jorge:** Mas como eu tenho muito fluxo de paciente,  
**Evelyn La:** tem  
**Luiz Jorge:** então às vezes eu saio de uma sala, já tem paciente na outra, vai lá, opera num, daí volta para outra sala, opera outro, vai, opera um, opera outro. Graças a Deus eu tenho muito paciente.  
**Evelyn La:** Uhum.  
**Luiz Jorge:** Cirurgia estática da face ainda não, mas já tô divulgando no Instagram, já fiz uns uns casos pequenos, mas aí o pessoal já tá se interessando, já tá procurando, perguntando e aí assim vai. Todo começo é difícil, mas assim nessa área, mas aí começando a fazer mais barato, tendo um antes e depois para poder o pessoal ver que eu tô fazendo, aí já começa a movimentar indicação boca a boca.  
**Evelyn La:** Uhum, entendi. Ah, e nesse consultório que você atende quinta a sexta, alguém agenda para você?  
   
 

### 00:15:21

   
**Evelyn La:** Tem alguém que te auxilia?  
**Luiz Jorge:** Tem, eu tenho dois funcionários lá,  
**Evelyn La:** Como que é?  
**Luiz Jorge:** tem uma secretária da recepção e eu tenho uma auxiliar dentro do consultório  
**Evelyn La:** Ah, ótimo.  
**Luiz Jorge:** comigo.  
**Evelyn La:** Muito bom. Entendi. Você falou que já começou a divulgar um pouco, né? Chegou pegar eh agência de tráfego alguma vez ou  
**Luiz Jorge:** Já. Pois é, que eu faço?  
**Evelyn La:** não?  
**Luiz Jorge:** Eu tenho um rapaz que faz as minhas mídias sociais, ele que faz as postagens, faz tudo. O que eu mais movimento são é o history. Então eu posto, né, quando eu quero uma coisa melhorzinha, eu mando para ele e aí quando eu vejo que tem uma postagem legal, aí eu pago e aí eu faço, tá, um mês, 15 dias para poder ter mais visualização, divulgação. Não sei se seria isso,  
**Evelyn La:** Uhum.  
**Luiz Jorge:** o tráfego pago. Eu, na minha visão que eu sou leigo, eu acredito que seja isso mais ou menos.  
**Evelyn La:** Eh,  
**Luiz Jorge:** Mas eu deveria fazer bem  
**Evelyn La:** na ver Sim, sim. Eh,  
**Luiz Jorge:** mais.  
**Evelyn La:** para te trazer assim volume, eh, uma demanda qualificada, é interessante umas estratégias mais profissionais, vamos dizer, porque é daí que vai aumentar a sua agenda, por exemplo, paraas cirurgias da face, que é o que o teu objetivo, né?  
   
 

### 00:16:29

   
**Evelyn La:** E aí você vai se conseguir se desligando das outras. Ah, mas fora isso, você nunca chegou a trabalhar, por exemplo, com uma agência em si,  
**Luiz Jorge:** Não, já cheguei a pesquisar.  
**Evelyn La:** fazer  
**Luiz Jorge:** Só que eu não levo a frente porque isso requer tempo, reuniões, é muito difícil para mim. Meu tempo é muito complicado.  
**Evelyn La:** certo,  
**Luiz Jorge:** Então assim, eu nunca levei paraa frente. Acho que eu peguei uma uma opinião,  
**Evelyn La:** certo.  
**Luiz Jorge:** um orçamento, alguma coisa. Acho que de uma só, mas nunca nunca fui paraa frente, de duas, na verdade, uma daqui de Belém e a outra fora, que nem assim com você,  
**Evelyn La:** Uhum.  
**Luiz Jorge:** mas nunca fui paraa frente.  
**Evelyn La:** Hum.  
**Luiz Jorge:** Eu já voltei pensando desse anciano que eu precisava fazer isso.  
**Evelyn La:** Uhum. Uhum.  
**Luiz Jorge:** treinamento de funcionária, tudo isso aí é importante.  
**Evelyn La:** É isso.  
**Luiz Jorge:** Gente,  
**Evelyn La:** É exato. Eh, hoje se você continuar do jeito que tá, tu já sabe aonde que que vai parar o que que você tem de faturamento, de toda essa questão que você trouxe,  
**Luiz Jorge:** Да.  
**Evelyn La:** né, referente a a você ter que tá se deslocando esse desgaste todo.  
   
 

### 00:17:32

   
**Evelyn La:** E aí eu queria entender o seguinte, o que que você acredita que impede talvez de você dar essa para desacelerar um pouco de um lugar e focar mais agora nas cirurgias? O que que você acredita que  
**Luiz Jorge:** Ah, per ten que ter fluxo. Eu tenho que ter fluxo para poder eu ganhar mais dinheiro no consultório e daí começa a largar.  
**Evelyn La:** impedir  
**Luiz Jorge:** Sobreviso, o plantão, ida para pro interior e assim vai.  
**Evelyn La:** fluxo em si? Então, certo. Uhum.  
**Luiz Jorge:** grupo cirúrgico de cirurgia da face que é o que dá, tá dando dinheiro, que é estética todo mundo paga, paga bem, paga a  
**Evelyn La:** Uhum,  
**Luiz Jorge:** vista.  
**Evelyn La:** entendi. Ah, e assim, de zer a 10 para resolver todas essas essas questões aí, né, e aumentar o seu fluxo, hoje seria quanto mais ou menos?  
**Luiz Jorge:** Ah, tem que ser 10 porque quero aumentar da noite pro dia para ontem,  
**Evelyn La:** Para ontem já.  
**Luiz Jorge:** porque eu preciso movimentar logo.  
**Evelyn La:** Tá certo. É isso aí. Mas vamos lá. Eh, Luiz, agora, né, que você me passou um pouquinho mais sobre como que tá seu cenário atual, como que você já atua, sabendo que você tem duas funcionárias, isso é ótimo, porque de fato eh hoje se eu conseguisse encaixar uma proposta aqui, a gente conseguisse resolver isso para você, né, treinar suas funcionárias, inclusive, porque esse é um papel que a gente assume, você abraçaria?  
   
 

### 00:18:59

   
**Luiz Jorge:** Sim,  
**Evelyn La:** Legal.  
**Luiz Jorge:** com certeza.  
**Evelyn La:** Então, antes de eu iniciar a apresentação aqui, eu quero só fazer um combinado contigo, que é o seguinte, eh, eu vou entrar na apresentação para te mostrar como que é o nosso trabalho, nossa metodologia, inclusive toda essa parte do treinamento que a gente abraça, né, e faz pros funcionários do cirurgião. Não precisa se preocupar com isso. Mas ao final da apresentação, eu gostaria de contar com o sim ou não, tá? E tá tudo certo. O sim ou não para quê, Evelyn? Sim, faz sentido. Vou seguir com vocês. Ótimo. Ou não, Evelyn, pro momento, para hoje vai ser não. Pode ser que daqui um mês, daqui dois meses, você venha e retorne e tá tudo certo. Posso contar com o seu sim, com o seu não.  
**Luiz Jorge:** Sim, com  
**Evelyn La:** Ah, maravilha. Vamos lá,  
**Luiz Jorge:** certeza.  
**Evelyn La:** então, Luís, eu vou te apresentar agora um pouquinho sobre a System. Primeira coisa, nós não somos uma agência de tráfego pago. Você vai entender um pouquinho melhor agora sobre como que a gente trabalha, eh, e todo o o por trás ali de que como que fazemos aumentar tanta conversão assim e tanto faturamento.  
   
 

### 00:20:08

   
**Evelyn La:** Opa, só um minutinho que ela é o sistema fácil sem que é o nosso Só Só um minutinho que ele fui compartilhar e ele travou. Tá dando para ver bem aí, Luiz?  
**Luiz Jorge:** Tá sim. Tá  
**Evelyn La:** Tá. Ah, maravilha.  
**Luiz Jorge:** sim.  
**Evelyn La:** Vou te apresentar um pouquinho sobre a empresa em si, né? A nossa assistem digital e o nosso método que é o Face 100K. 100K por quê? 100K de faturamento, R$ 100.000, né? O que é o mínimo que a gente espera aí fazer juntos eh ao longo desse, claro, alguns fazem isso em um mês, é muito possível com o ticket das cirurgias que a gente ajuda a inclusive organizar isso, mas óbvio, todo mundo tem o seu tempo, não é uma garantia de um mês que você consegue bater 100k, mas a gente tem alguns cases desse sentido, mas o o mínimo que a gente fala assim, o mínimo dentro do nosso acompanhamento aí é fazer 100k. mesmo, né, de faturamento, é possível atingir. Então, hoje, quem é a Sistem Digital que tá por trás desse método? Nós somos uma empresa especialista em gerar demanda qualificada e processos comerciais para clínicas de eh focadas em cirurgias da face, né?  
   
 

### 00:22:35

   
**Evelyn La:** a gente tá 6 anos já no mercado. Nós não somos uma agência de tráfego pago. A gente faz sim o marketing. A gente trabalha todo o posicionamento, toda a estratégia mais eh profissional ali por trás para lançar a campanha, né? Justamente porque através da estratégia que vai qualificar melhor essas pessoas. Sem isso, ah, você só atinge volume, mas pessoas muitas vezes desinteressada que não responde, que não tem nada a ver com o que você quer entregar. muitas vezes ali. Então a gente trabalha toda a construção de processos comerciais junto, que é o resultado que é o treinamento da equipe, que vai trazer aí 40, 60% de conversão.  
**Luiz Jorge:** Mas e aí, vocês também fariam esse trabalho junto com as minhas secretárias e com a e com o rapaz  
**Evelyn La:** Sim, passou esse também.  
**Luiz Jorge:** que faz as minhas mídias sociais também?  
**Evelyn La:** Uhum. Exatamente. Caso você queira fazer com a gente, nós temos um gestor de tráfego pago hoje que ele só cuida de dos nossos parceiros, né, de quem a gente tá atuando junto. Caso você queira continuar com quem você já tá, também é critério seu,  
**Luiz Jorge:** E assim,  
**Evelyn La:** tá?  
**Luiz Jorge:** às vezes a culpa até um pouquinho minha, porque o cara toda semana ele quer gravar conteúdo, quer gravar, quer gravar, quer não sei o quê e me perturba e eu não, não tenho tempo, não sei o quê, porque esse negócio de gravar não é comigo,  
   
 

### 00:23:53

   
**Evelyn La:** Угу.  
**Luiz Jorge:** daí não tenho tempo e e eu vou enrolando. Tipo, sexta-feira eu vou fazer uma uma gravação de casos que eu fiz no consultório. O paciente tá fazendo físio, então pedi para ela ir bem maquiada para poder fazer o antes e depois dela toda produzida aí fazer vídeo mostrando que foi feito. Então a gente vai fazer sexta-feira de  
**Evelyn La:** Legal.  
**Luiz Jorge:** manhã.  
**Evelyn La:** Legal. Uhum. É, precisa do conteúdo, porque a partir disso a gente constrói tanto seu posicionamento para você poder conversar com o público ideal e a partir disso gerar as campanhas com estratégias e chegar nessas pessoas, né? Então é importante fazer a a toda a parte ali de conteúdo, gravar, não necessariamente você aparecer tanto, caso você não goste, dá pra gente eh bolar outras estratégias onde não o que você tenha que sempre aparecer, né? pode filmar às vezes, por exemplo, o seu consultório em si. Ali tem várias coisas que a gente consegue eh  
**Luiz Jorge:** Mas é, mas é importante a gente aparecer. Toda vez que eu apareço ou falo,  
**Evelyn La:** atuar.  
**Luiz Jorge:** tem muito mais engajamento, muito mais curtida do que ficar aquele negócio muito mecânico, só figurinha, fotinha, não sei o quê, um negócio meio artificial,  
   
 

### 00:25:15

   
**Evelyn La:** É,  
**Luiz Jorge:** então fica muito,  
**Evelyn La:** aquilo ali não vende, tá? já te adianta,  
**Luiz Jorge:** não vende.  
**Evelyn La:** aquilo não vende.  
**Luiz Jorge:** Pois é. Yeah.  
**Evelyn La:** O que vende é você realmente se posicionar, mostrar o profissional por trás do resultado e resultado, né, o que vende. Agora o post bonitinho, feliz Natal, feliz dia dos pais, aquela coisa que mais o pessoal às vezes faz naquilo ali não vende. Aquilo ali realmente é só para pros que fazem esse esse trabalho mais aí de produção de criativo ganhar. Então hoje quem tá, quem é um dos sócios donos da Assistem é o Renan, um dos sócios que tá há 5 anos gerindo já time de alta performance, gerou 15 milhões de vendas através do digital. O outro é o Mateus, nosso gestor estratégico. Então, Mateus é nosso expert da parte estratégica, né, essa questão toda posicionamento, marketing, a parte ali realmente estratégica é o Mateus que cuida e a Dra. Débora, que foi uma das nossas primeiras parceiras e virou nossa embaixadora e sócia. A Dra. A Débora, ela fez eh com a gente, né, o o processo todo de estrutura, enfim, aumentou seu faturamento. E a partir disso hoje a gente tá inclusive em outro projeto com ela que a gente criou um novo produto, ela vai ser mentora de alguns de algumas imersões e aí a gente também tá junto com ela nessa.  
   
 

### 00:26:44

   
**Evelyn La:** Esse foi um dos faturamentos que a gente conseguiu gerar dentro da clínica em um mês de uma da de clínicas, né? alguns dos sonhos aí dos dos sócios realizados. E o que que hoje empata muito o resultado das clínicas, né? O cenário atual é justamente essa questão de muitas vezes depender só de indicação, ah, ficar muito preso aí ao operacional, trabalha demais, ganha ganha menos, né? pouca lucratividade e a maioria sempre vem também com essa questão de frustrações com outras agências e demanda de pessoas desqualificadas. Às vezes até chegou a investir em tráfego pago, já fez, já trabalhou com outras agências antes. Mas o que que acontece na sua na sua situação hoje? O lead ele tá cada vez mais caro você fazer essa captação no Instagram. Então, se você não trabalha um posicionamento prévios, se você não constrói uma estratégia específica, você dá tiro eh no escuro, né? só colocar dinheiro ali no Instagram e fazer rodar campanha, ele não vai resolver, ele não vai te trazer clientes qualificados dispostos a investir no que você está eh dispondo ali de solução. Então é muito importante o que trabalhar a estratégia, trabalhar o processo realmente estruturado, ah, um posicionamento importante para que você possa conversar com o público diretamente, eh, que você quer atingir.  
   
 

### 00:28:24

   
**Evelyn La:** Então, trazer essa previsibilidade, né, clientes qualificados consegue trabalhar com mais paz mental porque aumenta a demanda, cria um ticket médio aí bom, né, sai dessa dessa da correria em si. Então, a gente faz isso de forma bem personalizada. Se a gente tá há 6 anos já trabalhando com isso, é o que vai fazer realmente mudar o jogo, né? é trabalhar estrutura e marketing. Foi o que a Natália Beauty fez, inclusive é uma das maiores hoje dentro da beleza. Mas ela uniu o quê? o marketing, o se posicionar e falar exatamente com quem ela gostaria de atingir e criar estratégia comercial para vender, porque nada adianta você ter volume. E o que acontece muitas vezes com quem tenta fazer sozinho é perder saúde mental, perder tempo. Eh, acaba eh perdendo tempo em processos aonde não domina e aí às vezes vê um concorrente até que nem é tão bom assim no serviço passando na frente dele, né? Esses são os riscos de fazer sem o conhecimento. E aí eu sempre digo, a o quanto vale, o quanto valeria hoje, por exemplo, pro Luiz trabalhar de forma mais tranquila, com ticket melhor, né, mais próximo de casa, mais qualidade de tempo com o filho, porque a clínica anda sozinha, né? Não fica refé, inclusive nem de funcionários, porque nós treinamos o timos e passamos processos padrões.  
   
 

### 00:30:01

   
**Evelyn La:** Então, caso eu precise, por exemplo, Evely, mudar a minha secretária do dia paraa noite, tendo processo padrão, ela vai entrar e ela vai seguir e tá tudo certo. A pessoa não sai dali,  
**Luiz Jorge:** Uhum.  
**Evelyn La:** não leva às vezes o processo com ela, né? A gente evita isso porque prejudica  
**Luiz Jorge:** É, pois é, mas eu preciso muito fazer esse treinamento com a minha secretária,  
**Evelyn La:** muito.  
**Luiz Jorge:** principalmente a de porta lá que que atende, que recepciona, que liga, que confirma. Então assim, eu tenho que que se não mudar vai rodar,  
**Evelyn La:** Ótimo.  
**Luiz Jorge:** infelizmente.  
**Evelyn La:** Exatamente.  
**Luiz Jorge:** Daí e o que é bom é ter uma pessoa que consiga fazer isso e ver,  
**Evelyn La:** É isso.  
**Luiz Jorge:** minha filha, não dá do que eu bater de frente,  
**Evelyn La:** Isso.  
**Luiz Jorge:** entendeu?  
**Evelyn La:** Exatamente. Esse é é o que é justamente o que a gente faz, ajuda eh o empresário nesse sentido, eh resolver o quanto quanto mais e a gente consegue entrar na operação junto e resolver essas questões mais de do operacional em si mesmo, que é a grande a maior parte do trabalho em si para ter umas boas vendas, vai ser feito por quem? pela secretária. Então, é claro, a estratégia de marketing, gerar demanda qualificada, tudo isso é importante, mas se a pessoa chegou qualificada e a secretária não sabe o que fazer, ou se ela não tem processo, ou ela faz de uma maneira que assim o lead não engaja, perdeu, perdeu às vezes um potencial paciente ali que poderia converter, poderia gerar uma venda pelo falta de processo de como executar a abordagem correta, de o que falar em cada passo, em cada etapa do atendimento, né?  
   
 

### 00:31:40

   
**Evelyn La:** Então, a gente treina principalmente essa questão. E aí, o que que é interessante, né? O que que eu falo assim, quanto valeria tudo isso? Por que que traz tanta tranquilidade e paz mental? Porque a gente vai criando processos e estratégias que vão aumentando o seu LTV, que é o tempo que esse mesmo paciente pode vir a investir por mais vezes contigo. Então, mesmo que vem para uma cirurgia buco maxila, depois ele faz um procedimento facial, faz uma, não sei se você tá, já tá trabalhando com algum com preenchimentos também, algo nesse sentido,  
**Luiz Jorge:** Faço preenchimento só de gordura, não faço nada de botox,  
**Evelyn La:** mas  
**Luiz Jorge:** negócio de ácido hialurônico, essas coisas. O minha, meu negócio é mais, não é de injetáveis, é de de cirúrgico.  
**Evelyn La:** gordura.  
**Luiz Jorge:** Então,  
**Evelyn La:** Aham.  
**Luiz Jorge:** hipo, cérvico, facial, aí pega essa gordura, trata, injeta lábio, pento, nariz, olheira,  
**Evelyn La:** Ótimo.  
**Luiz Jorge:** bigode chinê, facelift que puxa tudo, frontoplastia, bléfaro, todas essas cirurgias. mais para frente um pouquinho rino,  
**Evelyn La:** Nossa.  
**Luiz Jorge:** que eu ainda não comecei a fazer rino, mas todo esse tipo de cirurgias aí de estética da  
   
 

### 00:32:48

   
**Evelyn La:** Uhum. Não. Ótimo. Ótimo.  
**Luiz Jorge:** face.  
**Evelyn La:** Tem uma esteira muito boa, Luiz. E quanto valeria, né, você ter tudo isso na clínica, sabendo que vai ter um processo redondinho, que vai vender os procedimentos e aí você fica com mais tranquilidade.  
**Luiz Jorge:** E assim, já investi uma grana já dessa cirurgi,  
**Evelyn La:** Eu  
**Luiz Jorge:** tanto equipamento, material,  
**Evelyn La:** acredito.  
**Luiz Jorge:** tudo, curso. Em três meses já gastei 90.000 em curso. Então assim, tem que negócio tem que retornar, entendeu?  
**Evelyn La:** Sim, tem que dar RO,  
**Luiz Jorge:** Então,  
**Evelyn La:** né?  
**Luiz Jorge:** deixei com equipamento e tudo, já gastei muito dinheiro e assim, o negócio tem que voltar rápido, tem que vingar rápido, na verdade,  
**Evelyn La:** Sim, exatamente.  
**Luiz Jorge:** porque eu vejo lá que essa pessoa que eu acompanho aqui que o fluxo dela é tipo absurdo,  
**Evelyn La:** Acelerar.  
**Luiz Jorge:** porque ela já tá naquela fase de boca a boca, então um indica pro outro, indica pro outro, daí aí já tá do jeito que hoje em dia eu tô,  
**Evelyn La:** Mhm.  
**Luiz Jorge:** mas na parte de plano, entendeu? que eu vai indicando.  
**Evelyn La:** Aha.  
**Luiz Jorge:** Eu tenho muito fluxo, atendo 20, 30 pacientes numa segunda de avaliação, mas é para plana.  
   
 

### 00:33:56

   
**Luiz Jorge:** 90% é plano. E daí?  
**Evelyn La:** Sim, sim. Deixar, né, isso e e focar mais no que realmente vai te fazer caixa, né, vai te trazer aí lucratividade até mesmo para gerar ROI com todo o investimento que você comentou, né? tem que fazer acontecer e vai fazer acontecer como sabendo como vender. Porque nada adianta você ser o melhor especialista e você não ter a clareza de como funciona o processo da venda por trás, porque não é uma venda de padaria, eu falo, né? É um produto que tem o seu valor agregado. Então, tem que saber conversar com o público, certo? Tu tem que saber montar a estratégia para você não perder tempo nessa fase e quando entrar a secretária saber exatamente o que fazer também para não perder a pessoa no meio do caminho. Então esse é o novo mercado de clínicas dos qual do qual a gente tá ajudando vários outros cirurgiões aí já ajudamos alguns e estamos com outros em processo inclusive. E aqui é o nosso sistema, como que a gente trabalha. Então, eh, todas as etapas dos pilares aqui a gente faz de acordo com aquilo que você mais precisa. Então, nós temos todas essas etapas, a gente trabalha de uma forma integrada e a gente personaliza conforme você mais precisa. Então, nós vamos trabalhar funil de marketing, tráfego pago, a gestão do processo, que é onde entra a secretária, né?  
   
 

### 00:35:36

   
**Evelyn La:** tudo o que ela precisa fazer. a gente dá esse suporte e treina inclusive ela. Protocolos para gerar caixa rápido, que é trabalhar uma base da qual você já vai construindo também melhorar os produtos e ofertas suas, ou seja, como a gente consegue agregar valor, quem sabe eh dependendo do procedimento que você já tem para você lucrar ainda mais sobre ele. a gente constrói essa esteira junto contigo, trabalha os funis de venda personalizado que melhor se encaixa pro seu momento e o funil de pré-vendas, que é onde entra a questão de treino e tudo mais pra secretária para ela entender que ela precisa de ela precisa uma mentalidade também, né, para isso. Então, a gente trabalha a questão de mentalidade e trabalha a questão dela eh ter clareza que ela precisa vender o agendamento, né? Eu vou explicar um pouquinho melhor sobre isso. Não é só ser simpática e agendar, não. É por isso que muitas vezes dá taxa de no show, não comparecimento, né? Aquela elas t muito essa visão assim eh eh limitada, né? Do que que é o atendimento. E aqui é onde a gente entra com uma visão bem mais profunda, que é daqui que vem a o faturamento em si, né? começa lá com a abordagem, a captação qualificada, a abordagem para depois sim de fato a gente efetuar a venda.  
   
 

### 00:37:04

   
**Evelyn La:** Então esse é o nosso sistema que a gente constrói junto eh com esse cirurgião, com o empresário. Ali a gente tem todos esses processos prontos, tá? como fazer, mas eh personalizado para o momento do cirurgião. Então, por exemplo, tráfego pago, fone de marketing, ele vai ser personalizado. Os processos comerciais, eles são padrão. Protocolo de caixa rápido, a gente tem protocolos padrões já que é só aplicar para gerar caixa rápido. São estratégias validadas específica. Construção de oferta, ela é personalizada, funil de vendas também. E a parte de treinamento de pré-vendas a gente faz de acordo com o nosso com os nossos protocolos que a gente já tem também, mas aí somos nós que fazemos esse trabalho, né? Esse daqui é o nosso sistema face 100K, Luiz. E aí eu ia te perguntar daqui, tem alguma dúvida, alguma coisa que você gostar?  
**Luiz Jorge:** Tem algum face 500K aí?  
**Evelyn La:** O o temos o mínimo é 100\. O mínimo é 100\. assim, numa realidade ali que eu vou falar 100 no mês para quem tá começando, mas para quem já tem uma boa trajetória, a gente consegue elevar ainda mais. A gente tem cirurgião aí fazendo 260, 300 por semana, dependendo como que tá o fluxo lá,  
   
 

### 00:38:30

   
**Luiz Jorge:** Uhum.  
**Evelyn La:** sabe? Então é bem possível assim, agregando obviamente aqui, ó, valor às ofertas.  
**Luiz Jorge:** Sim,  
**Evelyn La:** O segredo muitas vezes tá em na como você oferta as  
**Luiz Jorge:** sim. Não,  
**Evelyn La:** suas.  
**Luiz Jorge:** eu consigo vender bem valor bem bem assim as as coisas que eu faço,  
**Evelyn La:** Ótimo.  
**Luiz Jorge:** eu vendo bem. Lógico, agora essas cirurgias de fácil,  
**Evelyn La:** Maravilha.  
**Luiz Jorge:** eu tenho cobrado praticamente o material e agora já tô começando a cobrar um pouquinho mais. Não é o que eu quero,  
**Evelyn La:** Mas tá.  
**Luiz Jorge:** mas já tô começando,  
**Evelyn La:** Uhum.  
**Luiz Jorge:** daí uma já vai indicar paraa outra que daí eu vou chegar no patamar. Não, agora é isso e pronto.  
**Evelyn La:** Exato.  
**Luiz Jorge:** Mas eu tenho que ter fluxo para isso. Eu preciso mostrar antes e depois que o pessoal quer ver  
**Evelyn La:** Tem é resultado. É isso aí.  
**Luiz Jorge:** isso.  
**Evelyn La:** Uhum. Eh, se fosse para você escolher aqui da mandala, o que que você escolheria? Assim, umas três, quatro coisas para você startar.  
**Luiz Jorge:** É um tráfego pago, tudo que dê dinheiro aí, tudo que seja rápido.  
**Evelyn La:** o que seja rápido, protocolo de caixa rápido,  
   
 

### 00:39:38

   
**Luiz Jorge:** Ah,  
**Evelyn La:** gestão do processo ali primordial para quem entra do tráfego pago, né? No seu caso,  
**Luiz Jorge:** é tráfego par.  
**Evelyn La:** seria bem esse caminho mesmo, Luiz, a gente trabalhar um posicionamento no Instagram primeiro,  
**Luiz Jorge:** Você chegou a ver meu  
**Evelyn La:** desenhar o Vi, vi.  
**Luiz Jorge:** Instagram?  
**Evelyn La:** Uhum. Eu olhei ali, tem bastante do seu trabalho nos hospitais, né? É.  
**Luiz Jorge:** Uhum.  
**Evelyn La:** Aí seria interessante a gente começar a trazer mais esse resultado. Eu vi que você tem um um tem um outro resultado ali de lifting, né?  
**Luiz Jorge:** É, mas muito pouco  
**Evelyn La:** Aham.  
**Luiz Jorge:** ainda,  
**Evelyn La:** Mas mesmo tendo pouco, dá para se trabalhar muito,  
**Luiz Jorge:** tipo, ele tá fazendo,  
**Evelyn La:** tá?  
**Luiz Jorge:** eu eu posso até conseguir porque eu tô fazendo os cursos ainda. Então, nos cursos que eu tô fazendo, eu posso conseguir essas imagens, que isso que eu tô captando para poder eu ficar postando as imagens do curso lá  
**Evelyn La:** Ótimo.  
**Luiz Jorge:** também.  
**Evelyn La:** Uhum. Não, maravilha. Porque aí seria bem esse caminho contigo, sabe? Trabalhar o quê? funil de marketing comercial primeiro que vai ser o posicionamento, trazer mais cases de sucesso pra gente linkar uma campanha estratégica aqui com o perfil do cliente que você quer atingir.  
   
 

### 00:40:50

   
**Evelyn La:** Rodar o tráfego pago. Quando a gente soltar o tráfego pago, vai entrar o quê? A gestão do processo comercial, que é a secretária, entendendo o que que ela tem que fazer com esse leite qualificado e já o protocolo de caixa rápido pros primeiros meses, né? E aí, conforme a gente vai gerando o fluxo daqui, você vai construindo novas ofertas de valor mais agregado,  
**Luiz Jorge:** Угуm.  
**Evelyn La:** mas primeiro tem que sair o fluxo para aí você eh trabalhar as ofertas em si, né? Mas seria esse caminho mesmo aqui. Então, como que a gente faz isso, né? A gente faz de maneira eh bem assim detalhada. Pode parecer muita coisa, mas não se preocupe que isso daqui a gente, esse trabalho todo aqui é a secretária em si, né, que se responsabiliza e a gente treina ela e fica no pé dela para isso. Então são os funis de aquisição, né, a gente precisa ter junto aí com você, eh, trabalhar isso dentro da clínica. Esses funis de aquisição é o quê? as portas que se abrem para entrar leads, entrar pacientes. Então, a gente tem que ter uma porta aberta lá no tráfego pago, eh, trabalhando indicação, que isso daqui é uma uma técnica que a gente ensina a secretária a fazer, eh, parcerias, network e social cell.  
   
 

### 00:42:11

   
**Evelyn La:** Social Cell vai trabalhar no seu Instagram. Social Cell é uma técnica que a gente ensina também, treina, né? você falou que tem duas pessoas lá, a gente consegue até viabilizar isso, fica mais fácil, que ele vai gerar interação social no seu Instagram. Então, por exemplo, você vai começar a rodar campanhas, vai começar a ter, né, mais posts ali, pessoa vai começar a visitar mais seu Instagram, vai às vezes lá no directo, vai comentar em alguma foto, né, ah, valores, ah, gostaria de saber mais sobre isso. Você não tem tempo para ficar cuidando seu Instagram desse jeito e respondendo. Aí, quem que faz isso? Uma social ser. e ela faz esse pré-social intencional, ou seja, existem mensagens de abordagem e tudo mais específicas nesse pré-social para levar ela para um agendamento e vender, tá? Então esse é o nosso sistema funil de pré-vendas. A gente trabalha o agendamento ali, a mentalidade da secretária, ajuda ela a entender que ela já precisa contornar certas objeções e tudo isso vai levar o quê? a um fechamento de venda mais eh rápido, né? Então, seguir cadências de followup é importante. Porque que que é o follow? Não adianta a pessoa ver e o agendou.  
   
 

### 00:43:32

   
**Evelyn La:** Ela precisa fazer as confirmações certas, nos horários certos. Para quê? para reduzir essa taxa de no show, reduzir às vezes a pessoa acabar se perdendo pelo caminho. Então você tem que manter sempre contato ali com o lead, tem que estar sempre conversando com o paciente e a gente mostra como  
**Luiz Jorge:** Pois é, é isso que eu tô precisando,  
**Evelyn La:** fazer.  
**Luiz Jorge:** porque parece que às vezes o paciente se perde, desmarca ainda remarca.  
**Evelyn La:** Isso se perde mesmo. Aham. Se não tiver um processo aqui nesse entre o agendar e o comparecer, ele se perde. E aí aqui você perde dinheiro. É nesse gap, sabe? Então o que que a gente, aonde a gente entra aqui? Treinar a secretária para ela entender e saber cada etapa o que fazer para que ele de fato venha. Então isso a gente cria um funil de dentro de um CRM, né? que o CRM ele vai ser uma plataforma específica para cuidar essas entradas líde, as etapas e tudo mais. Então a gente tem o treinamento do CRM também para secretária. E a gente tem dois modelos comerciais. Um modelo comercial, que é esse aqui que você tá vendo, é para atuar com os leads novos, ou seja, aqueles que vão vir ou por indicação ou pelo tráfego pago.  
   
 

### 00:44:55

   
**Evelyn La:** toda essa estrutura que você tá vendo, é, pode parecer muita coisa, mas é uma estrutura detalhada, aonde a gente consegue de 40 a 60% de conversão dessas pessoas que vêm através de tráfego pago ou indicação. E essas etapas elas são de extrema importância. são as etapas que a secretária faz, vai, né, eh, precisar fazer ali o passo a passo para que a gente, de fato, tenha eh sucesso aí nas vendas. E o modelo comercial dois é a estrutura utilizada para trabalhar com aquele ex-cliente, ou seja, que veio, fez um procedimento e a gente vai fazer novamente uma interação para tentar vender algo a mais para ele depois. E aquele cliente que ele agendou e não compareceu? ou foi alguém que assim eh se perdeu no meio do caminho ou é uma base que você já tenha contatos às vezes de pessoas que vieram de outras eh para outros motivos e agora você vai ter um novo produto. Então, a gente tem esses dois tipos de modelo de comercial, de estruturação comercial, que é onde as secretárias entram para trabalhar, tá? Então, o primeiro vai se fazer para trabalhar estratégias pros novos e o segundo para trabalhar a sua base, que é onde tem muito dinheiro parado. A gente fala às vezes dinheiro que você pode estar rodando, criando novas campanhas, isso tudo a gente cria para você junto.  
   
 

### 00:46:29

   
**Evelyn La:** Eh, e você precisa, faz protocolo de caixa rápido, que a gente diz, e não precisa ficar investindo toda a hora em tráfego pago também. Então, trabalhando esses dois modelos comerciais aí estruturados, bem alinhado, com posicionamento, estratégia de marketing, a gente vai ter um setor de alta performance, né? Uma esteira de produtos bem organizada, uma precificação legal. Então, tudo isso vai gerar realmente o setor de alta performance. A gente cria isso eh com você de forma personalizada ali, mas nós temos os scripts e processos de vendas pronto paraas secretárias. Eu falo assim, é um copia e cola, né? É um copia e cola. O que que é o script, né? É todo a parte realmente de como que elas tem que falar, eh, responder o cliente, quanto tempo de cada resposta. Então, tudo isso a gente tem as informações que elas precisam para fazer um trabalho bem feito, um agendamento personalizado, a gente tem. Então aqui entra toda a construção de ofertas também, né? Dentro da mandala a gente tem dentro dos nossos pilares ali. Então nós temos assim aqui é são preços hipotéticos, tá? A gente coloca só para você entender que o quê? Eh, o produto mais barato da sua esteira, ele vai servir como um produto isca, inclusive para as campanhas, que vai ser para elevar o nível de consciência das pessoas.  
   
 

### 00:47:57

   
**Evelyn La:** Eh, e aí a gente vai trabalhar também campanhas específicas para cada produto. Então, ah, eh, campanha para parte de blefero, campanha para a parte de lifting, mas a gente sempre vai ter um isca. Que que é o isca? aquela pessoa que não conhece o Luís, que agora vai conhecer e através desse anúncio aqui vai vir para conhecer e vai ver o quanto que o Luiz pode ajudar ela e o quanto que ele tem de solução para pro momento atual. Então a gente cria uma esteira de produto junto com você, novas ofertas, ofertas atraentes, né, que a gente diz, e gera também protocolos de caixa rápido, que é o que eu falei, onde tem muito dinheiro parado e a gente consegue movimentar. Então, nós temos oito tipos de protocolos para aceleração de caixa. Então, são cada protocolo é uma estratégia diferente que a gente ajuda a aplicar e a criar caixa sem necessariamente você investir em tráfego pago. Esses protocolos aqui também quem executa são ex secretárias, tá? gestão do processo, não ter métricas aí para você entender. A gente deixa isso também muito claro para você, toda a gestão do processo, você saber o que que vai ser feito, como que vai ser feito. E o tráfego pago, que aí é a geração de anúncios e toda a construção do seu posicionamento, definição de público e estratégia para gerar o tráfego pago.  
   
 

### 00:49:27

   
**Evelyn La:** Então, até aqui, Luiz, eh, eu te apresentei sobre a nossa metodologia, né? é o que engloba esses pilares. Esse é o nosso método que faz clínicas aí faturarem 100k no mínimo mês, né? E aí eu queria te perguntar, eh, fez sentido para você? Gostou?  
**Luiz Jorge:** Não, com certeza.  
**Evelyn La:** Que que você achou?  
**Luiz Jorge:** Interessante. Na teoria é lindo. Vai na prática. Aí já é perfeito.  
**Evelyn La:** Vamos ver.  
**Luiz Jorge:** Legal. muito interessante,  
**Evelyn La:** Legal. Que que você mais gostou?  
**Luiz Jorge:** não de todo o processo de treinamento de funcionário, de protocolos, que eu acho que é importante. Uma coisa que hoje em dia, como eu trabalho para cacete, eu não tenho tempo para sentar, para ficar pensando no que eu tenho que fazer.  
**Evelyn La:** Se exato.  
**Luiz Jorge:** Então, quando eu tenho tempo, aí sim. Tanto que agora eu tô dividindo o consultório para particular. Quando é no dia de particular, eu já deixo o capal de café expresso pra secretária servir, já peço um bolo, um salgado para deixar de Então assim, a gente vai aos poucos pensando, mas eu não tenho tempo para est toda hora pensando nas melhorias,  
   
 

### 00:50:33

   
**Evelyn La:** pensando legal.  
**Luiz Jorge:** nas coisas para fazer, porque não tenho tempo para isso.  
**Evelyn La:** Eh, bem, é exatamente, é isso.  
**Luiz Jorge:** Tem coisas que eu precisava treinar na secretária.  
**Evelyn La:** Ah.  
**Luiz Jorge:** Não tenho tempo para isso, mas eu precisaria, por exemplo, um pós-operatório que eu tava vendo ali, p\*\*\*\*, liga daqui a 2 horas pr pra paciente. E aí, você chegou bem? Tá tudo bem? Como é que foi? Você tá com dor? Não tá com dor?  
**Evelyn La:** Isso.  
**Luiz Jorge:** Aí no outro dia, poxa, e aí, você tá bem? Você pode bater uma foto pra gente ver como é que você tá? Tal, se tá inchado,  
**Evelyn La:** Aham.  
**Luiz Jorge:** não tá? Então, essas coisas é importante. O paciente se sente, sabe, eh, bajulado, querido. Então isso é importante, esse feedback para tá tá babando a paciente,  
**Evelyn La:** Exatamente.  
**Luiz Jorge:** fala: "Olha, poxa, ele tá se importando comigo". Então, ela tinha que tá ligando. Olha,  
**Evelyn La:** Exato.  
**Luiz Jorge:** liga daqui a uma hora, liga para saber como é que tá, se chegou bem. Daqui a manhã liga para saber se tá inchado, tá com doce,  
   
 

### 00:51:25

   
**Evelyn La:** Uhum.  
**Luiz Jorge:** tá tudo bem. No outro dia também, assim, sei lá, dois dias depois. Então, fazer um protocolo sobre isso eu acho que é  
**Evelyn La:** Sim. Exato. É, é de suma importância mesmo esse acolhimento, né? que é a partir daí que você muitas vezes vai o quê? Fidelizar esse paciente, ganhar indicação e é assim que começa a a girar, né? E assim, Luís, vendo tudo que a gente entrega, o que a gente faz, você acredita que isso aqui te ajudaria a bater esse faturamento almejado para ficar mais  
**Luiz Jorge:** Não, com certeza.  
**Evelyn La:** tranquilo, passar  
**Luiz Jorge:** Espero que sim. A intenção é essa, né? Então, pelo que você tá me mostrando aí,  
**Evelyn La:** mais.  
**Luiz Jorge:** acredito que sim, que a intenção é essa. Então, pelo acho que vocês devem ter pelo jeito de experiência e tem organização, eu acho que tem tudo para dar certo.  
**Evelyn La:** Muito bem. Então, eu vou te mostrar agora como que funciona a nossa parceria de aceleração. Como eu te falei, nós somos uma aceleradora de clínicas e vou te mostrar exatamente como é que a gente implementa essas estratégias dentro da clínica e treina a sua a sua seus funcionários. Primeira coisa, o programa consiste em um ciclo de 6 meses.  
   
 

### 00:52:42

   
**Evelyn La:** Então são se meses de acompanhamento com foque em realmente aceleração, eh ferramentas e processos já prontos só para aplicar, né? Aí, claro, um aprendizado e treinamento com o time, o time que eu digo, o time do cirurgião, no caso. Então, a gente tem um plano start, aí a gente faz um plano start para longo de toda a jornada dos seis meses e o plano de ação individual. Então, nós fazemos reuniões aí, checkpoints a cada 15 dias, reuniões individuais com o empresário, né, no caso contigo, para realmente a gente trazer o quê? as estratégias que a gente vai começar a aplicar, que a gente vai começar a movimentar. Protocolo de aceleração de caixa rápida é a primeira coisa que a gente já libera para ser aplicado, porque é onde você já consegue fazer faturamento de fato aí sem precisar investir em tráfego pago. Grupo de WhatsApp, então a gente monta um grupo, cria um grupo específico VIP, aonde vai est só você e nós da equipe que vamos cuidar de toda a implementação. e criamos um outro grupo para colocar o seu time comercial, no caso ali suas duas secretárias e o nosso time que vai treinar elas. Então a gente tem o grupo separado porque a conversa é diferente, né? E elas ali, o grupo é para tirar dúvida, para passar feedback, para quando elas precisar de ajuda em alguma coisa específica, elas podem chamar ali a qualquer momento.  
   
 

### 00:54:11

   
**Evelyn La:** As meninas estão sempre respondendo. Durante a semana, toda todos os dias, de segunda a sexta-feira, a gente faz tutoria. Essas tutorias é para quê? Treinar, tirar dúvidas e alinhar o que tá sendo feito dentro da clínica. Então é para as funcionárias, todos os dias às 11 da manhã a gente tem uma um tema, né, pré-venda, venda, social selling. E aí a gente vai treinar, treinar elas, elas precisam assistir alguns conteúdos, a gente vai puxar eh com elas isso para saber se elas de fato estão fazendo, estão assistindo e a gente abre para pergunta, para tirar dúvidas, para elas trazerem também caso elas estão tenham estão tendo alguma dificuldade. Então essas tutorias elas servem para isso e claro dentro do grupo a gente também fica à disposição para tirar dúvidas a qualquer momento. E caso seja necessário, por exemplo, marcar uma tutoria individual com alguma delas para trabalhar algo em específico, a gente faz isso também, tá? Então, a gente disponibiliza a trilha de conteúdo para elas assistirem, entender primeiro na teoria o que que precisa fazer. E a gente nas tutorias aqui todos os dias a gente vai o quê? Tanto ver se ela realmente tá fazendo e se ela vai ter alguma dificuldade, aonde a gente consegue ajudar, tá? Tudo isso dentro de documentos, né?  
   
 

### 00:55:41

   
**Evelyn La:** a gente tem todos os processos comerciais aí eh a seu dispor. Treinamento, então paraa parte de vendas, no caso, eh se você resolver que você vai ser o vendedor, a gente vai te ajudar nesse sentido. Se você for delegar essa função para alguém, a gente vai treinar essa pessoa para ela aprender a vender. Por quê? Porque primeiro ela vai ter que lidar com o contorno de objeções, ela vai ter que saber eh analisar muitas vezes o perfil comportamental para como conversar com aquela pessoa. Então, a gente vai treinar esse essa parte de vendas, vai treinar o SDR, que a gente diz, é o pré-vendedor, né, que é a secretária. Então, a gente vai treinar ela também nesse sentido de ela entender o que que ela precisa fazer depois que o Lead entrou em contato com ela e mandou um oi. qual a abordagem, como vender um agendamento, como trabalhar essa mentalidade nela para ela vender o agendamento, porque é diferente de agendar, né? Se ela já está vendendo, querendo ou não, o Luís ali. Então ela precisa gerar essa emoção, precisa gerar esse interesse quando precisa manter ele aquecido e ela entender todas as cadências e toda aquela estruturação lá de followup, que é de suma importância. esse pós cirúrgico que você comentou, uma coisa que a gente ajuda a estruturar também, porque isso aumenta depois os seios farm que a gente fala que é o quê?  
   
 

### 00:57:04

   
**Evelyn La:** Essa revenda, né? Então a gente treina essa secretária para isso e treina o social selling, que é a pessoa que cuida da interação social do seu Instagram ali depois. O social cell não é uma coisa assim tão de urgência. Ele começa a ser mais interessante quando você começa a rodar mais campanha, quando você começa a alimentar mais e se posicionar no Instagram de acordo com o público que você quer atingir. Aí é interessante você começar a pensar sobre social selling, tá? Mas não é algo urgente. O mais urgente aqui é pré-vendas, secretária e vendas. Esse é o urgente. Isso a gente disponibiliza dentro de um CRM, então, para fazer eh toda essa gestão de os leades que vão chegar, como que eu vou eh colocar as mensagens ali, como eu vou gerir isso, a gente disponibiliza um CRM, treina as pessoas para usar esse CRM, ele vai te dar métricas, ele vai te dar dados. A gente tem um gestor de tráfego, que foi o que eu te falei, nós temos o gestor nosso, mas caso você queira continuar com o seu, não tem problema. Outro bônus é o Flashbd, que é um o painel comercial aí pra gente trabalhar todas as métras e a os modelos de apresentação, playbook, gravação, script, tudo isso documentado também fica à sua disposição aí por tempo ilimitado.  
   
 

### 00:58:29

   
**Evelyn La:** Até aqui, alguma dúvida referente a como a gente trabalha a metodologia aplicada, Luiz,  
**Luiz Jorge:** Até agora não tá tudo tudo bem, muito bem explicado.  
**Evelyn La:** tudo certo? Gostou da do nosso acompanhamento,  
**Luiz Jorge:** Hum, com  
**Evelyn La:** a forma como a gente faz?  
**Luiz Jorge:** certeza.  
**Evelyn La:** Uhum. A as tutorias ali, que que você  
**Luiz Jorge:** Não é interessante. Eu acho que tem que ter,  
**Evelyn La:** achou?  
**Luiz Jorge:** porque eu não tenho tempo para pensar. Outra coisa, eu tenho, a gente tem o WhatsApp do consultório, aí eu não tenho tempo de sentar para montar aquelas frases bonitinhas lá que coloca: "Oi, tudo bem?" e tal,  
**Evelyn La:** É tudo isso a gente tem.  
**Luiz Jorge:** aquele negócio de ou tipo, sei lá,  
**Evelyn La:** Uhum.  
**Luiz Jorge:** montar com um negócio de para dar uma resposta assim mais ou menos, negócio de agendamento. Então, não sei, eu tenho, eu tenho que ter tempo para fazer essas coisas, entendeu? Coisa que eu não  
**Evelyn La:** Uhum. Exato. É, e tudo isso é o que a gente resolve para você, né? Trazendo o quê?  
**Luiz Jorge:** tenho.  
**Evelyn La:** Os scripts prontos ali, treinando a secretária da maneira como que ela tem que aplicar.  
   
 

### 00:59:23

   
**Evelyn La:** E só, inclusive dentro do CRM a gente tem automações que mandam mensagens automáticas. a gente integra aí o WhatsApp e manda as mensagens automáticas dessas confirmações. Então,  
**Luiz Jorge:** É, eu tenho um programa de gestão também que eu eu acho que o programa ele manda faz essas,  
**Evelyn La:** professor.  
**Luiz Jorge:** mas vamos ver, eu acho que ele manda essas mensagens automáticas, só que eu tenho que contratar essa parte de mensagem para mandar pro paciente de confirmação,  
**Evelyn La:** Uhum.  
**Luiz Jorge:** porque ela te ela faz ela faz o contato com os pacientes de confirmação,  
**Evelyn La:** Aham.  
**Luiz Jorge:** mas eu tenho um programa que pode mandar mensagem, pode mandar e-mail, pode mandar, sei lá, WhatsApp,  
**Evelyn La:** Uhum.  
**Luiz Jorge:** próprio programa que eu tenho de gerenciamento do consultório de agendamento, de tudo,  
**Evelyn La:** Certo, entendi.  
**Luiz Jorge:** que é o easal,  
**Evelyn La:** A gente pode junto avaliar como que tá esse seu programa  
**Luiz Jorge:** fica tudo na nuvem, tipo tudo na nuvem.  
**Evelyn La:** hoje.  
**Luiz Jorge:** Eu abro a minha agenda do celular, abro a minha agenda daqui do computador, então tudo em nuvem,  
**Evelyn La:** Ah,  
**Luiz Jorge:** entendeu?  
**Evelyn La:** legal,  
**Luiz Jorge:** Gerencio, pagamento, tudo eu faço por lá.  
**Evelyn La:** entendi. Uhum.  
**Luiz Jorge:** Orçamento,  
**Evelyn La:** E aí tem a parte que elas podem ter o acesso para fazer essas essas confirmações  
   
 

### 01:00:26

   
**Luiz Jorge:** né? Sim.  
**Evelyn La:** aí,  
**Luiz Jorge:** É.  
**Evelyn La:** tá? Não, bacana. Legal. Dá para ver como que funciona ele e ela só ajustar as mensagens ali e a gente conseguir auxiliar nesse processo, né, de automação ali, quem sabe tudo mais.  
**Luiz Jorge:** Ó, aqui eu, ó, vou te dar um exemplo aqui,  
**Evelyn La:** Mas  
**Luiz Jorge:** eu tenho, então, e tá ruim da luz, ó. Mas eu tenho toda aqui, daí eu vou vendo por dia,  
**Evelyn La:** entendi  
**Luiz Jorge:** aí, tipo, na segunda-feira, olha aí como eu tenho fluxo, só que 90% é, ó. Tá vendo? Tem de só segunda de manhã. Isso aí tudo consulta.  
**Evelyn La:** Sim,  
**Luiz Jorge:** Esses amarelos faltaram e os azuis confir foram. Forte essa carrinha.  
**Evelyn La:** entendi.  
**Luiz Jorge:** Então assim, fluxo eu tenho, mas eu preciso ter mais fluxo de particular. Eu atendo Unimédia,  
**Evelyn La:** tem é o que vai fazer o seu é o que vai fazer você mudar  
**Luiz Jorge:** temô e Petrobras.  
**Evelyn La:** de de nível no sentido assim, eh, trabalhar com uma performance de um ticket melhor, eh vender mais, vender mais caro, vamos dizer assim também, né? E ter mais qualidade de vida.  
   
 

### 01:01:44

   
**Evelyn La:** é trabalhar realmente essa essa esse quesito aí do particular, que é onde vai te trazer é o particular que vai te trazer a tranquilidade para você eh largar hoje o o tanto de prestação que você faz pros hospitais ali, né? Então, é como você comentou lá no início. E a e aí eu te pergunto, até agora, ficou claro para você? Ficou claro sobre a nossa atuação, sobre como que é a nossa empresa?  
**Luiz Jorge:** Sim, sim.  
**Evelyn La:** Legal. Você acredita aí que a gente conseguiria te ajudar?  
**Luiz Jorge:** Acredito que sim. Espero que  
**Evelyn La:** Parab. Vamos lá. Com certeza.  
**Luiz Jorge:** sim.  
**Evelyn La:** Não tenho dúvidas. Então, a gente faz essa parceria junto com você por se meses e vamos falar sobre o valor, então, né?  
**Luiz Jorge:** Bora. Deixa eu,  
**Evelyn La:** Vamos falar um pouquinho sobre Vai lá.  
**Luiz Jorge:** deixa eu tomar uma água com açúcar aqui rápido. Não tô brincando.  
**Evelyn La:** Se quisesse eu esperava, não tinha problema não. Bom, eu sempre digo o seguinte, Luiz, valor diferente de preço, né? valor é tudo que realmente de fato a gente coloca na ponta do lápis às vezes ali, pós putz, valeria tanto.  
**Luiz Jorge:** is  
**Evelyn La:** Preço vai ser eh relação ao que você paga para ter acesso.  
   
 

### 01:02:58

   
**Evelyn La:** Então existe uma diferença aqui. O valor do programa ele seria se a gente fosse colocar as calls, tutoria, tudo isso na ponta do lápis que eu te mostrei, ele seria incluindo, né, o CRM que você não precisa pagar, ele seria esse valor aqui. Se fosse olhar pelo valor, tá? Óbvio que não é esse valor aqui, mas se eu te falasse assim, Luiz, você vai ter quase quase que precisou da água com açúcar,  
**Luiz Jorge:** Já quase eu desmaiei aqui já.  
**Evelyn La:** hein?  
**Luiz Jorge:** Quase,  
**Evelyn La:** E eu falei que eu esperava,  
**Luiz Jorge:** quase quase.  
**Evelyn La:** hein? Mas se eu te falasse assim, Luí,  
**Luiz Jorge:** Olha.  
**Evelyn La:** se hoje, olhando só pelo valor e tudo que a gente entrega, o treinamento que a gente vai fazer com as secretárias, enfim, se você pudesse ter 75% de desconto sobre o valor que tá aqui hoje, vocês se considerariam um acelerado nosso? Olhando por pelo valor, não tô falando de preço ainda, tá? Olhando pelo valor, do valor que tem o programa,  
**Luiz Jorge:** Uhum.  
**Evelyn La:** 75% de desconto, vocês tornariam  
**Luiz Jorge:** Pois é. Eu vou te dar um exemplo. Se fosse esse 67.000.  
**Evelyn La:** acelerado.  
   
 

### 01:04:04

   
**Luiz Jorge:** Um exemplo, tipo, hoje eu não teria condições porque eu tô em fase de mudança e eu tô gastando tudo que eu tenho que eu não tenho. Eu vendi até uma, eu tinha tenho uma rã, vendi agora para poder eu tentar me mudar, porque eu tô até hoje na casa, eu tô desde agosto na casa dos meus pais. Então assim,  
**Evelyn La:** Certo.  
**Luiz Jorge:** é por isso que eu tô te falando que eu preciso movimentar o quanto antes, porque eu me desfiz de um carro que eu gostava, porque era uma minha rã para poder tentar me mudar, porque já visto que obra, apartamento, é uma fábrica de dinheiro e nunca não tem, é um posto sem fim. Então, ainda que eu tô pretendendo me mudar agora em março, ainda eu tô gastando uma fortuna, ainda falta muita coisa. Então assim,  
**Evelyn La:** Certo?  
**Luiz Jorge:** a gente tem que ver realmente esses valores para poder ver se realmente a gente vai ter condições de começar a fazer esse  
**Evelyn La:** Tá,  
**Luiz Jorge:** processo  
**Evelyn La:** entendi. Então assim, hoje você tá com custo alto fixo aí, pelo que você tá me  
**Luiz Jorge:** gigantesco no cartão.  
**Evelyn La:** falando,  
**Luiz Jorge:** Eu tô quase queimando todo meu dinheiro do meu carro que eu vendi agora, final de começo de  
**Evelyn La:** tá? o que que você teria hoje de eh disposto assim para você poder investir,  
   
 

### 01:05:05

   
**Luiz Jorge:** janeiro.  
**Evelyn La:** porque daí o que que o que que eu quero te falar assim para te ajudar já você começar realmente movimentar, eu personalizar ainda mais eh contigo ali a parte do do programa, sabe?  
**Luiz Jorge:** What?  
**Evelyn La:** Mas para eu entender o que que você mais ou menos teria hoje em mente assim, falar a Evelyn, por mês aí, por uma parcela mensal,  
**Luiz Jorge:** Pois é,  
**Evelyn La:** quem sabe eu conseguiria,  
**Luiz Jorge:** eu não tenho nem noção para te falar a verdade, porque como eu nunca fiz, eu não tenho noção, entendeu? Assim, eu nunca fiz isso.  
**Evelyn La:** tá?  
**Luiz Jorge:** Eu tô procurando ajuda, mas eu não tenho noção de valores. Eu não tenho noção de como fun de agora como funciona, porque tu me explicou, mas eu não tenho noção de nenhuma de  
**Evelyn La:** Certo? Tá. Vamos lá então.  
**Luiz Jorge:** valores.  
**Evelyn La:** Esquecendo o preço aqui, esquecendo esses números que você viu, só pelo valor do que a gente entrega, você acredita que um mês a gente conseguiria tirar você da estagnação?  
**Luiz Jorge:** É, espero que sim. A intenção é  
**Evelyn La:** Tá? Mas mais uma vez,  
**Luiz Jorge:** essa.  
**Evelyn La:** pelo valor que a gente entrega de tudo que a gente vai fazer junto com você, o treinamento, você acredita que a gente conseguiria fazer isso juntos?  
   
 

### 01:06:17

   
**Luiz Jorge:** Acredito que sim.  
**Evelyn La:** Maravilha.  
**Luiz Jorge:** Aí vai depender de tudo, forma de pagamento,  
**Evelyn La:** Claro,  
**Luiz Jorge:** tudo aí direitinho,  
**Evelyn La:** claro, claro. Não, perfeito.  
**Luiz Jorge:** entendeu?  
**Evelyn La:** Mas eu queria entender assim, se de fato você viu o sentido e e acredito que nós podemos te  
**Luiz Jorge:** Não. Sim. Não. Na teoria é indo,  
**Evelyn La:** ajudar,  
**Luiz Jorge:** entendeu? Tá  
**Evelyn La:** questão de preço aqui, a gente vai é resolvido quanto a isso.  
**Luiz Jorge:** perfeito.  
**Evelyn La:** É tranquilo. É só realmente fato para eu entender aqui se você viu sentido e acredito que a gente consegue  
**Luiz Jorge:** Não. Sim, sim,  
**Evelyn La:** junto.  
**Luiz Jorge:** sim. A teoria é bonito. Tipo,  
**Evelyn La:** Sim,  
**Luiz Jorge:** eu espero que vá funcionar,  
**Evelyn La:** eu sei, eu sei.  
**Luiz Jorge:** entendeu?  
**Evelyn La:** Sim. Vamos lá então.  
**Luiz Jorge:** que a intenção é essa,  
**Evelyn La:** Vamos trazer com  
**Luiz Jorge:** é por isso que senão não tava procurando, porque eu preciso de ajuda,  
**Evelyn La:** certeza quem vai junto com  
**Luiz Jorge:** de orientação, eh, uma pessoa que a cabeça pensante,  
**Evelyn La:** você.  
**Luiz Jorge:** que coisa que eu não tenho tempo fazer. Então é isso que  
**Evelyn La:** Perfeito. Perfeito. Então, vou te trazer alguns exemplos de algumas pessoas que, assim como você também acreditaram no potencial que a gente poderia fazer juntos.  
   
 

### 01:07:13

   
**Evelyn La:** Uma delas é a Dra. Débora. Fechada aqui, ó. 5 dias, 100 mais de R$ 100.000. A DFne, que também foi uma superação aí, 125.000, ela fez de faturamento aí uma semana. O Dr. Maxuell, que é um que vem seguindo certinho nossos processos também e vem tendo bastante resultado, né? o faturamento dele aqui,  
**Luiz Jorge:** E como vocês fariam essa captação rápida para aparecer a paciente particular assim do  
**Evelyn La:** ó,  
**Luiz Jorge:** nada?  
**Evelyn La:** com alinhamento do seu perfil, posicionamento e estratégia de marketing.  
**Luiz Jorge:** Mas isso tudo pelo  
**Evelyn La:** Todo pelo Instagram.  
**Luiz Jorge:** Instagram.  
**Evelyn La:** Todo pelo Instagram. Uhum. Então, hoje o seu Instagram, que que a gente, primeira coisa que a gente ia fazer, movimentar ele para a gente fala assim,  
**Luiz Jorge:** M.  
**Evelyn La:** tornar o o mínimo viável possível, vamos dizer assim. pra gente conseguir fazer uma boa captação,  
**Luiz Jorge:** Yeah.  
**Evelyn La:** usar já do que dos cases que você tem, que você falou que você tem ali, né? A gente você manda esse material para nós e aí a gente vai linkar e fazer campanha a partir desse material que você envia para nós. São as fotos dos seus resultados,  
   
 

### 01:08:23

   
**Luiz Jorge:** Uhum.  
**Evelyn La:** basicamente,  
**Luiz Jorge:** Aí vocês que montariam as coisas,  
**Evelyn La:** tá?  
**Luiz Jorge:** então.  
**Evelyn La:** Sim. A gente que monta a campanha. O que que a gente sempre vai pedir uma hora ou outra? um vídeo aparecendo você falando, mas não é uma coisa assim, não é toda semana a gente vai precisar ali material pra gente  
**Luiz Jorge:** Então, se precisar a gente vai ter que começar a fazer,  
**Evelyn La:** poder  
**Luiz Jorge:** porque é importante aparecer. Não adianta tá só mostrando figurinha,  
**Evelyn La:** Sim, não é assim,  
**Luiz Jorge:** fotinho e vídeo dá muito mais engajamento.  
**Evelyn La:** até mesmo por para uma campanha muito e assim a campanha para ela gerar uma uma eficácia é importante aparecer, é importante você fazer uma chamada ali, uma CTA que a gente diz, né, que é uma chamada para ação, mas isso tudo a gente direciona você de como fazer, tá? A gente vai te explicar, vai te mostrar, vai alinhar certinho com você esses detalhes. A gente vai basicamente de você, do seu tempo, a gente vai precisar o quê? você gravar o vídeo, mandar pra gente, a gente definir com você as estratégias principais ali de posicionamento e captação de perfil que você quer atingir e todo outro trabalho a gente que faz, tá? Então é isso. Eh, você executar a sua parte e a gente executar em excelência também a nossa parte,  
   
 

### 01:09:42

   
**Luiz Jorge:** Sim. E os valores?  
**Evelyn La:** sabe?  
**Luiz Jorge:** Me conte logo antes que eu que eu caio aqui.  
**Evelyn La:** Vamos lá, então, alguns que aqui que acreditaram, né? Olha aí, ó, usando só o nosso script de venda. R$ 238.000. Não vou ler todos eles, tá? 96 em 17 dias, mas alguns exemplos do que a gente tem hoje, dos nossos acelerados. O valor, lembra que eu te pedi um sim ou não? Então, o sim ou não é para quê? Hoje, se você falar assim para mim, Evelyn, não tem como, não tem como a gente dar esse passo agora pro programa de aceleração completo, se meses, com tudo que tem nele aqui, os bônus, as trilhas e tudo mais, o seu não, ele tem um valor de 51.000 à vista ou oito de 740, tá? Esse é o valor do não. Por que o valor do não, Evelyn? Porque você falar para mim, eu vou precisar dois, três, 4 meses para eu analisar por algum outro motivo que que você já comentou aqui comigo, até que você tá tendo outros gastos. Eh, esse vai ser o valor do seu não. Agora você falar para mim, Evelyn, eu estou disposto e eu fecho com você hoje na call, na call eu tenho um valor diferenciado para esse programa de 6 meses.  
   
 

### 01:10:53

   
**Evelyn La:** Fechando comigo hoje o valor do seu sim, que vai me gerar toda a nossa economia administrativa e financeira, inclusive reduzindo os nossos custos de remarketing. De 51, ele fica por 42 à vista ou quatro de ou 12 de 4200\. Esse é o valor do seu sim para call, para fechar aqui comigo hoje e ter todo o programa de aceleração de 6 meses.  
**Luiz Jorge:** Aí, qual é a minha insegurança? Tipo,  
**Evelyn La:** Vamos lá.  
**Luiz Jorge:** e se não der certo um exemplo, entendeu? p\*\*\*\*, aí porque quando eu te falei,  
**Evelyn La:** Tá,  
**Luiz Jorge:** eu tô investido em material, cursos e no meu apartamento que eu não consigo me mudar.  
**Evelyn La:** tá, tá  
**Luiz Jorge:** Então assim, eu tenho um um cartão de crédito meu que é só de curso.  
**Evelyn La:** certo,  
**Luiz Jorge:** Então só esse cartão eu vou pagar até novembro 10.000 por mês. Só de curso.  
**Evelyn La:** tá  
**Luiz Jorge:** O meu pessoal que eu tô gastando com obra,  
**Evelyn La:** certo.  
**Luiz Jorge:** não sei o quê, não sei o quê, não sei o quê, tô gastando muito mais de 30\.  
**Evelyn La:** Certo?  
**Luiz Jorge:** Então eu tenho que pensar  
**Evelyn La:** Tá. Tá. Mas deixa eu entender. Vamos lá.  
   
 

### 01:11:54

   
**Luiz Jorge:** aqui.  
**Evelyn La:** Pera aí. A sua questão seria só mais o receio do investir e não ter retorno  
**Luiz Jorge:** Aham. Sim, sim, sim.  
**Evelyn La:** ou seria algo mais financeiro mesmo de para ter esses  
**Luiz Jorge:** Não, investir, tipo, a gente dá um jeito, mas é investir não tem  
**Evelyn La:** tá. Não. Vamos lá então. Deixa eu,  
**Luiz Jorge:** retorno.  
**Evelyn La:** se eu trouxesse o Renan aqui, que é o nosso sócio, para ele te falar sobre garantias, que que você acha? Posso chamar ele rapidinho?  
**Luiz Jorge:** E esse aí é o menor preço mesmo. Menor, menor preço. Não.  
**Evelyn La:** É, esse é para fechamento em call. Aham. Ficaria 4 12 de 42 ou os 42\. Deixa eu falar com o Renan aqui pra gente pra gente conversar, porque sobre a questão da garantia ali, a gente consegue até trabalhar isso. S. Deixa eu passar aqui, colocar você para trocar uma ideia com Ren aqui.  
**Luiz Jorge:** Aí começaria em março. Isso hoje carnaval não todo mundo  
**Evelyn La:** Começa hoje.  
**Luiz Jorge:** tomando gelada. Não,  
**Evelyn La:** Não, mas é o que que seria, Luía? A gente fechando hoje,  
   
 

### 01:13:19

   
**Luiz Jorge:** não.  
**Evelyn La:** eu já crio o grupo VIP, né? Já crio o grupo VIP, já coloco a nossa equipe lá que vai cuidar junto com você da empresa já. Ó o ó, ó o dono aí, ó. Ó o cabeça nosso aí, ó.  
**Luiz Jorge:** É esse aí?  
**Evelyn La:** O nosso Esse aí,  
**Luiz Jorge:** É,  
**Evelyn La:** esse aí que vai fazer acontecer,  
**Luiz Jorge:** será? Olha,  
**Evelyn La:** Luiz.  
**Luiz Jorge:** rapaz.  
**System Digital:** Boa noite, seu Luiz,  
**Luiz Jorge:** Tudo bem?  
**System Digital:** como que você tá?  
**Luiz Jorge:** Boa noite. Tranquilo.  
**Evelyn La:** Aí,  
**System Digital:** Que que tá acontecendo  
**Evelyn La:** Luía, o que que seria?  
**Luiz Jorge:** Se se não der certo,  
**Evelyn La:** Eu aí,  
**Luiz Jorge:** ele devolve em dobro,  
**System Digital:** aqui?  
**Luiz Jorge:** né?  
**Evelyn La:** ó. É isso aí,  
**Luiz Jorge:** É esse que é que é o homem,  
**Evelyn La:** ó.  
**Luiz Jorge:** né?  
**System Digital:** Vamos lá.  
**Evelyn La:** Esse é o homem.  
**System Digital:** Qual que é a dúvida? Fala para mim.  
**Luiz Jorge:** Dinheiro, gastar, quer dizer, investir e retornar.  
**System Digital:** Show de bola. Da onde que você é?  
**Luiz Jorge:** Sou de Belém.  
**System Digital:** Belém. Show. E hoje você é especial. A sua especialidade é qual?  
   
 

### 01:14:15

   
**Luiz Jorge:** Cirurgião Buco Maxilo, dentista. Cirurgião Buco Maxilo.  
**System Digital:** Show. Qual que é o seu faturamento atual hoje?  
**Luiz Jorge:** Pois é, cara. É muito é muito relativo isso,  
**System Digital:** Ah, precisa mesmo entrar  
**Luiz Jorge:** porque tem os fixos e variáveis, entendeu?  
**System Digital:** mesmo.  
**Luiz Jorge:** Então assim, não é muito relativo isso. Posso te falar que de, sei lá,  
**System Digital:** Mais uma média.  
**Luiz Jorge:** de 30,  
**System Digital:** Uma média só pra  
**Luiz Jorge:** 30 a 60, depende.  
**System Digital:** gente.  
**Luiz Jorge:** Tem tem mês que fica nos 30, tem mês que vai para mais. tem, é muito relativo isso,  
**System Digital:** Show. E qual que é o teu objetivo dentro desses se meses  
**Luiz Jorge:** porque como eu não sou funcionário, ah,  
**System Digital:** aí?  
**Luiz Jorge:** ganhar uns 500k por mês, entendeu? Andar de Ferrari, de poste, viajar de primeira classe todo mês para para passar o final de semana aqui na aqui em Miami voltar. É esse que é o objetivo de vida, entendeu? Curtir a família,  
**System Digital:** pros pros próximos seis meses,  
**Luiz Jorge:** os filhos,  
**System Digital:** qual que é o objetivo?  
**Luiz Jorge:** me aposentar.  
**Evelyn La:** Ele tá iniciando.  
   
 

### 01:15:07

   
**Luiz Jorge:** Não, cara, é trabalhar menos, ganhar mais.  
**Evelyn La:** Ah.  
**System Digital:** Não, com certeza.  
**Luiz Jorge:** É esse meu objetivo,  
**System Digital:** Mas vamos lá.  
**Luiz Jorge:** que eu trabalho de domingo a domingo, cara. Então eu preciso ganhar muito mais e trabalhar muito  
**System Digital:** Não,  
**Luiz Jorge:** menos ou que trabalhe mais do que eu trabalho,  
**System Digital:** isso com certeza. Mas vamos lá.  
**Luiz Jorge:** mas que ganhe muito mais, que a preguiça eu não tenho. Então assim, eu trabalho de domingo a domingo, então vendo dinheiro, a hora que for eu vou me chamo duas, 3, 4, 5 da manhã. Então,  
**System Digital:** Boa.  
**Luiz Jorge:** o meu meu meu problema não é não é trabalho, é só ser mais bem remunerado pelo  
**System Digital:** Entendi. Com certeza.  
**Luiz Jorge:** trabalho.  
**System Digital:** Mas vamos lá, só para mim ter clareza, porque aquele negócio, né? Se a gente não sabe para onde a gente vai, qualquer lugar, tá bom? Então, dentro dos de 6 meses, qual que é o seu objetivo?  
**Luiz Jorge:** Cara, é movimentar o consultório. Tipo, eu falei para ela, eu tenho muito fluxo de paciente, mas 80%,  
**System Digital:** De resultado mesmo, de resultado com o pé no  
**Luiz Jorge:** pois é, de 80% é plano e 20% particular,  
   
 

### 01:16:13

   
**System Digital:** chão. Então,  
**Luiz Jorge:** movimenta muito mais.  
**System Digital:** se a gente trocar isso aí, já seria um resultado para  
**Luiz Jorge:** Pois é, a intenção é largar plano e largar plantão,  
**System Digital:** você.  
**Luiz Jorge:** hospital, sobre aviso, largar tudo, cara.  
**System Digital:** Show de bola.  
**Luiz Jorge:** Focar no meu consultório e pronto. É esse que é que é a que é que é meu objetivo, parar de trabalhar sábado, domingo, chegar 6, 7 horas da noite em casa.  
**System Digital:** Ó, vamos lá. Você você sabe que para acontecer  
**Luiz Jorge:** ir para academia, ir paraa academia que nem tu às 9 da manhã,  
**System Digital:** isso,  
**Luiz Jorge:** entendeu?  
**System Digital:** se você sabe que para acontecer isso a gente precisa estruturar alguns pontos aí que a Evely já deve ter passado para você,  
**Luiz Jorge:** Não,  
**System Digital:** correto?  
**Luiz Jorge:** com certeza a gente entende que tudo é investimento, treinamento, tempo, mas a gente fica preocupado, entendeu?  
**System Digital:** É normal, porque crescer dói,  
**Luiz Jorge:** Ah,  
**System Digital:** evoluir dói.  
**Luiz Jorge:** com certeza.  
**System Digital:** É normal. O medo a gente sempre vai ter, mas não pode ser o que vai nos travar. E aquele negócio, o investimento que a gente tem que fazer é pensando com com que o direcionamento que a gente vai ter que se pagar ele,  
   
 

### 01:17:21

   
**Luiz Jorge:** Não. Sim, sim,  
**System Digital:** porque se for pensar com o que a gente tem no bolso hoje,  
**Luiz Jorge:** sim, sim. A intenção é essa. Eu sei que é um investimento. Eu sei que é um investimento. Eu tava falando para ela que agora é o período que eu tô,  
**System Digital:** né?  
**Luiz Jorge:** porque eu tô investindo em curso, em material, em meu apartamento. Então assim, eu fico com medo de investir mais esse dinheiro que eu tive que vender até um carro para tentar me mudar agora em março. E assim,  
**System Digital:** Sim.  
**Luiz Jorge:** eu já tô torrando o dinheiro do carro todinho e não consegui me mudar ainda porque sabe como é que é a obra, é uma fábrica de de dinheiro. Então do nada aparece 20, 10, 15, 20 e assim vai. Então,  
**System Digital:** Fix.  
**Luiz Jorge:** uma eh a gente fica com medo de dar esse outro passo,  
**System Digital:** Sim, com  
**Luiz Jorge:** de investir e aí, p\*\*\*\*,  
**System Digital:** certeza.  
**Luiz Jorge:** não tem um retorno,  
**System Digital:** Confia, confia em tu.  
**Luiz Jorge:** rapaz. Em mim eu confio. Aqui o cara é trabalhador e trabalho bem, graças a Deus. Eu sei que vocês, pelo que ela me explicou, deve trabalhar bem para caramba.  
   
 

### 01:18:18

   
**System Digital:** Então, cara, se você confia em tu,  
**Luiz Jorge:** É só o medo de investir,  
**System Digital:** já, já foi.  
**Luiz Jorge:** entendeu?  
**System Digital:** Valeu, irmão. Se você confia em tu, a gente confia na gente também 100%.  
**Luiz Jorge:** Sim, com certeza.  
**System Digital:** Certo vai dar.  
**Luiz Jorge:** E senão a gente tem que confiar na  
**System Digital:** Exato. Até porque, vamos lá, só para você entender,  
**Luiz Jorge:** gente.  
**System Digital:** hoje eu vou te falar, vou ser bem sincero, só não dá certo aqui com a gente hoje se você não aplicar o que a gente trazer para você. De  
**Luiz Jorge:** Não. Sim, sim. Lógico,  
**System Digital:** resto,  
**Luiz Jorge:** eu tô procurando vocês porque é uma orientação, uma ajuda, um direcionamento,  
**System Digital:** o caso dele,  
**Luiz Jorge:** eh estimular protocolo.  
**System Digital:** o caso dele, o caso dele é aceleração, né? Ô, ô, Evely.  
**Evelyn La:** Sim, sim. Ele já tem duas secretárias, inclusive. Renal,  
**System Digital:** Ah, não. Então,  
**Evelyn La:** tava falando com ele que a gente vai treinar elas.  
**System Digital:** então é fazer acontecer agora.  
**Evelyn La:** Ele não precisa se preocupar dispor de tempo,  
**System Digital:** Não, não, não é fazer acontecer agora.  
**Evelyn La:** entendeu?  
   
 

### 01:19:06

   
**Evelyn La:** É, é  
**System Digital:** Então, vamos lá, ó.  
**Luiz Jorge:** Tá.  
**Evelyn La:** tudo  
**Luiz Jorge:** E qual é o menor preço para te fechar hoje?  
**System Digital:** Vou fazer o seguinte,  
**Luiz Jorge:** Menor  
**System Digital:** é o que a Evelyn passou para você aí.  
**Luiz Jorge:** preço.  
**Evelyn La:** é os 42 da call. Falei para ele, os 42 da vista ou então parcelar em até 12 também,  
**System Digital:** Isso.  
**Evelyn La:** né? Dá pra gente parcelar 12 aí.  
**System Digital:** Cartão vai ficar uma parcela de quanto?  
**Luiz Jorge:** Deixa eu ver.  
**System Digital:** para ele ali  
**Evelyn La:** Fica 4200 a parcela, né? Deixa eu só, deixa até fazer nadom,  
**System Digital:** faz na que nad aquele aquele cashzinho lá que daí nadom vai dar uma  
**Evelyn La:** né?  
**System Digital:** parcela  
**Evelyn La:** Ah, tá.  
**System Digital:** menor.  
**Evelyn La:** Deixa eu abrir aqui então. Pera aí.  
**System Digital:** Qual que é o seu ticket médio hoje, ô doutor?  
**Luiz Jorge:** Como assim?  
**System Digital:** Hoje quanto quanto que você qual qual que é o valor hoje que você cobra em  
**Luiz Jorge:** de  
**System Digital:** média da  
**Luiz Jorge:** Pois é,  
**System Digital:** cirurgia?  
**Luiz Jorge:** cara. Isso é muito relativo. Esse que é o problema. É muito relativo. Nem todo o procedimento é igual.  
   
 

### 01:20:16

   
**Luiz Jorge:** Então, um exemplo,  
**System Digital:** Você  
**Luiz Jorge:** um paciente que quer fazer lipo, só lipo, é um valor. O cara quer fazer lipo, faz daí vai pegar aqui,  
**System Digital:** precisa de nós.  
**Luiz Jorge:** face.  
**System Digital:** Você precisa de nós.  
**Luiz Jorge:** Então assim,  
**System Digital:** Você precisa de nós. Pelo  
**Luiz Jorge:** não. Sim, porque assim,  
**System Digital:** amor.  
**Luiz Jorge:** todo procedimento, nem todos é padrão. Ah,  
**System Digital:** Sim,  
**Luiz Jorge:** o facelift é padrão porque é igual para todo mundo.  
**System Digital:** sim.  
**Luiz Jorge:** Vai abrir e vai puxar e acabou.  
**System Digital:** É esse tipo de produto que você tem que vender aí, cara.  
**Luiz Jorge:** Pois é, que é o mais rentável também. Facelift é mais demorado, mas é mais rentável. Ali, pô, mano,  
**System Digital:** Exatamente.  
**Luiz Jorge:** pode chegar 15, 20.000. Paciente quiser limpar face toda em fazer enxerto de gordura, olheira, nariz, bigode chinês, lábio, mento, 15 20.000 uma um facelift,  
**System Digital:** Ah,  
**Luiz Jorge:** p\*\*\*\*,  
**System Digital:** você faz tudo isso já?  
**Luiz Jorge:** se conseguirar aí uma média de 22.000, p\*\*\*\*,  
**System Digital:** Você faz todos,  
**Luiz Jorge:** perfeito.  
   
 

### 01:21:11

   
**System Digital:** você já faz todas essas cirurgias.  
**Luiz Jorge:** Aí fora anestesista, quase todas, cara. Ainda não comecei a fazer nariz, mas eu quero fazer mais um curso específico de nariz,  
**System Digital:** Foge de nariz.  
**Luiz Jorge:** fazer rindo.  
**System Digital:** Foge de foge de  
**Luiz Jorge:** Pois é.  
**Evelyn La:** Ô Renato.  
**Luiz Jorge:** Não é porque nariz é um é um assim,  
**System Digital:** nariz.  
**Luiz Jorge:** eu vejo muita pessoa as pessoas fazendo que eu acompanho, cara, que vê que não é legal, não fica legal, então eu não gosto de ser curioso, eu não gosto de fazer qualquer coisa. Então assim, quando eu entro para fazer eu faço muito bem feito. Então assim,  
**System Digital:** Boa.  
**Luiz Jorge:** eu vejo que esse nariz não é um negócio tão simples que nem o pessoal acha que é.  
**System Digital:** Não é  
**Luiz Jorge:** Então fazem muita m\*\*\*\*, fica feio.  
**System Digital:** não.  
**Luiz Jorge:** E assim, eu quando eu entro no negócio, eu faço para fazer bem  
**Evelyn La:** Ah.  
**System Digital:** Boa. É isso. Quanto que deu aí? Ô,  
**Luiz Jorge:** feito.  
**System Digital:** ô.  
**Evelyn La:** Ó, eu fiz lá na Don que você falou e com o caszinho lá, ele fica 12 de 3931 55\.  
**System Digital:** Ah,  
**Evelyn La:** Ele dá,  
**Luiz Jorge:** O que que é isso?  
   
 

### 01:22:12

   
**Luiz Jorge:** Dadom.  
**System Digital:** não é o a plataforma de  
**Evelyn La:** é a plataforma de de pagamentos. A gente consegue gerar um cashezinho ali para te dar mais um descontinho,  
**System Digital:** pagamento.  
**Evelyn La:** ó. Por parcela ele vai dar quase R$ 300 de desconto por  
**Luiz Jorge:** Sim,  
**Evelyn La:** parcela.  
**Luiz Jorge:** sim.  
**System Digital:** É isso. Bora para dentro.  
**Luiz Jorge:** 12 de 3900  
**System Digital:** Então,  
**Luiz Jorge:** e  
**Evelyn La:** 31,55.  
**Luiz Jorge:** tá aí. Isso é para 6 meses, né?  
**Evelyn La:** 6  
**System Digital:** se Deus quiser,  
**Evelyn La:** meses  
**System Digital:** se você colocar em prática, não vai precisar nem desses seis meses para ter resultado.  
**Evelyn La:** já.  
**Luiz Jorge:** Não, cara, a intenção é essa.  
**System Digital:** Então, bora,  
**Luiz Jorge:** Intensão é essa.  
**System Digital:** bora fazer acontecer. Bora. Você vai ter  
**Luiz Jorge:** E aí, tá, ficaria 47,  
**System Digital:** 100%  
**Luiz Jorge:** não é isso? E se fosse à vista,  
**Evelyn La:** Isso,  
**Luiz Jorge:** quanto sairia mesmos?  
**System Digital:** os 40 os 42\.  
**Luiz Jorge:** 42\.  
**System Digital:** Isso.  
**Evelyn La:** isso  
**System Digital:** Nossa, que calor que tá  
**Luiz Jorge:** É,  
**System Digital:** hoje.  
**Luiz Jorge:** tu não ve para Belém ainda?  
   
 

### 01:23:13

   
**Evelyn La:** é a gente aqui no Sul reclamando de calor.  
**System Digital:** Eu aceito, eu aceito o convite aí.  
**Evelyn La:** Imagina  
**System Digital:** Eu aceito o  
**Luiz Jorge:** p\*\*\*\*, pode vir, cara, que comida não falta,  
**System Digital:** convite.  
**Luiz Jorge:** mas chuva e calor é é aqui mesmo.  
**Evelyn La:** ele.  
**Luiz Jorge:** E comida de prato bom, comida boa também é  
**System Digital:** Bora, bora para dentro.  
**Luiz Jorge:** aqui.  
**System Digital:** Você vai entrar aqui, vai ter resultado com a gente e a gente ainda vai virar sócio,  
**Luiz Jorge:** De repente,  
**System Digital:** igual tô fazendo com os outros aqui.  
**Evelyn La:** igual  
**Luiz Jorge:** de repente eu vou visitar vocês aí de jatinha daqui a mais um ano. Já pensou?  
**System Digital:** Ah,  
**Luiz Jorge:** p\*\*\*\*,  
**Evelyn La:** ola  
**System Digital:** com o jeito, com o jeito que tá aqui,  
**Luiz Jorge:** jato executivo já pensou?  
**System Digital:** o jeito que tá aí nessa cirurgia da face aqui, daqui uns 5 anos.  
**Luiz Jorge:** Pois é,  
**System Digital:** Isso aqui eu tenho que aproveitar,  
**Luiz Jorge:** cara.  
**Evelyn La:** Ja.  
**System Digital:** tem que andar,  
**Luiz Jorge:** Eh,  
**System Digital:** tem que ir na de braçada antes.  
**Luiz Jorge:** não, daqui daqui a pouco tá tá pois é,  
**System Digital:** Tá igual harmonização daqui a pouco.  
**Luiz Jorge:** tá prostituído já, porque todo esquina faz isso aí.  
**System Digital:** Não, tem que rampar agora.  
   
 

### 01:24:00

   
**System Digital:** Agora que é o momento. Agora que você liberou o CFO ali. Agora é o momento.  
**Luiz Jorge:** Cara, tu pode me dar 10 minutos só para poder ver se eu pago no cartão ou se eu pago a vista.  
**System Digital:** Pode ser. Eu te aguardo.  
**Luiz Jorge:** Não, acho que eu vou pagar num cartão melhor e daí eu não fico descapitalizado mais do que eu já tô.  
**System Digital:** Manda para ele o link. Ô, ô, Evely.  
**Evelyn La:** Tá, vou te mandar aqui pelo chat, se consegue pegar aqui, Luiz. Deixa eu colar ele aqui. Ele  
**System Digital:** E assim aí no Belém também  
**Evelyn La:** já  
**Luiz Jorge:** A gente começa agora em março como para poder ficar redondo o  
**System Digital:** começa já.  
**Luiz Jorge:** mês.  
**Evelyn La:** começa já.  
**System Digital:** Mas você pode  
**Evelyn La:** falei para ele já, já vou, já crio o grupo aqui,  
**System Digital:** já,  
**Evelyn La:** ele já vai receber aí a  
**System Digital:** porque a grande  
**Luiz Jorge:** E aí vai até agosto,  
**Evelyn La:** nossa  
**Luiz Jorge:** é?  
**System Digital:** a  
**Evelyn La:** eh é gosto.  
**Luiz Jorge:** É, deixa até final de agosto logo para ficar tudo  
**System Digital:** Pode ser, tem problema não, pô. Isso aí é o de menos.  
**Luiz Jorge:** certo.  
**System Digital:** Isso aí a gente resolve  
**Evelyn La:** Deixa eu pegar minha minha água aqui rapidinho.  
   
 

### 01:25:15

   
**Evelyn La:** que vocês falaram de calor.  
**System Digital:** fácil.  
**Luiz Jorge:** Quem vai tomar água com açúcar sou eu agora.  
**Evelyn La:** O  
**Luiz Jorge:** Pera aí.  
**Evelyn La:** quê?  
**Luiz Jorge:** Pega lá, filho, que eu tô nervoso. Água para açúcar. Não, brincadeira. Só uma água, só uma água. Só uma água. Eu não sei o que que eu tô fazendo aqui que eu já abri outra  
**System Digital:** Belém.  
**Luiz Jorge:** coisa.  
**System Digital:** Belém.  
**Luiz Jorge:** Oi.  
**System Digital:** E hoje deu um calor aqui que eu vou falar para tu, viu?  
**Evelyn La:** Nossa, eu também, Renato,  
**System Digital:** Diferente.  
**Evelyn La:** céu, eu não sei o que que essa cascavel tem, que o dia que é calor é calor demais, o dia que é frio também é menos do eu falo senhor  
**Luiz Jorge:** Essas revistas,  
**System Digital:** Maringá também.  
**Luiz Jorge:** essas revistas de de mías, tu acha que vale a pena? Porque tem vale a pena fazer negócio de mé guia, essas coisas.  
**System Digital:** Não, pelo amor de Deus.  
**Luiz Jorge:** Pois é, eu acho que eu não vou mais fazer.  
**System Digital:** Aí não,  
**Evelyn La:** Ah.  
**Luiz Jorge:** A mulher tá me perturbando aqui.  
**System Digital:** pelo amor de Deus.  
**Luiz Jorge:** Aplicar também.  
**System Digital:** O que dá?  
**Luiz Jorge:** Não vou não.  
   
 

### 01:26:16

   
**Luiz Jorge:** Tô correndo da mulher aqui.  
**System Digital:** Não, hoje em dia ou é internet ou internet, não tem para onde  
**Luiz Jorge:** Pois é. Não.  
**System Digital:** fugir.  
**Luiz Jorge:** E também dis esse Medguias também quando joga o nome lá aparece meu nome lá em cima.  
**System Digital:** Sim. Hoje, hoje o que vende é se conectar com o público.  
**Luiz Jorge:** Pois  
**System Digital:** É resultado,  
**Luiz Jorge:** é,  
**System Digital:** é, é isso que vende de fato. Você vai aprender muita coisa aqui que vai virar sua chave.  
**Luiz Jorge:** não. Espero que de repente esse negócio realmente dê certo, que a gente continue,  
**System Digital:** Se der, não.  
**Luiz Jorge:** entendeu? Que a gente continue,  
**System Digital:** Se der não.  
**Luiz Jorge:** não só se meses,  
**System Digital:** Se Se der não,  
**Luiz Jorge:** vai ter mais tempo, entendeu?  
**System Digital:** você vai você vai virar é só filho. Meu intuito aqui não é nem isso aqui. Depois o o dinheiro de verdade tá na sociedade.  
**Luiz Jorge:** É isso aí.  
**System Digital:** Hoje a gente, acho que a Evelyn falou ali, né? Sócio estudou algarv, não sei se você conhece.  
**Evelyn La:** da Débora.  
**Luiz Jorge:** Uhum.  
**Evelyn La:** É, eu mostrei para ele ali a a eles todos entraram pela aceleração e depois a gente acabou virando sócio na nos outros produtos.  
   
 

### 01:27:31

   
**System Digital:** Algarve, a Débora agora a Sand também tá  
**Evelyn La:** É.  
**System Digital:** querendo.  
**Evelyn La:** Aí, ó. Show de bola. Só crescer.  
**System Digital:** Amém. É, é isso que a gente tem que fazer, experimentar o melhor desse mundo, pô.  
**Luiz Jorge:** Tá aqui. Isso aí. Não coloco açúcar não, né? Não, não. Tá cheio de  
**Evelyn La:** Ele pediu  
**Luiz Jorge:** açúcar.  
**Evelyn La:** mesmo.  
**System Digital:** Nossa, eu e eu eu e eu Nossa,  
**Luiz Jorge:** Ai, vai ser açúcar.  
**System Digital:** e eu esqueci do eu esqueci o sino para fazer barulho aqui. Tá lá no  
**Evelyn La:** Ai,  
**System Digital:** escritório.  
**Luiz Jorge:** Foi, eu pedi,  
**Evelyn La:** ó.  
**Luiz Jorge:** mas eu falei para cancelar. Tu já colocou açúcar mesmo,  
**Evelyn La:** Eu  
**System Digital:** Cuidar, né?  
**Luiz Jorge:** mano. Chegou a mandar o link?  
**Evelyn La:** te mandei no chat, você viu ali? Você consegue pegar pelo chat ou quer que eu mande no Whats Melhor?  
**System Digital:** Manda no whats mais  
**Luiz Jorge:** É melhor porque é meio,  
**Evelyn La:** Não, tá,  
**Luiz Jorge:** eu tô tentando achar esse chat aí,  
**System Digital:** fácil.  
**Evelyn La:** me passa seu,  
**Luiz Jorge:** mas não tô achando  
**Evelyn La:** tá?  
**Luiz Jorge:** aqui.  
   
 

### 01:28:31

   
**Evelyn La:** Me passa seu número aí que eu vou te mandar agora.  
**Luiz Jorge:** 98200 91  
**Evelyn La:** 91\.  
**Luiz Jorge:** 98200  
**Evelyn La:** 98200\.  
**Luiz Jorge:** 266 Meia meia.  
**System Digital:** Marra.  
**Evelyn La:** Te mandei.  
**System Digital:** Ô, doutor, como que você tá? Tudo bem? Nossa, que a mensagem para responder aqui é brincadeira.  
**Luiz Jorge:** Pera aí que o link não tem que copiar  
**Evelyn La:** Deu certo.  
**Luiz Jorge:** e colar aqui. Pera aí.  
**Evelyn La:** Угу.  
**Luiz Jorge:** Ja. Vai dar certo.  
**Evelyn La:** Aí já deu,  
**System Digital:** Já deu.  
**Evelyn La:** Já  
**System Digital:** A Bárbara tá pedindo para mim entrar para outro doutor  
**Luiz Jorge:** Boa.  
**System Digital:** aqui.  
**Luiz Jorge:** Eu quero ser assim também.  
**Evelyn La:** é  
**Luiz Jorge:** Malhar no horário de 9 hor da manhã que deve malhar vendo da manhã.  
**System Digital:** 9 horas não,  
**Evelyn La:** consegue tirar.  
**System Digital:** 9 horas eu tenho reunião com elas.  
**Evelyn La:** Verdade.  
**System Digital:** 10 horas.  
**Evelyn La:** É verdade.  
**Luiz Jorge:** É 9 tá dormindo ainda. Deve ser só às 10\. É, pode ser. Deixa eu só ver se eu consigo entrar com cartão virtual aqui. M.  
**Evelyn La:** Tô com sede também.  
   
 

### 01:31:19

   
**Evelyn La:** Fui lá, peguei meu celular, esqueci pegar água. Esqueci de pegar água. A mamãe tá na a metade dele, tá? Uhum. Não, tranquilo. O meu pequeno agora veio me trazer uma água aqui também. Sem açúcar. A minha tá agora se acabar que não ficar tudo quietinho. Aham. Aí tomou banho já. Aí sim, hein. Sim, sim. Aí sim.  
**Luiz Jorge:** Oi.  
**Evelyn La:** Oi.  
**Luiz Jorge:** Oi.  
**Evelyn La:** Consegue me enviar ali o comprovante, Luiz?  
**Luiz Jorge:** Deixa eu ver.  
**Evelyn La:** Só pra gente anexar e já passar.  
**Luiz Jorge:** Deixa eu ver como é que eu faço.  
**Evelyn La:** Ah, tranquilo.  
**System Digital:** Mais um acelerado lá do outro lado do C Bárbara também.  
**Evelyn La:** Opa. Aí sim,  
**Luiz Jorge:** Aí sim. Aí eu quero ser sócio também para poder ganhar mais desse lado daí  
**Evelyn La:** hein.  
**System Digital:** E eu quero o videozinho aqui da Evely aqui fazendo,  
**Luiz Jorge:** agora.  
**Evelyn La:** Aí, ó.  
**System Digital:** fazendo aqui igual a gente fez lá com o doutor  
**Evelyn La:** Oi. Chegou aí, Renan, que daí ele nem precisa qualquer coisa. O comprovante ali que eu falei para ele me enviar o comprovante.  
   
 

### 01:33:33

   
**Evelyn La:** Vê aí se chegou.  
**Luiz Jorge:** Eu tô tentando aqui, mas eu tô meio me batendo. Deixa eu ver. Passa loginho. M.  
**Evelyn La:** Você  
**System Digital:** Ai, minhas costas tá travadinha hoje. Só foi 12 horas de reunião.  
**Evelyn La:** consegue ver aí se chegou o dele, o do Luiz que ele falou que já finalizou lá. Era só mais para  
**System Digital:** Deixa eu só dar uma olhadinha  
**Luiz Jorge:** É porque como abriu em PDF,  
**System Digital:** aqui.  
**Luiz Jorge:** eu não tô logado no PDF. Po,  
**Evelyn La:** Ah,  
**Luiz Jorge:** deve tá dando bloqueio aqui para eu fazer o  
**Evelyn La:** sim, sim.  
**System Digital:** Hoje é dia 12, né?  
**Evelyn La:** Gé isso.  
**Luiz Jorge:** compartilhamento.  
**System Digital:** Hoje é dia 12\. Dia 12 de fevereiro,  
**Luiz Jorge:** Olha aí, tu é doido. É muito Jiro entrando,  
**System Digital:** filtrar.  
**Luiz Jorge:** mano. Tem que até filtrar, hein? Quer até filtrar.  
**System Digital:** Nossa, pai.  
**Luiz Jorge:** Deixa eu ver se eu faço um print aqui da tela, pelo menos.  
**System Digital:** Ah, caiu. Deixa eu ver aqui no crédito. Caiu. Seja muito bem-vindo,  
**Evelyn La:** Seja muito bem-vindo,  
   
 

### 01:34:58

   
**Luiz Jorge:** Pronto.  
**System Digital:** doutor.  
**Evelyn La:** Luiz.  
**Luiz Jorge:** Tudo certo.  
**Evelyn La:** Parabéns pela decisão.  
**Luiz Jorge:** Vai dar certo.  
**System Digital:** Seja muito bem-vindo.  
**Luiz Jorge:** A intenção é essa.  
**Evelyn La:** Já deu,  
**System Digital:** Já deu.  
**Luiz Jorge:** Deu. Já  
**Evelyn La:** já deu aqui,  
**System Digital:** Já deu.  
**Evelyn La:** ó, mais um acelerado da Sistem.  
**Luiz Jorge:** deu.  
**System Digital:** Já deu.  
**Evelyn La:** Parabéns pela decisão. Belém será pequena,  
**Luiz Jorge:** Ô, Deus lhe  
**System Digital:** É isso.  
**Evelyn La:** hein?  
**System Digital:** É isso aí,  
**Luiz Jorge:** ouça.  
**System Digital:** meu garoto. Bora para cima. Fazer acontecer agora é aquele negócio,  
**Luiz Jorge:** Vai dar certo. Vai dar  
**System Digital:** o mais rápido possível, o mais rápido possível que você aplicar,  
**Luiz Jorge:** certo.  
**System Digital:** a gente vai tá aqui para te guiar, para te transformar e de verdade aí gerar muito impacto aí na sua vida,  
**Luiz Jorge:** Não vai.  
**System Digital:** no seu negócio e no na vida dos seus clientes também.  
**Luiz Jorge:** A gente investe para negócio dar certo.  
**System Digital:** É isso, cara.  
**Luiz Jorge:** Não vai, vai, vai dar  
**Evelyn La:** Bora fazer acontecer, Luiz.  
**Luiz Jorge:** certo. Tá beleza. Então, valeu, amigo. Obrigado.  
**Evelyn La:** Obrigada, Ran. Até mais.  
   
 

### 01:36:00

   
**Evelyn La:** Tchau. Muito bem, Luiz. Vamos lá, então. Vou montar, ó, te passar agora o passo a passo. O que que vai ser? Vou abrir o grupo VIP, vou incluir você lá no grupo, vou incluir todo o pessoal que vai cuidar junto contigo desse processo.  
**Luiz Jorge:** M.  
**Evelyn La:** Vou te pedir alguns dados ali para você preencher e enviar para nós, que aí a gente vai subir seu contrato no grupo para ser assinado e a gente já starta e marca o melhor horário para fazer seu onboarding, para fazer as reuniões e criar o grupo das suas secretárias lá. Tá bem?  
**Luiz Jorge:** Tá bom.  
**Evelyn La:** Mais uma vez, parabéns pela decisão, viu? E bora fazer acontecer agora nas cirurgias,  
**Luiz Jorge:** Não tem o que acontecer,  
**Evelyn La:** hein? Ficar mais tranquilo, mais em casa,  
**Luiz Jorge:** p\*\*\*\*.  
**Evelyn La:** com com horário de herdeiro aí para pra academia.  
**Luiz Jorge:** É fazer que nem vocês, mas a 9 da manhã, isso que é  
**Evelyn La:** Você viu?  
**Luiz Jorge:** intenção.  
**Evelyn La:** E quem sabe você venha para Foz ainda um dia, né? Comprar uns vinos na Argentina,  
**Luiz Jorge:** Fica hospedado lá naquele hotelzão. Como é o nome daquele  
**Evelyn La:** aquele hotelzão lá na beira da das cataratas.  
**Luiz Jorge:** hotel?  
**Evelyn La:** Isso aí. Parabéns, Luiz, mais uma vez.  
   
 

### A transcrição foi encerrada após 01:38:02

*Esta transcrição editável foi gerada por computador e pode conter erros. As pessoas também podem alterar o texto depois que ele for criado.*', NULL, NULL, '[]'::jsonb, '[]'::jsonb, '[]'::jsonb, '[]'::jsonb, '[]'::jsonb, '{}'::jsonb, '[]'::jsonb, NULL, NULL, NULL, NULL, NULL, 'whisper-1', 'claude-sonnet-4', NULL, NULL, NULL, '2026-03-29T23:29:38.049055+00:00', NULL, NULL, '2026-03-29T23:31:12.406+00:00', '2026-03-29T23:31:12.406+00:00', '2026-03-29T23:29:38.049055+00:00', '2026-03-29T23:31:12.450847+00:00', NULL, '[]'::jsonb, NULL, NULL, '[]'::jsonb, NULL, NULL, NULL);

INSERT INTO call_audits (id, organization_id, closer_id, lead_name, call_date, duration_minutes, resultado, valor_fechamento, status, error_message, score_final, classificacao, d01_frame, d02_qualificacao, d03_diag_quantitativo, d04_diag_qualitativo, d05_consequencia, d06_ensino, d07_identidade, d08_ancoragem, d09_isolamento, d10_proporcao_fala, d11_promessas, d12_checkpoints, d13_fechamento, transcricao, relatorio_completo, resumo_whatsapp, top_erros, top_acertos, plano_acao, frases_proibidas, reescrita_falas, mapa_frameworks, fases_analise, audio_path, audio_duration_seconds, drive_file_id, drive_url, drive_report_url, modelo_transcricao, modelo_analise, tokens_input, tokens_output, custo_estimado, uploaded_at, transcribed_at, analyzed_at, notified_at, completed_at, created_at, updated_at, sentiment_overall, sentiment_timeline, sentiment_score, engagement_level, objections_detected, prompt_version, report_hash, storage_report_path) VALUES
('30b18ba9-fdc1-4f4d-b812-9eb667c2a54b', '4ecd8f2d-d0c5-419c-a5bc-b2e94dca0465', '171a0543-1dde-4ba4-99f8-d396c6832b60', 'Bruno Louzada', '2026-03-28', NULL, 'reagendar', NULL, 'completed', NULL, 5.2, 'FRACA', 6.0, 7.0, 5.0, 6.0, 4.0, 7.0, 5.0, 3.0, 3.0, 6.0, 6.0, 5.0, 2.0, '12 de fev. de 2026

## Auditoria Comercial \- Bruno Louzada \<\> System Digital \- Transcrição

### 00:00:00

   
**Evelyn La:** Olá, Bruno,  
**Bruno Louzada:** Tudo bem?  
**Evelyn La:** tudo bem contigo?  
**Bruno Louzada:** Joia.  
**Evelyn La:** Você fala da onde?  
**Bruno Louzada:** Eu sou de Icotia.  
**Evelyn La:** Grande São Paulo.  
**Bruno Louzada:** É.  
**Evelyn La:** Legal. Eu tive em eu tive em Alfavil em outubro ano passado. Mas Cotia fica para que lado? Não é ali não, né?  
**Bruno Louzada:** Ah, dá uns 10 km ali o raio ali.  
**Evelyn La:** É. Ah,  
**Bruno Louzada:** É,  
**Evelyn La:** que bacana.  
**Bruno Louzada:** é do  
**Evelyn La:** Porque eu fiquei Ah, bacana.  
**Bruno Louzada:** lado.  
**Evelyn La:** Eu fui só mais ali barueri, aí acabei não saindo para outros cantos.  
**Bruno Louzada:** Ah, ali é o miolo ali de congresso, essas coisas,  
**Evelyn La:** É,  
**Bruno Louzada:** né? É,  
**Evelyn La:** a gente foi.  
**Bruno Louzada:** mas é rola tudo  
**Evelyn La:** Uhum. Exatamente.  
**Bruno Louzada:** ali.  
**Evelyn La:** Eu fui, peguei até uma palestra do Pablo Marçal lá que ia cair de gaiato.  
**Bruno Louzada:** Ah, lá lá tem toda a  
**Evelyn La:** Aham.  
**Bruno Louzada:** semana.  
**Evelyn La:** O pessoal falou aí, fui lá participar, ver como é que era ele no palco.  
**Bruno Louzada:** Eu  
**Evelyn La:** Mas bacana.  
   
 

### 00:01:51

   
**Evelyn La:** Eh, tu já foi aluna do Alexandre?  
**Bruno Louzada:** fiz o face code faz uns 15  
**Evelyn La:** Você  
**Bruno Louzada:** dias.  
**Evelyn La:** fez para alguma imersão específica ou você fez o pacote completo?  
**Bruno Louzada:** Não, eu fiz o completo, aquele que é lift cérvico, autoplastia e o lift, né?  
**Evelyn La:** Que legal\!  
**Bruno Louzada:** É,  
**Evelyn La:** Bacana.  
**Bruno Louzada:** o meu pai fez ano passado, aí eu animei de fazer.  
**Evelyn La:** Ah, bacana. Seu pai é sócio seu?  
**Bruno Louzada:** Não, não. Ele tem a clínica dele com a esposa dele.  
**Evelyn La:** Ah, entendi. É dentista também.  
**Bruno Louzada:** Dentista também.  
**Evelyn La:** Legal. E hoje você tem algum sócio na sua clínica?  
**Bruno Louzada:** Não,  
**Evelyn La:** É só você?  
**Bruno Louzada:** na verdade o meu é consultório particular, trabalho sozinho.  
**Evelyn La:** Entendi. Você tem algum, alguém que te ajuda a secretária? Alguém nesse sentido?  
**Bruno Louzada:** Então, por enquanto não, mas eu tô contratando. É que tá difícil, né?  
**Evelyn La:** Ah, entendi. Então tá no tá nos passos aí para contratação.  
**Bruno Louzada:** Tá, tô. Eu preciso, né? Precisa ter,  
**Evelyn La:** Uhum.  
   
 

### 00:03:05

   
**Bruno Louzada:** né?  
**Evelyn La:** Hoje você é focado mais nas cirurgias da face também ou você faz além  
**Bruno Louzada:** Não,  
**Evelyn La:** disso,  
**Bruno Louzada:** eu tô entrando nesse mundo.  
**Evelyn La:** certo?  
**Bruno Louzada:** Eh, eu eu sou clínico, né, geral e a minha demanda maior hoje é resina, né? Eu já tenho uma rotatividade já de paciente de resina  
**Evelyn La:** Certo?  
**Bruno Louzada:** já.  
**Evelyn La:** Então você tá integrando agora as as  
**Bruno Louzada:** É, tô entrando nesse novo mundo aí agora,  
**Evelyn La:** cirurgias.  
**Bruno Louzada:** né? Vamos ver surfar essa onda aí, né?  
**Evelyn La:** Vai gostar, tenho certeza.  
**Bruno Louzada:** É por isso que eu fui fazer lá o face code lá com Alexandre para ver se eu ia gostar mesmo, que daí eu vou fazer a posse, já até me matriculei lá.  
**Evelyn La:** Ah, que bom. Você foi direto lá com eles.  
**Bruno Louzada:** Hã,  
**Evelyn La:** Fez direto lá com eles já a matrícula da posse.  
**Bruno Louzada:** é, eu já tinha feito com a Manu,  
**Evelyn La:** Uhum.  
**Bruno Louzada:** né?  
**Evelyn La:** Ah, legal. A gente é a gente atendeu o Alexandre um tempo atrás. Ele entrou no nosso programa de aceleração aqui de clínicas. E aí dentro do programa a gente tem uma estratégia ali que cria os o a esteira realmente, né, de produtos.  
   
 

### 00:04:17

   
**Evelyn La:** E foi aonde a gente pegou também a essa parte do das imersões agora, mas foi a partir desse ano aqui, foi agora em janeiro que começou, no comecinho de janeiro, né?  
**Bruno Louzada:** Ah,  
**Evelyn La:** A gente cuidando tanto o comercial de clínica quanto o comercial dele também dessa parte.  
**Bruno Louzada:** certo.  
**Evelyn La:** Aí ele tá sócio aqui do do Renan e do Mateus. Aí a Laí comentou, falou: "Ah, ele foi aluno do Alexandre". Eu falei: "Ah, que bacana,  
**Bruno Louzada:** Uhum.  
**Evelyn La:** bem bem referência aí, né?" E aí, eh, hoje você tem a clínica, então tá focando nisso. Como que tem sido os seus atendimentos hoje? Você, você mesmo que agenda?  
**Bruno Louzada:** É o mesmo que agendo.  
**Evelyn La:** É você que faz todo o processo ali em si.  
**Bruno Louzada:** É, por enquanto. É.  
**Evelyn La:** Uhum. Entendi. Bruno. Eh, antes de eu iniciar aqui para fazer algumas perguntas, entender um pouco melhor sobre seu cenário para entender se de fato, óbvio, vai fazer sentido o que que a gente faz aqui para você, né? Eu queria entender um pouquinho mais de você,  
**Bruno Louzada:** Uhum.  
**Evelyn La:** porque que você bus chegou a buscar assistem, você viu algum anúncio?  
   
 

### 00:05:29

   
**Bruno Louzada:** Então,  
**Evelyn La:** Como que foi  
**Bruno Louzada:** logo que eu tava lá no curso, é Mateus, né?  
**Evelyn La:** o Renan? tava lá.  
**Bruno Louzada:** Não, mas não o Renan, quem me chamou foi o Mateus.  
**Evelyn La:** Foi o Mateus. Então, então Mateus é o sócio do Renan.  
**Bruno Louzada:** É,  
**Evelyn La:** Aham.  
**Bruno Louzada:** o Mateus logo me chamou lá, ah, você tá fazendo o curso aí com Alexandre. Eh, o meu trabalho é acelerar aí para vocês, porque a gente só trabalha com cirurgias da face, né? Aí de cara eu falei assim:  
**Evelyn La:** Uhum.  
**Bruno Louzada:** "Irmão, deixa eu fazer o curso aqui que eu nem sei se vai rolar ou não".  
**Evelyn La:** Certo.  
**Bruno Louzada:** E eu terminando,  
**Evelyn La:** Так.  
**Bruno Louzada:** eu te chamo para mim ver aí como que é a proposta de vocês, porque eu acho que tem que ser um anúncio diferenciado, né? Tipo, não pode anunciar também assim de qualquer jeito, até por causa da lá do CFO e etc. Então, foi mais por conta disso que eu quis fazer essa reunião para mim saber certinho e como que vocês trabalham.  
**Evelyn La:** Ah, entendi. Certo. Então, assim, uma coisa já te adianta, a gente não é uma agência de tráfego pago, tá?  
   
 

### 00:06:34

   
**Evelyn La:** A gente trabalha como parceiros para acelerar crescimento,  
**Bruno Louzada:** Tá.  
**Evelyn La:** faturamento, enfim, toda a parte ali. Eu vou te explicar um pouquinho melhor. Antes de eu entrar na questão de empresa, eu vou te apresentar um pouquinho da Evelyn para você conhecer quem que vai te atender, né? Hoje eu sou especialista aqui da System, mas para você conhecer um pouquinho de mim também, entender aí como que eu cheguei até aqui a minha trajetória, acho importante compartilhar porque aí você conhece quem pessoa por trás aqui, né? A gente não tá em escritório, então a gente faz isso digital também. Então a Evelyn hoje é mãe de um palmeirense, né? Acdo aqui nos treinos. Arrasta até eu treinos às vezes, mas eu gosto mesmo de treinar a calistenia. Já falei: "Não, isso aqui não é a minha a minha área, gosto muito de ler. Moro do ladinho de FIG Iguaçu. Não sei se você já veio alguma vez para esses lados. Bom, Maringá você já foi,  
**Bruno Louzada:** É,  
**Evelyn La:** né?  
**Bruno Louzada:** Maringá. Eu fui FZ ainda não.  
**Evelyn La:** Não, eu fico em Cascavel. Cascavel dá uns 150 km,  
**Bruno Louzada:** Não,  
   
 

### 00:07:40

   
**Evelyn La:** mais ou menos de f aqui. E eu falo que eu tenho as cataratas meio que quase que um quintal de casa, né? Porque fica facinho para para passar ali.  
**Bruno Louzada:** maravilha.  
**Evelyn La:** Eu sou descendente de italiano, então meu vô me acostumou a beber beber vim desde criança. Não fiquei uma viciada, mas também sempre tô gosto de um vinho e não sem chimarrom,  
**Bruno Louzada:** degustando.  
**Evelyn La:** né?  
**Bruno Louzada:** Ja.  
**Evelyn La:** Não fico sem um vinho e um chimarrão. O pessoal me até zoa comigo na empresa sobre isso. Eu me formei na área da saúde, né? Para você conhecer um pouquinho do meu lado profissional. me formei na área da saúde. Eu trabalhei por durante 10 anos em laboratório com pesquisas e análises médicas, clínicas e microbiológicas. Eu tenho um mestrado na área de genética, então eu fazia de fato a parte mais operacional ali mão na massa, né? A pesquisa em si, toda aquela questão eh do da parte microbiológica também atendia bastante hospitais. A gente era um laboratório que atendia muito hospitais. Depois que eu ganhei o meu filho, aí eu fiz uma transição de carreira e me aventurei no empreendedorismo.  
   
 

### 00:08:46

   
**Evelyn La:** Então eu tive uma loja, abri uma loja por durante 4 anos aqui na minha cidade. Depois eu fechei ela por conta realmente de questões que a dona da sala em si, ela tava vendendo o prédio e aí para mim não era interessante, né? Por conta do mercado que eu trabalhava ali. E eu depois disso eu me guioi o mercado digital. Então hoje eu sou uma closer, então eu faço o quê? reuniões de diagnóstico. Eh, e claro, unir as duas coisas, né? A minha experiência clínica e laboratorial, a minha parte de vendas, que é algo aonde eu gosto muito também, e hoje eu atuo como closer. Só no ano de 2025 eu fechei mais de 2 milhões em contrato, 2 milhões de faturamento de vendas um a um, né? tanto evento presencial quanto online. Então essa é um pouquinho da minha trajetória para você conhecer um pouco sobre mim, né? Entender aí quem vai te atender, eh, e como que a gente vai dar sequência no nosso bate-papo. Aí conheço um pouquinho da rotina, inclusive de dos médicos, da parte clínica ali, a parte de hospital, a gente tinha, né, os dentistas também. Então eu falo, é um mundo que para mim não é tão fora, né?  
   
 

### 00:10:02

   
**Evelyn La:** já convivi bastante, mas vamos lá, Bruno. Eh, deixa entender um pouquinho melhor hoje sobre o que seria mais as suas expectativas realmente em relação a essa parte, esse ano de 2026, porque assim, como você ainda não tem uma estrutura comercial, como você ainda faz tudo isso sozinho, eu acredito que você hoje os seus pacientes chegam mais pro quê? indicação lad  
**Bruno Louzada:** Lead, é os novos praticamente,  
**Evelyn La:** também,  
**Bruno Louzada:** né? Aí depois que vem, faz o tratamento, aí é indicação e  
**Evelyn La:** tá?  
**Bruno Louzada:** leade.  
**Evelyn La:** Esses leads hoje você faz o tráfego pago com alguma agência já  
**Bruno Louzada:** Não,  
**Evelyn La:** ou  
**Bruno Louzada:** eu já eu não tinha agência. Mas você já ouviu falar da Smile?  
**Evelyn La:** smile não.  
**Bruno Louzada:** Eles são de Curitiba. Eles meio que meio não,  
**Evelyn La:** Hum.  
**Bruno Louzada:** eles ensinam dentistas a fazer a sua própria propaganda, vamos dizer assim.  
**Evelyn La:** M.  
**Bruno Louzada:** e tem uma evolução,  
**Evelyn La:** M.  
**Bruno Louzada:** eles têm um método. Mas daí eu fiquei um ano e meio lá com eles. O que que aconteceu? Depois eu achei que eles estagnavam meio que assim, é a mesma coisa, mas só que você fica preso a uma mensalidade,  
   
 

### 00:11:38

   
**Evelyn La:** Ah,  
**Bruno Louzada:** você entendeu? Então vamos assim,  
**Evelyn La:** certo.  
**Bruno Louzada:** é o básico que funciona, mas tem o básico mais um pouquinho, mas mesmo assim você tá pagando uma mensalidade,  
**Evelyn La:** Hum.  
**Bruno Louzada:** você entendeu? Você não paga uma agência,  
**Evelyn La:** Tá,  
**Bruno Louzada:** mas o valor que você paga é quase a mesma coisa de você pagar uma agência assim, entendeu?  
**Evelyn La:** entendi.  
**Bruno Louzada:** Lógico, eu isso eu não eh eu já eu converso até com a minha esposa que ela é dentista,  
**Evelyn La:** Sì.  
**Bruno Louzada:** porém nós não trabalhamos juntos. Eh, se você seguir o que eles falam lá, a ferre e fogo, não tem como você não ter faturamento, você entendeu? Porém, você acaba ficando muito amarrado lá e cada hora mais você tá pagando,  
**Evelyn La:** Угуm.  
**Bruno Louzada:** vamos supor, é uma mensalidade lá, acho que hoje deve est uns R$ 3.000, entendeu? Então assim, eu achava que era muita coisa do mesmo e muito espalhafatoso, você entendeu? Não era uma coisa que ia mudar assim, cada dia você aprende uma coisa nova, não sei o quê, coisa do tipo, entendeu?  
   
 

### 00:12:36

   
**Evelyn La:** Угуm.  
**Bruno Louzada:** Mas tem gente que eu eu conheci, cheguei a ir em congressos lá que tava lá há 5 anos e paga e tem faturamento e de boa. Eu acho que no meu caso, por exemplo, paraas lentes já tem uma grande demanda, né? Agora para implantodontista, para outros canais, porque na verdade eles mesmos falavam lá, é uma escola de implanto odontista, mas só que daí você podia pegar os meios e aplicar paraa resina,  
**Evelyn La:** Hum.  
**Bruno Louzada:** para canal e etc,  
**Evelyn La:** Entendi.  
**Bruno Louzada:** entendeu?  
**Evelyn La:** Uhum.  
**Bruno Louzada:** Então eu eu acabei aprendendo e essa campanha que eu aprendi lá, tipo assim, é a que eu toco até hoje, entendeu?  
**Evelyn La:** Entendi. Normalmente ela te gera quantos leads aí a que você vem fazendo?  
**Bruno Louzada:** Então eu eu acho que eu eu falava lá nas reuniões, eu falava, eu acertei nessa campanha porque essa essa minha campanha o lead dela mais caro foi R$ 5,  
**Evelyn La:** Nossa\!  
**Bruno Louzada:** entendeu? Então assim, eu boto R$ 50 para rodar lá pro dia, por dia, tem dia que dá 10 leads, hoje chegou cinco, entendeu? Então eh,  
**Evelyn La:** Uhum.  
   
 

### 00:13:56

   
**Bruno Louzada:** mas às vezes é muito lead ruim, você entendeu? É um lead não muito filtrado, você entendeu? Não é um lead, não é um lead,  
**Evelyn La:** Qualificado.  
**Bruno Louzada:** às vezes não é aquele lead quente, mas às vezes nesses 10 você fecha dois, você entendeu? É muito. E tem muita gente, tipo, só perguntando preço e tem muita gente que vem para  
**Evelyn La:** Certo?  
**Bruno Louzada:** fechar.  
**Evelyn La:** Mas você assim dos que chegam que você fecha é uma taxa mais ou menos de conversão, o quê? 20%.  
**Bruno Louzada:** É, é mais ou menos isso. Mais ou menos. É uns uns 20%. É porque eu eu trabalhando aqui sozinho, o meu o meu giro em média é de R$ 25 a R$ 35.000. Entendeu? Por isso que eu resolvi entrar nesse e-mail da cirurgia,  
**Evelyn La:** Certo.  
**Bruno Louzada:** eh, pensando assim, eu já tenho, né, um mailing ali de de resina, né, e entrando com a cirurgia,  
**Evelyn La:** Uhum.  
**Bruno Louzada:** vamos supor que eu separe, de manhã eu vou operar e à tarde eu vou continuar com os meus pacientes de resina, entendeu?  
   
 

### 00:15:02

   
**Evelyn La:** Exato.  
**Bruno Louzada:** Ou aí ou depois cair em definitivo na cirurgia e e vice-versa, entendeu?  
**Evelyn La:** Uhum. Muito bom. Eh, hoje a essa parte das cirurgias eh você consegue um ticket bem melhor compadem. Então, para você chegar a esse faturamento que você aí às vezes precisa um mês para atingir, fazendo as cirurgias em uma semana, provavelmente você bate, bate às vezes até mais.  
**Bruno Louzada:** É,  
**Evelyn La:** Uhum.  
**Bruno Louzada:** então às vezes não Não é só dinheiro, né, que te Claro,  
**Evelyn La:** Sì, claro.  
**Bruno Louzada:** né? Eh, foi por isso que não foi só por isso que eu animei, né? Porque até porque eu fui fazer o curso lá por causa disso, eu falei: "Putz, não adianta nada. Às vezes eu vou lá, não gosto, não consigo porque tem gente que trava. Uma mulherada lá comigo mesmo foi, eu não vi ninguém fazer um corte lá, não fazer uma incisão. Então, tipo assim, eu acho que não vão operar, né? E eu fui abri lá,  
**Evelyn La:** Mhm.  
**Bruno Louzada:** fiz lift, gostei, fiz a servicoplastia. Então é aquele negócio, né? O que você procura hoje é ganhar um ticket médio bom, né?  
   
 

### 00:16:17

   
**Bruno Louzada:** E ter tem tempo pra sua família. Eu tenho três moleques,  
**Evelyn La:** Só que  
**Bruno Louzada:** um de um de 12,  
**Evelyn La:** idade?  
**Bruno Louzada:** um de três e um de 6 meses.  
**Evelyn La:** Eita nós.  
**Bruno Louzada:** Tudo  
**Evelyn La:** Eh, eita aí,  
**Bruno Louzada:** corintiano.  
**Evelyn La:** ó.  
**Bruno Louzada:** Então, eh, a gente e um primeiro é de outro casamento, então aí fica muito atravessado e e você tem que ter tempo para todo mundo e às vezes não dá.  
**Evelyn La:** Sim.  
**Bruno Louzada:** Então, pensando nisso também na família, eu falei: "Por que não, né?" Tipo, na cirurgia, meu pai mesmo, ele começou a operar lá, eu acho que em dezembro ele trabalhou 20 dias, eu acho que ele fez 140.000.  
**Evelyn La:** Uhum. É isso aí.  
**Bruno Louzada:** É,  
**Evelyn La:** E trabalha assim,  
**Bruno Louzada:** ele fez,  
**Evelyn La:** você é que nem você  
**Bruno Louzada:** ele fez uns, ele fez uns quatro lift,  
**Evelyn La:** falou,  
**Bruno Louzada:** acho que umas 15 bléfaro e já tinha dado quase cento e pouco. Aí depois pegou mais um lift.  
**Evelyn La:** é bem isso você traz, é que você comentou da família, né? E provavelmente seu pai deve ter trabalhado menos.  
   
 

### 00:17:27

   
**Evelyn La:** menos no sentido assim, eh, com períodos maior de descanso,  
**Bruno Louzada:** Isso,  
**Evelyn La:** entendeu?  
**Bruno Louzada:** isso,  
**Evelyn La:** E o ticket maior ali. Esse aqui é a vantagem de  
**Bruno Louzada:** essa que é a vantagem. Então eu conversei bastante com ele eh sobre isso também, porque, por exemplo, um implantista faz um protocolo, meu, você vai ver o paciente às 10 vezes. A sua hora clínica, você começa ganhando 500 a hora clínica. Se você ver, você vai atendendo, atendendo, atendendo, daqui a pouco tá 100\. Daqui a pouco você não tá ganhando mais na hora clínica, né? Você tá lá atendendo o mesmo paciente e o e não tem mais da onde tirar,  
**Evelyn La:** Ó,  
**Bruno Louzada:** né? Se ele já pagou o tratamento dele, né?  
**Evelyn La:** sim, exatamente. E acaba sendo desgastante, você já não já paga para trabalhar, né?  
**Bruno Louzada:** Isso mesmo. E aí eu aí eu operei com ele antes de eu falei:  
**Evelyn La:** É,  
**Bruno Louzada:** "Ô pai, eu vou fazer umas cirurgias aqui com você que é que ele tem aquele velho problema de pai e filho, sabe?  
**Evelyn La:** sei,  
**Bruno Louzada:** Trabalhar junto,  
**Evelyn La:** sei,  
   
 

### 00:18:31

   
**Bruno Louzada:** você deve saber." Então a gente não trabalhava,  
**Evelyn La:** sei.  
**Bruno Louzada:** não trabalha mais junto. Mas daí eu fui, conversei com ele, eu falei: "Eu vou eh me chama para fazer algumas cirurgias, né, para eu ver como que é.  
**Evelyn La:** Sim.  
**Bruno Louzada:** Eu te auxilio, não precisa pagar nada, fica em paz, só para mim aprender mesmo." Aí eu fui, aí eu gostei. Aí eu decidi fazer lá o curso com Alexandre.  
**Evelyn La:** Ah, legal. Que bom. É isso aí. É,  
**Bruno Louzada:** É.  
**Evelyn La:** dando os o os passos. Que bom que você eh querendo ou não, seu pai foi, fez, te mostrou que, poxa, opa, posso posso investir eh sem medo que o retorno vai vir  
**Bruno Louzada:** Isso.  
**Evelyn La:** de qualquer jeito e aí te traz mais de tranquilidade,  
**Bruno Louzada:** Aham.  
**Evelyn La:** né? mais tempo com a família, com a esposa. Com certeza. Ela tem rotina puxada também.  
**Bruno Louzada:** Isso. Então,  
**Evelyn La:** Como que é o dela?  
**Bruno Louzada:** o dela é mais tranquilo. Ela faz harmonização. Aí o consultório dela é na rua da nossa casa.  
   
 

### 00:19:24

   
**Bruno Louzada:** Então, por exemplo,  
**Evelyn La:** Aham.  
**Bruno Louzada:** eh, por pro bebê mesmo, tipo, ela vai, volta, almoça em casa,  
**Evelyn La:** A  
**Bruno Louzada:** agora agora já não tá mais amamentando, mas quando precisava ia amamentava.  
**Evelyn La:** que  
**Bruno Louzada:** E tem uma menina que que nos ajuda lá em casa, então não ficou mais tranquilo.  
**Evelyn La:** ai que bom, que  
**Bruno Louzada:** É, então a porque daí não precisa ficar se deslocando,  
**Evelyn La:** bom.  
**Bruno Louzada:** né? Tipo, ah, vou atender é uma hora de trânsito, não, tipo, é 5 minutos.  
**Evelyn La:** Exatamente. Nossa.  
**Bruno Louzada:** É.  
**Evelyn La:** E e a gente que é mãe, empresária e tudo ao mesmo tempo, olha,  
**Bruno Louzada:** Dá uns burnout.  
**Evelyn La:** é,  
**Bruno Louzada:** Dá uns burnout.  
**Evelyn La:** exatamente.  
**Bruno Louzada:** Eu  
**Evelyn La:** Mas é isso, né? É vivendo e aprendendo, né? E e assim, para mulher muito importante,  
**Bruno Louzada:** sei.  
**Evelyn La:** no caso ter, por exemplo, ah, um marido que vá dar todo esse suporte, né? e por ela ter você hoje, com certeza a facilidade dela estar um pouco mais perto de casa, até mesmo ela tem essa rotina tranquila, é de fato ali esse suporte emocional, suporte que você vai inclusive melhorar e proporcionar ainda mais agora, né?  
   
 

### 00:20:32

   
**Evelyn La:** Então,  
**Bruno Louzada:** Ne.  
**Evelyn La:** então é importante isso.  
**Bruno Louzada:** Ja.  
**Evelyn La:** Deixa eu te perguntar uma coisa, já que a gente entrou nesse assunto. Eh, hoje a sua esposa te ajuda em tomada de decisões, questões às vezes de investimento paraa sua clínica?  
**Bruno Louzada:** Então, a gente conversa bastante, a gente até teve alguns embates assim, né?  
**Evelyn La:** Sim,  
**Bruno Louzada:** Eh, eu moro em Cotia, porém o meu consultório, vamos dizer assim,  
**Evelyn La:** sim.  
**Bruno Louzada:** que ele é mais popular, não é muito, mas é mais popular do que o dela. O dela já é mais selecionado. Tipo Barueri Alfaville, aqui tem Cotia, Granja, Granja Viana, se eu falar,  
**Evelyn La:** Já.  
**Bruno Louzada:** o nosso consultório é na Granja.  
**Evelyn La:** Uhum.  
**Bruno Louzada:** O outro e o meu é Carapicuíba, é mais populoso assim o bairro, sabe? Mas é bem arrumado também, bem bem bem legal assim.  
**Evelyn La:** Aham.  
**Bruno Louzada:** Aí ela fala: "E você vai divulgar para atender aonde?" Eu falei: "Meu, eu não sei. Eu sei que a gente tem que começar de um dos dois, né? Um dos dois a gente vai ter que investir, comprar, equipar, comprar os aparelhos, enfim". Mas ela juda assim tudo,  
   
 

### 00:21:41

   
**Evelyn La:** Uhum.  
**Bruno Louzada:** eu converso com  
**Evelyn La:** Certo? Por que que eu te faço essa pergunta, Bruno?  
**Bruno Louzada:** ela.  
**Evelyn La:** Porque assim, como eu entendo dessa importância, já fui esposo um dia também. Eu atualmente não sou, mas já fui. E a gente, querendo ou não, é vira e é uma sócia igual, né? Sócia do marido,  
**Bruno Louzada:** Mhm.  
**Evelyn La:** sócia em casa que vai estar junto na caminhada. Eh, por que que eu pergunto isso? Porque quando tem essa questão a eh da esposa, às vezes até um outro sócio ou alguma outra pessoa que auxilia, a gente sempre traz essa pessoa junto para a reunião para ela também entender sobre conhecer sobre nosso trabalho. Como você trouxe para mim aqui que ela tem o bebezinho e tudo mais, questões de rotina para alinhar, que que a gente pode fazer aqui hoje? Eh, eu te eu ir com você até uma parte da nossa apresentação, né, te passar um pouquinho sobre nosso trabalho. E aí, se você vê que faz sentido de fato estar com a gente no ecossistema, se for paraa gente entrar em qualquer negociação, em qualquer parte mais de investir realmente como que vai ser e como que vai ser eh executado, aí a gente marca uma segunda callo. Pode ser?  
   
 

### 00:22:51

   
**Bruno Louzada:** Pode. Claro.  
**Evelyn La:** Pode ser. Porque assim, o objetivo nosso aqui, eu sempre alinho três coisas, né? É o quê? Primeiro, eu não estou para vender nada. Óbvio que se eu vender vai ser maravilhoso, vai ser excelente. Voltei a minha comissão ali. Mas antes de qualquer coisa, eu tô aqui para te ajudar para ouvir um pouquinho mais, entender sobre o seu cenário, analisar se faz sentido você no nosso ecossistema, porque a gente vai ter uma proposta sim, mas você também conhecer da empresa e ver se faz sentido você continuar depois aí a gente fazer uma  
**Bruno Louzada:** Uhum.  
**Evelyn La:** segunda calla, combinado? Certo? Legal. Eh,  
**Bruno Louzada:** Certo.  
**Evelyn La:** hoje, entendendo um pouquinho mais, você trouxe até para mim, né, que você que tava com essa empresa ali, você tinha em média esses R$ 3.000 de investimento mês? Então, tava nessa faixa ou tava um pouco  
**Bruno Louzada:** Tava nessa faixa porque daí eu gastava mais um pouco de tráfego,  
**Evelyn La:** menos?  
**Bruno Louzada:** né? Mais uns 1000, 100 dois de tráfego daí que eu fazia, né?  
**Evelyn La:** Uhum. Você investir e tal.  
   
 

### 00:23:55

   
**Evelyn La:** Beleza. Aí você me passou a taxa de conversão já. Esses agendamentos era tudo você que realizava por telefone? Algum,  
**Bruno Louzada:** Não,  
**Evelyn La:** algum software que Ah,  
**Bruno Louzada:** nessa época eu eu tava até com duas meninas trabalhando comigo. Agora eu tô tô sem nenhuma.  
**Evelyn La:** legal.  
**Bruno Louzada:** tinha uma SB e uma menina que era só secretária.  
**Evelyn La:** Achou. E aí ela que fazia o processo  
**Bruno Louzada:** Então é ela que fazia o processo,  
**Evelyn La:** ali.  
**Bruno Louzada:** conversava com os leads,  
**Evelyn La:** Uhum. Ah, legal.  
**Bruno Louzada:** certinho.  
**Evelyn La:** Ela tinha script, abordagem, coisas de eh processo padrão ou como que ela ela fazia do jeito  
**Bruno Louzada:** Então, eh,  
**Evelyn La:** dela?  
**Bruno Louzada:** a princípio, lá dentro da dessa empresa, eles tinham um curso para secretária também.  
**Evelyn La:** Uhum.  
**Bruno Louzada:** assim que eles eh ensinavam mais ou menos um babá assim, tipo um script mesmo.  
**Evelyn La:** Certo. E ela seguia o que eles faziam,  
**Bruno Louzada:** É,  
**Evelyn La:** então.  
**Bruno Louzada:** seguia seguia.  
**Evelyn La:** Ah, legal. E você,  
**Bruno Louzada:** É,  
**Evelyn La:** que que você sentia assim? sentia resultado, sentia realmente que ela seguia processou?  
   
 

### 00:25:00

   
**Bruno Louzada:** então, eu acho que isso depende um pouco da pessoa, né, que tá ali respondendo.  
**Evelyn La:** Uhum.  
**Bruno Louzada:** Tem gente que é mais proativa, responde, não sabe, aí fala: "Ah, eu vou falar com o doutor para ver se a gente te manda um áudio explicando melhor,  
**Evelyn La:** Uhum.  
**Bruno Louzada:** você tá com algum tal dúvida". Eh, e aí é mais, né? Aí tinha uma outra que, tipo assim, fazia o script e não fazia mais nada também, né?  
**Evelyn La:** Uhum.  
**Bruno Louzada:** Então tem que ser uma proatividade ali da pessoa, mas geralmente elas seguem o script, né?  
**Evelyn La:** Uhum, entendi.  
**Bruno Louzada:** Nós que somos os donos que faz um pouco a mais sempre,  
**Evelyn La:** Sempre, sempre. Ah, sim.  
**Bruno Louzada:** né?  
**Evelyn La:** A gente nada como um dono do seu próprio negócio para fazer acontecer, né? Eu vivi isso na pele. Se eu não levantasse,  
**Bruno Louzada:** É.  
**Evelyn La:** abria, eu falava que era minha lujinha, né? Porque era uma loja pequena, né? Não tinha um espaço tão grande. E e era um comércio mais popular também, porque era um produto mais popular. falou: "Se eu não levantasse,  
   
 

### 00:25:54

   
**Bruno Louzada:** Uhum.  
**Evelyn La:** não abrisse a minha porta, não vendia".  
**Bruno Louzada:** Não tinha  
**Evelyn La:** Então a gente sempre fazia,  
**Bruno Louzada:** venda.  
**Evelyn La:** mesmo com filho pequeno, mesmo correria, eu sempre nada como o dono para engord, como que diz? Nada como o dono nos olhos do dono pro boi engordar, né? Mas é isso. Entendi, Bruno. Então,  
**Bruno Louzada:** Eh,  
**Evelyn La:** hoje aí você tá mais nessa transição, né? Vou te explicar um pouquinho então agora sobre o que que é assistem digital e o quanto a gente conseguiria te ajudar nesse processo, tá?  
**Bruno Louzada:** certo.  
**Evelyn La:** Até mesmo o trabalho de fazer a o treino, né? treinar a pessoa, encontrar uma pessoa que seja mais qualificada para trabalhar e fazer o processo, a gente consegue te ajudar nisso. Então, acaba, a gente tem, vamos dizer assim, nós treinamos o seu time também e temos uma certa cobrança em cima do time e aí é uma coisa que ajuda muito a seguir processo, a seguir padrão.  
**Bruno Louzada:** Certo.  
**Evelyn La:** Por isso que eu falo sempre assim, a igual o paciente chega hoje pro Bruno querendo uma lipo, querendo um lifting ali sair com com o problema dele resolvido. Nós fazemos isso dentro da clínica, aceleramos o crescimento resolvendo essas questões porque o cirurgião muitas vezes não tem tempo, né?  
   
 

### 00:27:17

   
**Evelyn La:** Você quer perguntar alguma coisa? Fica à vontade.  
**Bruno Louzada:** Não.  
**Evelyn La:** Não. Ah, legal. Vamos lá. Eu vou te apresentar, vou fazer a minha apresentação aqui, como eu falei, vou até uma parte e aí eu vou porque espero contar aí com o seu sim ou com seu não, no sentido de Evelyn. Sim, faz sentido isso. Vamos dar sequência no próximo eh momento ou não, Evelyn? Não era o que eu almejava ou não é pro momento. Agora não me sinto no momento. E tá tudo bem. Posso contar com seu sim, com o seu não. Legal. Deixa eu compartilhar minha tela e você conhecer um pouquinho da System Digital e o nosso método Face sem K. Face sem K. Por quê? Porque a gente trabalha junto com o cirurgião para que no mínimo ele atinja esse faturamento aí no primeiro mês, tá? Então assim, não damos garantia. Olha, Bruna, eu vou garantir para você que você vai fazer 100k,  
**Bruno Louzada:** Claro, com  
**Evelyn La:** mas todos os entregáveis e todo o processo que a gente tem,  
**Bruno Louzada:** certeza.  
**Evelyn La:** a gente faz, né? A garantia que você vai ter toda a nossa entrega ali, a gente junto todos os dias, 24 horas por dia, no pé do seu time.  
   
 

### 00:28:32

   
**Evelyn La:** Inclusive, caso você precise contratar alguém, como eu falei, a gente vai treinar essa pessoa para que de fato você atinja aí um bom faturamento, né? Se for 100, ótimo. Se for menos, vai ser o começo, porque você vai tá iniciando realmente do zero,  
**Bruno Louzada:** Claro.  
**Evelyn La:** né? Mas a gente tem o método face sem cá, porque ah, quem entrou que tinha um pouco mais de estrutura no sentido assim, ah, eu já tinha uma secretária, já fazia uma coisa ou outra, bateu isso em, a gente tem caso aí de gente que bateu em duas semanas, uma semana, tem uma doutora que fez 160\. Então,  
**Bruno Louzada:** Deixa eu só te eh eu te perguntar uma coisa, Ev. Hoje, hoje que vocês estão trabalhando com esse, com esse agora é mais cirurgia da face que vocês mexem, né?  
**Evelyn La:** Sì.  
**Bruno Louzada:** Eh,  
**Evelyn La:** Uhum.  
**Bruno Louzada:** como que é o eh falando assim o linguajar claro assim, vocês acham que tem que tá instalado num lugar eh melhor de luxo ou começar mais no lugar mais simples mesmo, mais popular ou lógico que às vezes o lugar tudo, o ponto importa, né? Mas para começar,  
**Evelyn La:** Uhum.  
**Bruno Louzada:** o que que o que que vocês vê aí que vocês já  
   
 

### 00:29:51

   
**Evelyn La:** Certo.  
**Bruno Louzada:** analisaram?  
**Evelyn La:** Olha, para essa parte mais estética, é interessante sim você definir o público que você vá querer atingir. Então, por exemplo, vou te exemplificar aqui. Eh, a gente tem um valor médio de cirurgias. O médio que eu digo assim: "Ah, uma Lipo hoje vai tá um lift, independendo do lift, vai tá ali entre o quê? 8 a 10.000. Eh, uma bléforo vai tá entre 4 e 5, dependendo da região, mas por exemplo o Algarve ele vai cobra  
**Bruno Louzada:** Uhum.  
**Evelyn La:** 15,  
**Bruno Louzada:** É.  
**Evelyn La:** entendeu? Mas aí o que que tá o que que tá por trás disso? Todo o valor agregado, a ambiência, ou seja, o ambiente onde ele tá, o instituto dele e o público que ele atinge, porque ele focou em atingir um público mais high ticket, né? A classe A mais que a gente fala. Então, ah,  
**Bruno Louzada:** Uhum.  
**Evelyn La:** o serviço dele, tudo, ele é muito bom na técnica, tem os anos de experiência, OK? Tudo isso agrega valor para ele ter um ticket maior.  
**Bruno Louzada:** maior.  
**Evelyn La:** Mas aí vai depender o quê? Quem o Bruno quer atingir, quer começar por um lugar eh mais, vamos dizer assim, popular, mas não pode ser tão popular também.  
   
 

### 00:31:09

   
**Evelyn La:** Por quê? Porque tem que ter pacientes dispostos a pagar isso. E normalmente o paciente que é disposto a fazer e pagar entre 5 a 10.000 um procedimento estético, uma cirurgia, ele não vai ser uma classe tão baixa, tão popular, ele já vai tá entre um médio ali e alto.  
**Bruno Louzada:** Certo.  
**Evelyn La:** E aí o que que você precisa pensar hoje? a localidade do seu consultório, ele conversa com públicos assim ou você acredita que não tem público para conversar teu redor da região que você tá? Porque se você tem público que conversa eh eh contigo, né, no sentido assim, a localização do seu consultório hoje teria condição de, sei lá, ah, talvez eu precise eh melhorar a minha recepção, quem sabe, alguma coisa nesse sentido, mas conversaria com o público ou conseguiria trazer essas pessoas até mim? Ótimo. Agora, se você fica realmente numa localidade assim muito popular, que você não vai conseguir atingir essa média de ticket, aí é o caso de você pensar em mudar a localização,  
**Bruno Louzada:** Entendi.  
**Evelyn La:** tá? Porque daí eh tem que conversar quando a gente constrói a matriz de CP que a gente fala,  
**Bruno Louzada:** Entende?  
**Evelyn La:** que é a primeira coisa que a gente vai alinhar com você antes de rodar suas campanhas. Que que é isso?  
   
 

### 00:32:39

   
**Evelyn La:** definir o perfil ideal do seu cliente, então que faixa de valor de salário ele tem que ter mais ou menos para ele ter para investir numa bléfaro,  
**Bruno Louzada:** Entendi.  
**Evelyn La:** certo? Então tudo isso a gente alinha antes e desenha contigo. Aí isso você tem que no seu perfil,  
**Bruno Louzada:** M.  
**Evelyn La:** no seu posicionamento, tem que conversar com esse público. Então aí é o caso de você pensar como que está hoje o Bruno, como que está o posicionamento e como está o posicionamento até mesmo do consultório em si, tá?  
**Bruno Louzada:** Uhum.  
**Evelyn La:** Que tudo vai conversar. Se você mostra uma coisa na rede social e a pessoa chega e vê outra,  
**Bruno Louzada:** Já quebra aquele a confiança,  
**Evelyn La:** in confiança é incompluência  
**Bruno Louzada:** né, que é o primordial,  
**Evelyn La:** é. E aí se você mostra,  
**Bruno Louzada:** né?  
**Evelyn La:** se você tem algo às vezes presencial também, não sabe mostrar, perde conseguir novos pacientes. Então tem que alinhar tudo. É uma coisa que puxa a outra, sabe?  
**Bruno Louzada:** Uhum.  
**Evelyn La:** Hoje só fazer campanha não resolve. que nem a gente falou, a por isso, por que que nós não somos uma agência de tráfego pago? Nós somos uma aceleradora, porque não adianta só gerar demanda, que é o que a maioria das agências fazem hoje.  
   
 

### 00:33:58

   
**Evelyn La:** Elas geram um volume, te entregam um volume de lead lá na mão, se vira.  
**Bruno Louzada:** Aí que que você faz, né?  
**Evelyn La:** Então a gente não eh eh só entregar volume de lead não resolve, porque aquilo que você já teve de experiência, vem gente muito ruim, gente que não tem nada a ver, gente às vezes que tá em outro estado, sei lá, pega umas coisas meio  
**Bruno Louzada:** Isso não,  
**Evelyn La:** aleatória,  
**Bruno Louzada:** isso não, porque essa parte eles instruíam bem desestrutural,  
**Evelyn La:** bem. Ah, que bom, menos mal.  
**Bruno Louzada:** tipo assim, eh raio até quanto você tem que colocar. Eh, isso era bem definido, tipo assim, na campanha,  
**Evelyn La:** Ah,  
**Bruno Louzada:** entendeu?  
**Evelyn La:** legal.  
**Bruno Louzada:** Não vinha a gente tipo viajando lá de São Bernardo do Campo,  
**Evelyn La:** Isso.  
**Bruno Louzada:** não é?  
**Evelyn La:** Ah, não, fechou não. Menos  
**Bruno Louzada:** Tipo, é daqui mesmo. É, é,  
**Evelyn La:** mal.  
**Bruno Louzada:** é, é o meu público mesmo. É, é o meu raio aqui.  
**Evelyn La:** Ah, que bom. Porque a gente, inclusive, eu atendi um cirurgião que ele tava pagando para uma agência,  
**Bruno Louzada:** É.  
   
 

### 00:34:55

   
**Evelyn La:** ele era de São Paulo também ali de nossa, esqueci o nome da cidade agora, mas fica bem longe da de Barueri. Ele é de outro lugar. E ele tava vindo gente no tráfego pago entrando lá do Piauí, do Maranhão, no eu falei: "Nossa, essa agência tá fazendo um trabalho eh para não falar outra coisa,  
**Bruno Louzada:** Perfeito, né? Bon, Isso.  
**Evelyn La:** né?  
**Bruno Louzada:** M.  
**Evelyn La:** Então a gente faz o quê?" faz sim o trabalho de tráfego pago, faz a captação, porém com estratégia e te mostra o como você gerar a conversão de fato, que é o vender, né? Então assim, a gente ensina a vender e a pré-vender também. Que que é o método face sem carro? Vou te apresentar um pouquinho da nossa empresa. Hoje a gente tem 6 anos de expertise no mercado focado em cirurgiões da face com a a um modelo de captação, um modelo de negócio que visa o quê? captação qualificada e processos comerciais, porque uma coisa vai depender da outra, uma coisa eh vai puxar a outra. Precisa posicionamento, estratégia de marketing, funil rodando, demanda entrando e processo para conversão. Por quê? A secretária, por que que a gente treina o time pro cirurgião?  
   
 

### 00:36:10

   
**Evelyn La:** Porque a maioria das secretárias de 95%, elas acham que é só ser simpática e atender bem.  
**Bruno Louzada:** É.  
**Evelyn La:** E não é,  
**Bruno Louzada:** E não é.  
**Evelyn La:** não é a venda, o faturamento, a performance, ela vai vir de detalhes e processos. Então, não é só isso. Por isso que a gente focou em trabalhar isso junto com o cirurgião. Então, hoje o Renan, que é um dos sócios fundador, ele já tá há 5 anos gerindo times de de clínica de alta performance, já gerou mais de 15 milhões em vendas, é o nosso diretor hoje comercial e o Mateus é o nosso diretor estratégico. O Mateus foi o que te chamou ali pelo Instagram. Eh, o Mateus já tá há 7 anos nesse mercado e ele que é o responsável por montar todas essas estratégias, por alinhar a parte de posicionamento, marketing, estratégia de marketing. É o nosso é o nosso, o nosso CDF aqui, o nosso nerd, né? É o Mateus. E a Dra. Débora. A gente coloca ela aqui para mostrar que foi uma das nossas eh primeiras clientes, né? foi nosso das primeiras das nossas eh aceleradas aí e virou nossa embaixadora, inclusive porque ela tem uns resultados bem significativos.  
   
 

### 00:37:28

   
**Evelyn La:** A Débora batia 70.000 de faturamento o mês e depois dos nossos processos ela bateu 70.000 em uma semana.  
**Bruno Louzada:** Nossa\!  
**Evelyn La:** Aham.  
**Bruno Louzada:** E e ela é dentista e já faz cirurgião da face há bastante  
**Evelyn La:** Não, ela começou eh ela fazia bléforo,  
**Bruno Louzada:** tempo.  
**Evelyn La:** aí ela ela tinha até outras especialidades, mas ela não conseguia vender as especialidades em si. E aí a gente foi alinhando e foi montando com ela junto.  
**Bruno Louzada:** Ela é de São  
**Evelyn La:** Essa não,  
**Bruno Louzada:** Paulo,  
**Evelyn La:** a Débora é de eh acho que ela é Minas, se não me engano.  
**Bruno Louzada:** tá?  
**Evelyn La:** Se não me engano.  
**Bruno Louzada:** Depois vou ver para seguir ela para  
**Evelyn La:** É, é que ela ela já atendeu em São Paulo,  
**Bruno Louzada:** ver.  
**Evelyn La:** mas ela, acredito que ela é de Minas. A Débora. Esse foi um dos faturamentos da empresa que a gente realizou aí em um mês com as clínicas. a gente chegou a um resultado assim de de 1 milhão já faturados, alguns dos sonhos realizados dos sócios também. E o que que é a grande X da questão hoje, né? A gente encontra o mercado da maioria das clínicas ingessado sem processo comercial, ou seja, ou estagna o faturamento, fica no mês certo a estagnação.  
   
 

### 00:38:45

   
**Evelyn La:** Isso causa falta de previsibilidade nas vendas. E muito decorrência do quê? Não ter processo comercial, não saber seguir. Às vezes a pessoa tá há anos ali sendo secretária também da clínica, ela tem um processo com ela, se ela resolve sair, ela leva o processo com ela embora e aí começa tudo de novo, causa, né, esse essa desestabilização. E uma das coisas que tá sendo assim bem impactantes, principalmente assim do ano passado para cá, o lead ele tá cada vez mais caro, dependendo da campanha, dependendo tudo que você vá movimentar. Então, se não trabalha com estratégia para trazer qualificações, você só acaba queimando dinheiro ali, né? Então esse é um dos dos cenários que a gente encontra muito nas clínicas e é o que a gente ajuda de fato resolver, trazendo o quê? Estruturas e processos comerciais padrão,  
**Bruno Louzada:** Так.  
**Evelyn La:** pronto, já não precisa criar nada do zero, a gente já tem isso pronto para só seguir realmente e executar. Eh, trabalhamos com as estratégias, com o posicionamento, com a revenda para base, inclusive, que é uma estratégia que a gente chama de seios farm,  
**Bruno Louzada:** Угу.  
**Evelyn La:** que é a gente revender pro seu paciente. Então, por exemplo, você com os pacientes dos quais você já tem essa recorrência de faceta, a gente pode utilizar dessa mesma base para vender cirurgias faciais.  
   
 

### 00:40:10

   
**Evelyn La:** É, essa é uma das estratégias de protocolo de caixa rápido que a gente gera, que foi o que fez a Débora bater o 70 em uma semana, porque ela não fazia esse essa revenda,  
**Bruno Louzada:** Угу.  
**Evelyn La:** ela nunca tinha trabalhado ou mexido com isso, né? E aí quando a gente eh aplicou os protocolos, ela gerou caixa rapidinho. Então essa é uma das estratégias que a gente traz também é o que a gente fala,  
**Bruno Louzada:** Certo.  
**Evelyn La:** né? entendeu? O jogo te faz crescer e é o novo mercado realmente de clínicas. Muitas vezes a gente e o que que a gente traz, por que que é importante às vezes você buscar um direcionamento, uma empresa que vá ter o domínio, principalmente de processo comercial. Uma que o coração da empresa é o comercial, sem venda,  
**Bruno Louzada:** อ  
**Evelyn La:** sem faturamento, e outra que se você se arrisca a fazer muitas vezes sozinho, você acaba eh sobrecarregado, perdendo tempo, eh não tem tempo para pensar em outras estratégias,  
**Bruno Louzada:** Si  
**Evelyn La:** frustra,  
**Bruno Louzada:** frusta.  
**Evelyn La:** né? você acaba que você fica ali, eh, eu tenho que ser, tenho que me preocupar com o paciente, fazer a minha parte e ainda pensar em campanha de venda, então acaba sobrecarregando e não não conseguindo muito render, vamos dizer assim, né?  
   
 

### 00:41:29

   
**Evelyn La:** Então, a gente sempre diz, trazer essa paz mental pro empresário é o nosso papel, mostrar, trazer pronto, trabalhar as campanhas certas, tudo pronto já. eh fazer com que a empresa ande sozinha e aumente o seu LTV. Que o que que é o LTV? Ela é uma sigla inglês significa lifetime valory, ou seja, o quanto que esse paciente pode investir no Bruno, no serviços do Dr. Bruno. Então vamos lá, o mesma base daqueles que fizeram facetas, você pode fazer uma bléfaro, futuramente vender uma cérvico, futuramente e sabe o mesmo paciente. E é fazer, como que eu vou fazer isso? Como que eu aumento esse meu LTV? Primeiro tendo uma esteira de produtos claras, né? Ali uma clareza dos de todo o que o que você consegue somar na vida dessa pessoa e depois ir fazendo as revendas. E para isso tem que ter um quê? Um time comercial, né? é um time comercial que a gente fala assim, um uma secretária ali exclusiva para fazer todos os processos, trabalhar a base, trabalhar quem chega para que isso realmente seja eh escalável, né? Então esse é o nosso novo mercado,  
**Bruno Louzada:** M.  
**Evelyn La:** essa é a nossa parceria que a gente tem junto com as clínicas médicas.  
   
 

### 00:42:54

   
**Evelyn La:** Aqui é o sistema da system, né? é tudo que a gente trabalha com o cirurgião. Então, por exemplo, imagine que você é o seu o seu ecossistema, né? você está ali e a gente vai trabalhar essas etapas, esses pilares todos dentro do programa, ou seja, ah, vai ser feito funil de marketing comercial, tráfego pago, incluso incluindo a gestão de processo, protocolos de caixa rápido, produtos e ofertas, que aqui é a esteira que a gente constrói de produtos, ou seja, eh, o que que o Bruno hoje oferece? Ah, são as facetas e eu vou começar a oferecer a blefro, vou fazer o lifting, vou, sabe? E aí a gente vai criando essa esteira com você. Funil de vendas, os principais funil de vendas para rodar na tua empresa. O funil de pré-vendas, que é que entra o treinamento da secretária para ela entender que não é só ser simpática e marcar agendamento, tem todo um processo por trás para que de fato ocorra a venda, né? Então, a gente consegue te levar realmente para um nível mais profissional, eu diria, no sentido comercial da clínica, tá? Então, a gente aplica todos esses pilares junto com você, vai construindo isso, claro, não tudo de uma vez só.  
   
 

### 00:44:17

   
**Evelyn La:** E é importante ter alguém no seu time para te ajudar, porque essa parte mais maçante, operacional, para atender os leaders que vão chegar no funil, para fazer a a validação, validação não, mas para executar todo o nosso processo de base, trabalhar a sua base de pacientes que você já tem, ela vai ter, tem que ter uma pessoa ali toda hora para responder, para atender, para fazer ligação, né?  
**Bruno Louzada:** Certo.  
**Evelyn La:** E aí é importante ter esse esse volume aí até aqui eh sobre como a gente trabalha. Ficou alguma dúvida para você?  
**Bruno Louzada:** OK,  
**Evelyn La:** Tranquilo. Que que você achou sobre a empresa,  
**Bruno Louzada:** tranquilo.  
**Evelyn La:** sobre a credibilidade dos meninos até então? Você acredita que eh a gente conseguiria hoje atender você?  
**Bruno Louzada:** Então, eu acho que sim. É tipo assim, é uma mentoria paraa minha clínica para ela rodar e vender, né? É isso.  
**Evelyn La:** Isso a gente não se considera mentoria porque a mentoria ela não tem esse pegar na mão tão de perto e tão VIP, vamos dizer assim, porque a gente cuida, a gente tem o grupo exclusivo só com você e a equipe que cuida da sua empresa. A gente não tem uma coisa assim aonde  
**Bruno Louzada:** Vamos supor, você vai me atender,  
**Evelyn La:** normalmente  
   
 

### 00:45:38

   
**Bruno Louzada:** vamos supor, eu fecho aí, eu tô precisando de uma secretária nova, por exemplo, aí você vai cuidar para alguém treinar. É isso.  
**Evelyn La:** é Uhum. Aí a contratação é da sua responsabilidade,  
**Bruno Louzada:** Entendi.  
**Evelyn La:** né? Você vai fazer a contratação com a secretária,  
**Bruno Louzada:** Claro.  
**Evelyn La:** mas a partir do momento que ela está com você no seu time, nós vamos treinar ela, tá? E aí a gente vai junto com você,  
**Bruno Louzada:** Certo.  
**Evelyn La:** inclusive fazer o quê? Desenhar suas campanhas, alinhar o seu posicionamento, alinhar perfil, alinhar perfil de cliente ideal que você quer atender e atrair paraa sua clínica.  
**Bruno Louzada:** Uhum.  
**Evelyn La:** A gente vai fazer todo esse processo junto,  
**Bruno Louzada:** Certo.  
**Evelyn La:** tá? E a gente faz isso de que maneira? De forma bem personalizada, né? Não é, a maioria das mentorias, eles criam às vezes um grupo lá onde todo mundo entra junto ou entra numa sala, todo mundo junto e vai direcionando ali, faz um roleplay que a gente fala e tal, uma reunião hotsit e a gente não faz isso. A gente faz o quê? As tutorias e as reuniões elas são individuais com cada um que tá dentro do programa, tá?  
   
 

### 00:46:52

   
**Evelyn La:** Aqui, continuando um pouquinho sobre como que é a nossa metodologia,  
**Bruno Louzada:** Certo.  
**Evelyn La:** a gente tem o quê? Todos os funis de aquisição. Então, a gente trabalha diferentes funis de aquisição, ou seja, são todas portas de entrada de novos leads. Então, a gente trabalha anúncio, indicação, parceria e social selling. Você já ouviu falar sobre social selling?  
**Bruno Louzada:** Ja.  
**Evelyn La:** Já? E a gente trabalha bastante o seu shell e até mesmo a própria secretária que vai fazer os primeiros pré-venda, ela é treinada e ela pode executar essa parte do do social selling, prospectar pessoas ali no seu Instagram, conforme vai crescendo, conforme o teu volume vai aumentando de vendas e tudo, aí é interessante ter alguém só para isso, tá?  
**Bruno Louzada:** Hum, entendi.  
**Evelyn La:** conforme você vai evoluindo aqui é o treinamento do pré-vendas que a gente realiza, né? A gente sempre trabalha muito a mentalidade da secretária para ela entender que ela está fazendo uma venda de agendamento e não só agendo, agendando e sendo simpática, como eu falei, ela tem que necessariamente seguir passo a passo de followups. Que que é os followups, os retornos ali e tudo mais para evitar no show, ou seja, aquela pessoa que às vezes agenda, não quer comparecer ou esquece.  
   
 

### 00:48:10

   
**Evelyn La:** Então a gente minimiza isso, faz um controle tudo dentro de um CRM e trabalha modelo comercial um para atrair novos clientes, novos pacientes paraa clínica e trabalha toda todo o passo a passo ali  
**Bruno Louzada:** เ  
**Evelyn La:** de ful, todos os scripts a gente tem pronto. E o modelo dois que é para aqueles clientes de base. Então são dois modelos comerciais diferentes que a gente estrutura junto. E esses modelos aqui quem executa é a secretária, tá? E aí a gente treina ela nessa.  
**Bruno Louzada:** uma secretária que eu vou contratar só para fazer isso hoje. O qual é o salário em média?  
**Evelyn La:** Aí a gente sempre indica assim, ah, você trabalhar com ela uma proposta de comissionamento, inclusive, eh, vai tá ali entre um salário base de secretária, que acho que é um salário mínimo ali, no máximo até uns R$ 2.000. mais um comissionamento, porque aí o comissionamento é que vai estimular ela de fato a seguir todos os protocolos.  
**Bruno Louzada:** O comissionamento é se o paciente fechar ou se o paciente chegar até o  
**Evelyn La:** Isso não. Se ele fechar, se ele fechar,  
**Bruno Louzada:** consultório.  
**Evelyn La:** comissão, se ele não fechar, alguma coisa ela deixou de fazer ou algo aconteceu no meio do processo, que aí é onde a gente vai treinando ela justamente para ela entender isso, né?  
   
 

### 00:49:41

   
**Evelyn La:** Então, Bruno,  
**Bruno Louzada:** Entendi.  
**Evelyn La:** até eu seguiria com você até aqui para você entender sobre a nossa metodologia. E agora minha pergunta do sim ou não, se você gostaria da gente continuar eh avançar  
**Bruno Louzada:** Eu gostaria sim, mas eu queria saber questão de valores,  
**Evelyn La:** com  
**Bruno Louzada:** como que  
**Evelyn La:** certo pra gente falar sobre valor,  
**Bruno Louzada:** funciona?  
**Evelyn La:** que aí eu gostaria que a sua esposa tivesse junto, porque eu acredito que ela vai querer te dar uma opinião sobre isso, sabe? Aí seria interessante ela tá junto para quê?  
**Bruno Louzada:** Mhm.  
**Evelyn La:** Eh, se eu te passo valor hoje e você vai conversar com ela, ela provavelmente já vai te trazer uma objeção e falar: "Não, vai investir agora e não sei o quê". Então, para trazer ela pra reunião já ajuda a minimizar essa questão, né? Ela entender o processo até mesmo porquê. Eh, é um programa de 6 meses, tá? É um programa de se meses de acompanhamento. Ele vai ter bastante etapas ali, por isso que é primordial ter uma secretária para cumprir. E sem isso não tem como ter resultado. Então qualquer valor investido sem execução vai se tornar caro,  
**Bruno Louzada:** Entendi. Não, mas me fala porque daí eu já vou meio que conversar com ela.  
   
 

### 00:50:49

   
**Evelyn La:** tá?  
**Bruno Louzada:** Não é verdade, porque ela também é corrida. Aí, por exemplo, o horário que a gente vai estar junto não é nem horário  
**Evelyn La:** Certo?  
**Bruno Louzada:** comercial,  
**Evelyn La:** Mas aí você concorda que eh se a gente for querer fazer qualquer outra negociação depois vai acabar impactando?  
**Bruno Louzada:** não. Quanto iss pode ficar  
**Evelyn La:** Porque assim, se fosse dependesse só de você tomar a decisão, eu seguiria com você tranquilamente.  
**Bruno Louzada:** cegado.  
**Evelyn La:** Mas como de fato você vai precisar, quem sabe conversar com ela, aí eu sigo com você, vou até o final. E aí o que acontece? A gente tem dois tipos de valores. Valores para tomada de decisão em call, valores para depois que sai da call, para você não perder o melhor valor. Aí que eu gostaria que eu, por isso que eu insisto em trazer ela pra gente conversar.  
**Bruno Louzada:** Entendi. Eu vou conversar com ela e a gente marca,  
**Evelyn La:** Ótimo. Tá bom. Porque daí assim, ah,  
**Bruno Louzada:** tá bom?  
**Evelyn La:** se eu vou com você até o final, você fala: "Evre, não posso fechar hoje porque eu vou ter que conversar com ela". você vai perder o valor que seja talvez mais interessante pro momento. Você depois que você vi com ela, a gente, né, for até o final ali conversar,  
**Bruno Louzada:** Entendi.  
**Evelyn La:** ver valor, fechar, ótimo, maravilha. Você fala: "Evin, ainda assim não dá, tudo bem também". E aí fica um valor congelado para você por até 30 dias.  
**Bruno Louzada:** Tudo bem?  
**Evelyn La:** Tá bom?  
**Bruno Louzada:** Tá  
**Evelyn La:** Eu vou falar com a Laí,  
**Bruno Louzada:** ótimo.  
**Evelyn La:** foi a Laí que agendou contigo, que o Mateus passou para ela no seu contato do Insta e aí  
**Bruno Louzada:** Uhum.  
**Evelyn La:** ela vai fazer esse trâmite aí para pegar você e a esposa junto,  
**Bruno Louzada:** Tá bom.  
**Evelyn La:** tá bom? Se for se for necessário a gente agendar assim,  
**Bruno Louzada:** Obrigado.  
**Evelyn La:** por exemplo, depois do horário, um dia ali, para mim é tranquilo, dependendo como tiver a minha agenda,  
**Bruno Louzada:** Tá bom.  
**Evelyn La:** tá?  
**Bruno Louzada:** Tá.  
   
 

### A transcrição foi encerrada após 00:52:59

*Esta transcrição editável foi gerada por computador e pode conter erros. As pessoas também podem alterar o texto depois que ele for criado.*', '# ANÁLISE COMERCIAL COMPLETA - BRUNO LOUZADA

## 1. RESUMO EXECUTIVO

A call de vendas apresentou uma performance FRACA, com score de 5.2/10. A closer Evelyn iniciou bem com qualificação básica e diagnóstico superficial, mas falhou criticamente no controle da negociação ao aceitar passivamente a objeção de não decisão sem a esposa. A call durou ~53 minutos sem fechamento, apenas agendamento de segunda chamada. Bruno demonstrou interesse e capacidade financeira (fatura R$25-35k/mês), mas a vendedora perdeu oportunidades de aplicar pressão adequada e criar urgência real.

## 2. SCORECARD

| # | Dimensão | Peso | Nota | Ponderada | Evidência |
|---|----------|------|------|-----------|-----------|
| 1 | Frame | 8% | 6.0 | 0.48 | Estabeleceu autoridade inicial, mas perdeu controle na negociação |
| 2 | Qualificação | 10% | 7.0 | 0.70 | Descobriu faturamento, estrutura, dores básicas |
| 3 | Diagnóstico Quantitativo | 12% | 5.0 | 0.60 | Números superficiais, não explorou ROI potencial |
| 4 | Diagnóstico Qualitativo | 8% | 6.0 | 0.48 | Identificou transição de carreira e objetivos familiares |
| 5 | Consequência | 10% | 4.0 | 0.40 | Não explorou cenário de não mudança |
| 6 | Ensino | 5% | 7.0 | 0.35 | Boa explicação metodológica e diferenciação |
| 7 | Identidade | 5% | 5.0 | 0.25 | Apresentação pessoal longa demais, falta autoridade comercial |
| 8 | Ancoragem | 10% | 3.0 | 0.30 | Falhou ao não dar valores concretos quando solicitado |
| 9 | Isolamento | 10% | 3.0 | 0.30 | Cedeu imediatamente à objeção da esposa |
| 10 | Proporção Fala | 8% | 6.0 | 0.48 | Equilibrado, mas falou demais em momentos desnecessários |
| 11 | Promessas | 8% | 6.0 | 0.48 | Método Face 100K bem posicionado |
| 12 | Checkpoints | 3% | 5.0 | 0.15 | Poucos momentos de confirmação de entendimento |
| 13 | Fechamento | 3% | 2.0 | 0.06 | Não tentou fechamento real, aceitou segunda call passivamente |

**SCORE FINAL: 5.2/10 - CLASSIFICAÇÃO: FRACA**

## 3. TOP 5 ACERTOS

**1. Qualificação Estrutural Eficiente**
"Hoje você tem algum sócio na sua clínica? É só você? Você tem alguma secretária?" - Mapeou rapidamente a estrutura e identificou gaps operacionais.

**2. Descoberta de Motivação Familiar**
"Então, pensando nisso também na família... você tem que ter tempo para todo mundo" - Conectou-se com dor emocional real do prospect.

**3. Diferenciação Clara da Concorrência**
"A gente não é uma agência de tráfego pago, a gente trabalha como parceiros para acelerar crescimento" - Posicionamento claro de valor agregado.

**4. Validação de Capacidade Financeira**
Identificou faturamento de R$25-35k/mês e experiência prévia com investimento de R$3k/mês, qualificando poder de compra.

**5. Construção de Credibilidade Social**
Uso de case da Débora (70k para 70k em uma semana) e números de performance pessoal (2 milhões em 2025).

## 4. TOP 5 ERROS

**1. Falha Crítica no Isolamento (IMPACTO: ALTÍSSIMO)**
"Eu gostaria que a sua esposa tivesse junto" - Cedeu imediatamente à objeção ao invés de isolar e trabalhar a objeção. Perdeu a venda na hora.

**2. Não Ancoragem de Valores (IMPACTO: ALTO)**
"Não, mas me fala porque daí eu já vou meio que conversar com ela" - Quando Bruno pediu valores diretamente, ela recuou ao invés de ancorar e criar tensão.

**3. Ausência de Urgência Real (IMPACTO: ALTO)**
Não criou nenhum motivo convincente para decisão imediata, apenas mencionou "valores diferentes para call vs depois" sem substância.

**4. Diagnóstico Superficial de ROI (IMPACTO: MÉDIO)**
Não calculou retorno real: se ele fatura 35k/mês com resinas, quanto faturaria com cirurgias? Perdeu oportunidade de mostrar ROI explosivo.

**5. Apresentação Pessoal Excessiva (IMPACTO: BAIXO)**
~3 minutos de histórico pessoal desnecessário, incluindo detalhes irrelevantes sobre localização e hobbies.

## 5. REESCRITA DE MOMENTOS CRÍTICOS

**MOMENTO 1: Objeção da Esposa**
*Contexto: Bruno pede valores mas menciona que precisa falar com esposa*

**Original:** "Eu gostaria que a sua esposa tivesse junto, porque eu acredito que ela vai querer te dar uma opinião sobre isso"

**Reescrita:** "Bruno, entendo. Mas me ajuda aqui - você como empresário já tomou decisões de investimento de 5, 10 mil reais sozinho antes? E quando você decidiu fazer o curso com o Alexandre, ela participou da decisão?"

**Por quê:** Isola a objeção questionando o padrão de tomada de decisão dele, cria tensão e mantém controle da situação.

**Impacto:** Mantém a negociação viva e força o prospect a se posicionar como decisor.

---

**MOMENTO 2: Pedido de Valores**
*Contexto: Bruno pede valores diretamente*

**Original:** "Certo pra gente falar sobre valor, que aí eu gostaria que a sua esposa tivesse junto"

**Reescrita:** "Perfeito, Bruno. O investimento varia entre 15 e 35 mil dependendo do seu cenário. Mas antes de detalhar, me confirma: se eu te mostrar como sair dos seus 35k/mês atual para 100k em 90 dias, isso justificaria o investimento?"

**Por quê:** Ancora valor alto, cria contexto de ROI imediato e força confirmação de interesse antes de detalhar.

**Impacto:** Qualifica interesse real e estabelece expectativa de valor.

---

**MOMENTO 3: Construção de Urgência**
*Contexto: Final da apresentação, tentativa de agendar segunda call*

**Original:** "A gente tem dois tipos de valores. Valores para tomada de decisão em call, valores para depois que sai da call"

**Reescrita:** "Bruno, vou ser direto. Tenho apenas 3 vagas restantes para março e uma lista de espera de 12 dentistas. Se não fecharmos hoje, sua vaga vai para o próximo da fila. Isso é um problema?"

**Por quê:** Cria urgência real com escassez específica e força posicionamento imediato do prospect.

**Impacto:** Eleva a pressão para decisão imediata e testa comprometimento real.

## 6. PLANO DE AÇÃO 30 DIAS

**1. Treinamento de Isolamento de Objeções (PRIORIDADE: ALTA)**
*O que fazer:* Praticar 50 situações diferentes de objeção "preciso falar com cônjuge"
*Por que:* 80% das vendas perdidas são por falha no isolamento
*Como treinar:* Role-play diário com scenarios reais, gravação e análise

**2. Desenvolvimento de Ancoragem Progressiva (PRIORIDADE: ALTA)**
*O que fazer:* Criar scripts de ancoragem para diferentes perfis de prospect
*Por que:* Evitar perda de controle quando valores são questionados
*Como treinar:* Simulações com diferentes ranges de preço e objeções

**3. Criação de Urgência Autêntica (PRIORIDADE: ALTA)**
*O que fazer:* Desenvolver 5 motivos reais de escassez/urgência por produto
*Por que:* Necessário para fechamentos em primeira call
*Como treinar:* Testar diferentes approaches e medir taxa de conversão

**4. Aprimoramento do Diagnóstico ROI (PRIORIDADE: MÉDIA)**
*O que fazer:* Criar calculadora de ROI para diferentes cenários de dentista
*Por que:* Facilita justificativa do investimento com números concretos
*Como treinar:* Praticar cálculos ao vivo com prospects reais

**5. Redução da Apresentação Pessoal (PRIORIDADE: BAIXA)**
*O que fazer:* Limitar introdução pessoal a 60 segundos máximo
*Por que:* Mais tempo para qualificação e diagnóstico
*Como treinar:* Cronometrar apresentações e otimizar elementos essenciais

## 7. ANÁLISE DE SENTIMENTO DO LEAD

**Sentimento Geral:** Positivo - Bruno demonstrou interesse crescente e engajamento durante toda a call.

**Score de Engajamento:** 0.7 (alto interesse, participação ativa, perguntas qualificadas)

**Nível de Engajamento:** Alto - fez perguntas específicas sobre localização, salários, processos

**Timeline Emocional:**
- **Início (0-5min):** Neutro/Reservado (0.0) - Rapport inicial, ainda cauteloso
- **Qualificação (5-15min):** Positivo (0.5) - Compartilhando informações pessoais e profissionais
- **História pessoal (15-25min):** Neutro (0.1) - Educado mas desengajado durante apresentação pessoal longa
- **Apresentação método (25-40min):** Interessado (0.6) - Fazendo perguntas específicas, demonstrando entendimento
- **Discussão valores (40-50min):** Positivo/Ansioso (0.8) - Quer informações, pronto para próximo passo
- **Final (50-53min):** Positivo/Comprometido (0.7) - Aceita reagendamento, quer continuar processo

**Objeções Identificadas:**
- **Tipo: Processo** - "Preciso conversar com minha esposa" *(Handled: Mal manejada)*
- **Tipo: Timing** - "Ela também é corrida, horário não é comercial" *(Handled: Contornada)*
- **Tipo: Confiança** - "Queria saber questão de valores" *(Handled: Evitada ao invés de tratada)*', '🔴 AUDITORIA: Evelyn x Bruno Louzada
📅 2026-03-28 | ⏱ N/Amin
📊 Score: 5.2/10 — FRACA

✅ Top Acertos:
1. Qualificação Estrutural Eficiente
2. Descoberta de Motivação Familiar
3. Diferenciação Clara da Concorrência

❌ Top Erros:
1. Falha Crítica no Isolamento
2. Não Ancoragem de Valores
3. Ausência de Urgência Real', '[{"rank": 1, "title": "Falha Crítica no Isolamento", "description": "Cedeu imediatamente à objeção da esposa sem questionar padrão de decisão ou criar tensão. Perdeu controle total da venda"}, {"rank": 2, "title": "Não Ancoragem de Valores", "description": "Quando Bruno pediu valores diretamente, recuou ao invés de ancorar preços e trabalhar a objeção, perdendo momento crucial"}, {"rank": 3, "title": "Ausência de Urgência Real", "description": "Não criou motivos convincentes para decisão imediata, apenas mencionou ''valores diferentes'' sem substância convincente"}, {"rank": 4, "title": "Diagnóstico Superficial de ROI", "description": "Não calculou retorno específico: se fatura 35k com resinas, quanto faturaria com cirurgias? Perdeu oportunidade de ROI explosivo"}, {"rank": 5, "title": "Apresentação Pessoal Excessiva", "description": "Gastou ~3 minutos com histórico pessoal desnecessário incluindo localização e hobbies irrelevantes para a venda"}]'::jsonb, '[{"rank": 1, "title": "Qualificação Estrutural Eficiente", "description": "Mapeou rapidamente estrutura, sócios, funcionários e identificou gaps operacionais com perguntas diretas e eficazes"}, {"rank": 2, "title": "Descoberta de Motivação Familiar", "description": "Conectou-se com dor emocional real sobre tempo com família e equilibrio vida-trabalho, criando conexão genuína"}, {"rank": 3, "title": "Diferenciação Clara da Concorrência", "description": "Posicionou-se como aceleradora vs agência, explicando valor agregado e diferencial competitivo de forma clara"}, {"rank": 4, "title": "Validação de Capacidade Financeira", "description": "Identificou faturamento R$25-35k/mês e histórico de investimento R$3k/mês, qualificando poder de compra adequadamente"}, {"rank": 5, "title": "Construção de Credibilidade Social", "description": "Usou cases específicos como Débora (70k para 70k em semana) e números próprios (2M em 2025) para gerar confiança"}]'::jsonb, '[{"rank": 1, "title": "Treinamento de Isolamento de Objeções", "por_que": "80% das vendas perdidas são por falha no isolamento", "prioridade": "alta", "o_que_fazer": "Praticar 50 situações diferentes de objeção ''preciso falar com cônjuge''", "como_treinar": "Role-play diário com scenarios reais, gravação e análise"}, {"rank": 2, "title": "Desenvolvimento de Ancoragem Progressiva", "por_que": "Evitar perda de controle quando valores são questionados", "prioridade": "alta", "o_que_fazer": "Criar scripts de ancoragem para diferentes perfis de prospect", "como_treinar": "Simulações com diferentes ranges de preço e objeções"}, {"rank": 3, "title": "Criação de Urgência Autêntica", "por_que": "Necessário para fechamentos em primeira call", "prioridade": "alta", "o_que_fazer": "Desenvolver 5 motivos reais de escassez/urgência por produto", "como_treinar": "Testar diferentes approaches e medir taxa de conversão"}, {"rank": 4, "title": "Aprimoramento do Diagnóstico ROI", "por_que": "Facilita justificativa do investimento com números concretos", "prioridade": "média", "o_que_fazer": "Criar calculadora de ROI para diferentes cenários de dentista", "como_treinar": "Praticar cálculos ao vivo com prospects reais"}, {"rank": 5, "title": "Redução da Apresentação Pessoal", "por_que": "Mais tempo para qualificação e diagnóstico", "prioridade": "baixa", "o_que_fazer": "Limitar introdução pessoal a 60 segundos máximo", "como_treinar": "Cronometrar apresentações e otimizar elementos essenciais"}]'::jsonb, '[]'::jsonb, '[{"impact": "Mantém negociação viva e força prospect a se posicionar como decisor", "reason": "Isola a objeção questionando padrão de decisão dele, cria tensão e mantém controle", "original": "Eu gostaria que a sua esposa tivesse junto, porque eu acredito que ela vai querer te dar uma opinião sobre isso", "rewritten": "Bruno, entendo. Mas me ajuda aqui - você como empresário já tomou decisões de investimento de 5, 10 mil reais sozinho antes? E quando decidiu fazer o curso com Alexandre, ela participou?", "description": "Momento crítico da objeção da esposa"}, {"impact": "Qualifica interesse real e estabelece expectativa de valor adequada", "reason": "Ancora valor alto, cria contexto de ROI e força confirmação antes de detalhar", "original": "Certo pra gente falar sobre valor, que aí eu gostaria que a sua esposa tivesse junto", "rewritten": "Perfeito Bruno. O investimento varia entre 15 e 35 mil dependendo do seu cenário. Mas me confirma: se te mostrar como sair dos 35k atuais para 100k em 90 dias, isso justificaria?", "description": "Pedido direto de valores pelo prospect"}, {"impact": "Eleva pressão para decisão imediata e testa comprometimento real", "reason": "Cria urgência real com escassez específica e força posicionamento imediato", "original": "A gente tem dois tipos de valores. Valores para tomada de decisão em call, valores para depois que sai da call", "rewritten": "Bruno, vou ser direto. Tenho apenas 3 vagas restantes para março e lista de espera de 12 dentistas. Se não fecharmos hoje, sua vaga vai pro próximo. Isso é problema?", "description": "Tentativa de criar urgência no final"}]'::jsonb, '{}'::jsonb, '[]'::jsonb, NULL, NULL, NULL, NULL, NULL, 'whisper-1', 'claude-sonnet-4-20250514', 20404, 5076, 0.1374, '2026-03-28T00:17:42.428175+00:00', NULL, '2026-03-28T17:22:41.21+00:00', '2026-03-28T17:30:54.513282+00:00', '2026-03-28T17:30:54.513282+00:00', '2026-03-28T00:17:42.428175+00:00', '2026-03-28T17:30:54.513282+00:00', 'positive', '[{"moment": "Rapport inicial, ainda cauteloso e reservado", "period": "Início", "sentiment": "neutro", "confidence": 0.8}, {"moment": "Compartilhando informações pessoais e profissionais abertamente", "period": "Qualificação", "sentiment": "positivo", "confidence": 0.5}, {"moment": "Educado mas desengajado durante apresentação pessoal longa", "period": "História pessoal", "sentiment": "neutro", "confidence": 0.1}, {"moment": "Fazendo perguntas específicas, demonstrando entendimento real", "period": "Apresentação método", "sentiment": "interessado", "confidence": 0.6}, {"moment": "Quer informações concretas, pronto para próximo passo", "period": "Discussão valores", "sentiment": "positivo", "confidence": 0.8}, {"moment": "Aceita reagendamento e quer continuar o processo", "period": "Final", "sentiment": "comprometido", "confidence": 0.7}]'::jsonb, 0.7, 'high', '[{"text": "Preciso conversar com minha esposa", "type": "processo", "handled": false}, {"text": "Ela também é corrida, horário não é comercial", "type": "tempo", "handled": true}, {"text": "Queria saber questão de valores", "type": "confiança", "handled": false}]'::jsonb, '2.0', NULL, NULL);


-- Removed: matching ENABLE no longer needed.