class QuizController {
  static List<Map> questoes = [
    {},
    {
      'Pergunta 1': {
        'enunciado':
            'Quanto tempo devemos praticar de exercícios físicos por semana para ter benefícios?',
        'correto': '150 minutos.',
        'alternativas': [
          '150 minutos.',
          '30 minutos.',
          '60 minutos.',
          '100 minutos.'
        ],
      },
    },
    {
      'Pergunta 2': {
        'enunciado': 'Assinale a alternatica que não é um exercício físico.',
        'correto': 'Video Game.',
        'alternativas': [
          'Corrida.',
          'Caminhada.',
          'Musculação.',
          'Video Game.'
        ],
      },
    },
    {
      'Pergunta 3': {
        'enunciado':
            'O principal benefício da corrida em relação a outros esportes é a independência, ou melhor, evoluir depende essencialmente de você. Assinale a alternativa que não corresponde a um benefício de praticar corrida.',
        'correto': 'Aumento do estresse e cansaço.',
        'alternativas': [
          'Melhoria no sono.',
          'Aumento do estresse e cansaço.',
          'Reduz gordura corporal.',
          'Combate a depressão.'
        ],
      }
    }
  ];
}
