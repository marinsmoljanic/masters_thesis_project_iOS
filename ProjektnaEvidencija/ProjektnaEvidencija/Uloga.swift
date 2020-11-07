import Foundation

class Uloga
{
    var IdUloge: Int = 0
    var NazUloge: String = ""
    
    init(IdUloge:Int, NazUloge:String)
    {
        self.IdUloge = IdUloge
        self.NazUloge = NazUloge
    }
    
    
    func getIdUloge() -> Int{
        return self.IdUloge
    }
    func setIdUloge(idUloge: Int){
        self.IdUloge = idUloge
    }
    
    func getNazUloge() -> String{
        return self.NazUloge
    }
    func setNazUloge(nazUloge: String){
        self.NazUloge = nazUloge
    }
    
}
