from quart import Quart                                                                                                                                                                                     
                                                                                                                                                                                                            
app = Quart(__name__)                                                                                                                                                                                       
                                                                                                                                                                                                            
                                                                                                                                                                                                            
@app.route("/user_manager", defaults={"department": 0, "division": 0, "search": None}, methods=['GET', 'POST'])                                                                                             
@app.route("/user_manager/<int:department>", defaults={"division": 0, "search": None}, methods=['GET', 'POST'])                                                                                               
@app.route("/user_manager/<int:department>/<int:division>", defaults={"search": None}, methods=['GET', 'POST'])                                                                                                 
@app.route("/user_manager/<int:department>/<int:division>/", methods=['GET', 'POST'])                                                                                                                           
async def index():                                                                                                                                                                                          
    return ""                                                                                                                                                                                               
                                                                                                                                                                                                            
app.run()
