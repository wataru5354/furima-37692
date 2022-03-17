function price(){
  const price = document.getElementById("item-price")

  price.addEventListener('keyup',() =>{
    const taxPrice = document.getElementById("add-tax-price");
    const profit = document.getElementById("profit");
    const priceNum = price.value ; //priceにて入力された値

    taxPrice.innerHTML = `${String(Math.floor(priceNum * 0.1)).replace(/(\d)(?=(\d\d\d)+(?!\d))/g, '$1,')} `;

    const taxPriceNum = taxPrice.innerText.replace(/,/g, ''); //taxPriceが出た値にカンマを取り除く
    profit.innerHTML = `${String(priceNum - parseInt(taxPriceNum, 10)).replace(/(\d)(?=(\d\d\d)+(?!\d))/g, '$1,')}`;
  });
};
window.addEventListener('load', price);