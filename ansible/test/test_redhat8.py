import unittest
import testinfra


class Test(unittest.TestCase):

    def setUp(self):
        self.host = testinfra.get_host("local://", sudo=True)
        # self.host = testinfra.get_host("paramiko://localhost")
        # self.host = testinfra.get_host("paramiko://bastion:admin@3.35.172.16:22")


    def tearDown(self) -> None:
        return super().tearDown()


    def test_exist_account_group(self):
        bastion_user = self.host.user("bastion")
        wheel = self.host.group("wheel")
        bastion = self.host.group("bastion")
        
        self.assertTrue(wheel.exists)
        self.assertTrue(bastion.exists)
        self.assertTrue(bastion_user.exists)

    def test_enable_and_running_system_daemon(self):
        chrony = self.host.service("chronyd")
        self.assertTrue(chrony.is_running)
        self.assertTrue(chrony.is_enabled)


if __name__ == "__main__":
    unittest.main()

