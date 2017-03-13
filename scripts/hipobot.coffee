module.exports = (hipobot) ->
  
  hipobot.hear /hello?/i, (res) ->
    # your code here
    res.send 'Yes?'

  hipobot.hear /saleprice of (.*)/i, (res) ->
    # your code here
    capture = res.match[1]
    salePrice = parseInt(capture)
    tasacion = hipobot.brain.get 'tasacion'
    if !tasacion || tasacion == 0 
      tasacion = 0.2
    valorTasacion = salePrice + (salePrice * tasacion)
    hipobot.brain.set 'valorTasacion', valorTasacion
    gastos = (valorTasacion * 0.15);
    totalCost = (salePrice + gastos);
    lessAhorros = (totalCost - 30000)
    balance = (salePrice - lessAhorros)
    res.reply "The valor tasacion maybe around #{valorTasacion} " + (tasacion * 100) + "%, the gastos will be around #{gastos} meaning the total cost will be " + totalCost + ". Less our ahorros is " + lessAhorros + ". Meaning we are short " + balance

  hipobot.respond /set tasacion at (.*)/i, (res) ->
    # Save tasacion
    capture = res.match[1]
    tasacion = Number(capture)
    hipobot.brain.set 'tasacion', tasacion
    res.reply 'Tasacion markup set as ' + (tasacion * 100) + "%"

