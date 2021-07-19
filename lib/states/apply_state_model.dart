

import 'package:flutter/foundation.dart';
import 'package:registration_staff/dataobj/apply_repo_entity.dart';

import 'apply_repo.dart';

class ApplyStateModel extends ChangeNotifier{

  bool _allState = false;
  bool _waitState = false;
  bool _acceptState = false;
  bool _cancelState = false;

  ApplyRepo _applyRepo = new ApplyRepo();
  List<ApplyRepoEntity> _allList ;
  List<ApplyRepoEntity> _waitList;
  List<ApplyRepoEntity> _acceptList;
  List<ApplyRepoEntity> _cancelList;

  List<ApplyRepoEntity> get allList => _allList;
  List<ApplyRepoEntity> get waitList => _waitList;
  List<ApplyRepoEntity> get acceptList => _acceptList;
  List<ApplyRepoEntity> get cancelList => _cancelList;

  get state => _allState&&_waitState&&_acceptState&&_cancelState;
  get hasAll => _allState;
  get hasWait => _waitState;
  get hasAccept => _acceptState;
  get hasCancel => _cancelState;


  init(userID) async{
    print("ApplyStateModel init exec");
    try{
      if(userID != -1){
        _allList = await _applyRepo.getAllList(userID);
        _allState =true;
        _acceptList = await _applyRepo.getAcceptList(userID);
        _acceptState = true;
        _waitList = await _applyRepo.getWaitList(userID);
        _waitState = true;
        _cancelList = await _applyRepo.getCancelList(userID);
        _cancelState = true;
      }


      notifyListeners();
    }catch(error){
      print("ApplyStateModel init eeror"+error.toString());
    }
  }




}