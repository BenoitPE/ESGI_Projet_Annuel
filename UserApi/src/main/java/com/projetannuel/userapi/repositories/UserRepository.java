package com.projetannuel.userapi.repositories;
import com.projetannuel.userapi.entities.User;
import org.springframework.stereotype.Repository;
import org.springframework.data.jpa.repository.JpaRepository;

@Repository
public interface UserRepository extends JpaRepository<User, String> {
    User findByUsernameAndPassword(String username, String password);
    User findByIdUser(Integer IdUser);
}

