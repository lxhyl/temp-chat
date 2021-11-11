const addZero = n => n > 9 ? n : `0${n}`
function format(date){
  const dt = new Date(date)
  const y = dt.getFullYear(),
        m = addZero(dt.getMonth() + 1),
        d = addZero(dt.getDate()),
        h = addZero(dt.getHours()),
        mi = addZero(dt.getMinutes()),
        s = addZero(dt.getSeconds())
  return `${y}/${m}/${d} ${h}:${mi}:${s}`
}


export default format