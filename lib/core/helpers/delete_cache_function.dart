import 'package:el_erinat/features/admin/data/sorce_data_admin/admin_local_data_base_helper.dart';
import 'package:workmanager/workmanager.dart';

void deleteCacheFromLocalDataBase() {
  Workmanager().executeTask((task, inputData) async {
    await AdminLocalDatabaseHelper.adminLocalDatabaseHelper
        .adminDeleteOldEntries();
    return Future.value(true);
  });
}
